FROM quay.io/centos/centos:stream9

LABEL maintainer="ayagrami.15@gmail.com"

RUN dnf install -y httpd zip unzip curl && \
    dnf clean all

WORKDIR /var/www/html/

RUN curl -L -o photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
    unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
