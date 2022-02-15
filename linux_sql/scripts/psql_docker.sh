#! /bin/sh

cmd=$1
db_username=$2
db_password=$3

sudo systemctl status docker || sudo systemctl start docker

container_status=$(docker ps -a | grep jrvs-psql | wc -l)
case $cmd in
  create)
  if [ $container_status -ge 1 ]; then
		echo 'Container already exists'
		exit 0
	fi

  if [ $# -ne 3 ]; then
    echo 'Create requires username and password'
    exit 1
  fi

	docker volume create pgdata
	docker run --name jrvs-psql -e POSTGRES_PASSWORD=$db_password -u $db_username -d -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres:9.6-alpine
	exit $?
	;;

  start|stop)
  if [ $container_status -eq 0 ]; then
    echo "Instance not created yet"
    exit 1
  fi

	docker container $cmd jrvs-psql
	exit $?
	;;

  *)
	echo 'Illegal command'
	echo 'Commands: start|stop|create'
	exit 1
	;;
esac