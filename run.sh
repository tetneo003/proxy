#!/bin/sh -e
ngrok config add-authtoken 28QPxo5JqoV6wWKid3GSuD79X7j_4WttKmnxxvcGCy2BF9uEk
ngrok tcp 8080 &
/usr/local/tomcat/bin/catalina.sh run > /dev/null


