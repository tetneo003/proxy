
FROM ubuntu:latest
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install openjdk-8-jdk wget curl ca-certificates
RUN mkdir /usr/local/tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.16/bin/apache-tomcat-8.5.16.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.16/* /usr/local/tomcat/
RUN rm -rf /usr/local/tomcat//webapps/examples && rm -rf /usr/local/tomcat/webapps/docs && rm -rf /usr/local/tomcat/webapps/ROOT

ADD ROOT.war /usr/local/tomcat/webapps/

RUN sed -i 's/port="8080"/port="80"/' /usr/local/tomcat/conf/server.xml

RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | tee /etc/apt/sources.list.d/ngrok.list && apt update && apt install ngrok

COPY run.sh /

RUN chmod +x /run.sh

EXPOSE 80
EXPOSE 3128

ENTRYPOINT ["/run.sh"]

#CMD ["sh", "-c", "/usr/local/tomcat/bin/catalina.sh run > /dev/null & && ngrok config add-authtoken 28QPxo5JqoV6wWKid3GSuD79X7j_4WttKmnxxvcGCy2BF9uEk > /dev/null & && ngrok tcp 8080 > /dev/null &"]
#CMD /usr/local/tomcat/bin/catalina.sh run
