FROM tomcat:latest

COPY ABCtechnologies-1.0.war /usr/local/tomcat/webapps/
COPY index.html /usr/local/tomcat/webapps/ROOT/

CMD [ "catalina.sh", "run"]