# Use the latest Tomcat image available
FROM tomcat:latest

# Switch to root user to install dependencies (only if needed)
USER root

# Install wget and unzip if necessary, then clean up to keep the image small
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Copy your application WAR file into the Tomcat webapps directory
COPY ABCtechnologies-1.0.war /usr/local/tomcat/webapps/

# Set permissions for the WAR file
RUN chown -R root:root /usr/local/tomcat/webapps

# Expose port 8080 for Tomcat to listen on
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
