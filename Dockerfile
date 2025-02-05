FROM tomcat:9.0-jdk17
COPY target/web.war /usr/local/tomcat/webapps/app.war
