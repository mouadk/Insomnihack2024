FROM tomcat:9.0.59-jdk11
# Tomcat 9.0.62 has been hardened
COPY /target/exploit.war /usr/local/tomcat/webapps/

RUN mkdir -p /opt/agent
RUN wget -P /opt/agent 'https://repo1.maven.org/maven2/com/contrastsecurity/contrast-agent/6.0.0/contrast-agent-6.0.0.jar'

# Set environment variables if needed, such as JAVA_OPTS or CATALINA_OPTS
ENV JAVA_OPTS="-javaagent:/opt/agent/contrast-agent-6.0.0.jar -Dcontrast.config.path=/opt/agent/contrast-config.yaml"
ENV CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:8000"


EXPOSE 8080
CMD ["catalina.sh", "run"]
