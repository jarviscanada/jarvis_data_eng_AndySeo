#! /bin/sh

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#assign CLI arguments to variables (e.g. `psql_host=$1`)
if [ $# -ne 5 ]; then
  echo "Need more arguments"
  exit 1
fi

#parse host hardware specifications using bash cmds
hostname=$(hostname -f)
memory_free=$(cat /proc/meminfo | egrep "^MemFree" | awk '{print $2}')
cpu_idle=$(vmstat --unit M|awk 'FNR == 3{print $15}')
cpu_kernel=$(vmstat --unit M|awk 'FNR == 3{print $14}')
disk_io=$(vmstat -d | awk 'FNR == 3{print $10}')
disk_available=$(df -BM|awk '{s+=$4} END {print s}')
timestamp=$(vmstat --unit M -t|awk 'FNR == 3{print $18,$19}'| xargs)
#- construct the INSERT statement
host_id="(SELECT id FROM host_info WHERE hostname='$hostname')";
insert_stmt="INSERT INTO host_usage(timestamp,host_id,memory_free,cpu_idle,cpu_kernel,disk_io,disk_available) VALUES ('$timestamp',$host_id,'$memory_free','$cpu_idle','$cpu_kernel','$disk_io','$disk_available')"

#- execute the INSERT statement through psql CLI tool
export PGPASSWORD=$psql_password
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"