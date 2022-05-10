#!/bin/sh -e
/usr/local/tomcat/bin/catalina.sh run > /dev/null
ngrok config add-authtoken 28QPxo5JqoV6wWKid3GSuD79X7j_4WttKmnxxvcGCy2BF9uEk > /dev/null
ngrok tcp 8080 > /dev/null


