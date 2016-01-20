#!/bin/sh

#monitor() {
#    while read i
#    do
#        echo $i
#        echo $i | grep -q "Error"
#        if [ $? = "0" ];then
#            echo $i
#            docker restart $(docker-compose ps -q crash)
#            break
#        fi
#    done
#}
#
#docker logs -f $(docker-compose ps -q crash) | monitor

while :
do
    echo `docker logs $(docker-compose ps -q crash) | tail -n 1`
    if echo `docker logs $(docker-compose ps -q crash) | tail -n 1` | grep -q "Error"; then
        echo "OK"
        docker restart $(docker-compose ps -q crash)
    fi
    sleep 1
done