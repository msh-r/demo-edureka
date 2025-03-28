# Use the latest Tomcat image
FROM tomcat:latest

# Switch to root user to install dependencies
USER root

# Install required dependencies
RUN apt update && apt install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Download and extract the default Tomcat ROOT application
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-11/v11.0.5/bin/apache-tomcat-11.0.5.zip \
    && unzip apache-tomcat-11.0.5.zip \
    && mv apache-tomcat-11.0.5/webapps/ROOT /usr/local/tomcat/webapps/ \
    && rm -rf apache-tomcat-11.0.5*

# Copy your application WAR file (ABCtechnologies-1.0.war)
COPY ABCtechnologies-1.0.war /usr/local/tomcat/webapps/

# Copy your custom index.html into ROOT without deleting existing files
#COPY index.html /usr/local/tomcat/webapps/ROOT/

# Set correct permissions
RUN chown -R tomcat:tomcat /usr/local/tomcat/webapps

# Switch back to Tomcat user for security
USER tomcat

# Expose port 8080 for Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]