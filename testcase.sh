for i in `seq 1 5`
do
    echo "Loop $i"
    curl -X GET $(docker-machine ip default)
    curl -X GET $(docker-machine ip default)/factorial/100
    curl -X GET $(docker-machine ip default)/fibonacci/100
    sleep 1
done