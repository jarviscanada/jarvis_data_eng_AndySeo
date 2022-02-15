#! /bin/sh

psql_host=$1
psql_port=$2
db_name=$3
psql_user=$4
psql_password=$5

#assign CLI arguments to variables (e.g. `psql_host=$1`)
if [ $# -ne 5 ]; then
  echo "Need 5 arguments"
  exit 1
fi

#parse host hardware specifications using bash cmds
lscpu_out=`lscpu`
hostname=$(hostname -f)
cpu_number=$(echo "$lscpu_out"  | egrep "^CPU\(s\):" | awk '{print $2}' | xargs)
cpu_architecture=$(echo "$lscpu_out"  | egrep "^Architecture" | awk '{print $2}' | xargs)
cpu_model=$(echo "$lscpu_out"  | egrep "^Model name: " | awk '{print $3,$4,$5,$6,$7}' | xargs)
cpu_mhz=$(echo "$lscpu_out"  | egrep "^CPU MHz" | awk '{print $3}' | xargs)
L2_cache=$(echo "$lscpu_out"  | egrep "^L2 cache" | awk '{print $3}' | xargs | sed 's/.$//')
total_mem=$(cat /proc/meminfo | egrep "^MemTotal" | awk '{print $2}'| xargs)
timestamp=$(vmstat --unit M -t|awk 'FNR == 3{print $18,$19}'| xargs)
#- construct the INSERT statement
insert_stmt="INSERT INTO host_info(hostname, cpu_number,cpu_architecture,cpu_model,cpu_mhz,L2_cache,total_mem,timestamp) VALUES ('$hostname', '$cpu_number','$cpu_architecture','$cpu_model','$cpu_mhz','$L2_cache','$total_mem','$timestamp')"

#- execute the INSERT statement through psql CLI tool
export PGPASSWORD=$psql_password
psql -h $psql_host -p $psql_port -d $db_name -U $psql_user -c "$insert_stmt"
exit $?