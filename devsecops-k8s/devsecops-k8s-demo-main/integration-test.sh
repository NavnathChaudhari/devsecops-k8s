#!/bin/bash

#integration-test.sh

sleep 5s

PORT=$(kubectl -n default get svc devsecops-svc -o json | jq .spec.ports[].nodePort)

echo $PORT
echo 192.168.184.163:$PORT

if [[ ! -z "$PORT" ]];
then

    http_code=$(curl -s -o /dev/null -w "%{http_code}" 192.168.184.163:30000)


    if [[ "$http_code" == 200 ]];
        then
            echo "HTTP Status Code Test Passed"
        else
            echo "HTTP Status code is not 200"
            exit 1;
    fi;

else
        echo "The Service does not have a NodePort"
        exit 1;
fi;
