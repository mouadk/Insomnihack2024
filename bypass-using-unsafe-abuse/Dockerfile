FROM tomcat:9.0.59-jdk11
# Tomcat 9.0.62 has been hardened
COPY target/exploit.war /usr/local/tomcat/webapps/

RUN mkdir -p /opt/agent
COPY rasp-agent/target/rasp-agent-1.0.0-SNAPSHOT.jar /opt/agent/
ENV JAVA_OPTS="-javaagent:/opt/agent/rasp-agent-1.0.0-SNAPSHOT.jar"

EXPOSE 8080
CMD ["catalina.sh", "run"]