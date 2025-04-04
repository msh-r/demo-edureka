# Use an Alpine-based Tomcat image with JDK 11 (widely used and stable)
FROM tomcat:9-jdk11-openjdk-alpine

# Switch to root user to install dependencies (only if needed)
USER root

# Install wget and unzip if necessary, then clean up to keep the image small
RUN apk update && apk add --no-cache wget unzip && rm -rf /var/cache/apk/*

# Copy your application WAR file into the webapps directory of Tomcat
COPY ABCtechnologies-1.0.war /usr/local/tomcat/webapps/

# Set permissions for the WAR file
RUN chown -R root:root /usr/local/tomcat/webapps

# Expose port 8080 for Tomcat to listen on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
