FROM centos:latest

LABEL maintainer="ayagrami.15@gmail.com"

# Install required packages using dnf (or yum for CentOS 7)
RUN dnf install -y httpd zip unzip && \
    dnf clean all

# Download and extract the website template
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/

# Set the working directory
WORKDIR /var/www/html/

# Unzip the downloaded template and clean up unnecessary files
RUN unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Expose port 80
EXPOSE 80

# Command to run the Apache HTTP server in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
