FROM quay.io/centos/centos:stream9

LABEL maintainer="ayagrami.15@gmail.com"

# Ajout du dépôt EPEL et installation des paquets
RUN yum install -y epel-release && \
    yum install -y httpd zip unzip curl && \
    yum clean all

WORKDIR /var/www/html/

RUN curl -L -o photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
    unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=10s \
    CMD curl -f http://localhost || exit 1

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
