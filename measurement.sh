#!/bin/bash


for i in {1..10}
do
    #docker run -dit ubuntu /bin/bash -c "while true; do echo hello world; sleep 1; done"
    (time docker-compose restart router) >> reboot.log
done