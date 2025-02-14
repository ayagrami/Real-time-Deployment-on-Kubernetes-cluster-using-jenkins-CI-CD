FROM centos:stream8
MAINTAINER ayagrami.15@gmail.com

# Mise à jour des dépôts et installation des paquets nécessaires
RUN sed -i 's|mirrorlist.centos.org|vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo && \
    yum clean all && yum makecache && \
    yum install -y httpd zip unzip && \
    yum clean all

# Téléchargement et extraction du fichier ZIP
WORKDIR /var/www/html/
RUN curl -L -o photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
    unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Exposition du port 80 et lancement d'Apache
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
