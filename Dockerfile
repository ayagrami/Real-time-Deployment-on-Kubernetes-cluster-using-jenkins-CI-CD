# Utilisation de CentOS Stream 9
FROM quay.io/centos/centos:stream9

# Ajout d'un label au lieu de MAINTAINER
LABEL maintainer="ayagrami.15@gmail.com"

# Mise à jour, installation des paquets nécessaires et nettoyage
RUN yum install -y httpd zip unzip curl && \
    yum clean all

# Définition du répertoire de travail
WORKDIR /var/www/html/

# Téléchargement et extraction du fichier ZIP
RUN curl -L -o photogenic.zip https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip && \
    unzip photogenic.zip && \
    cp -rvf photogenic/* . && \
    rm -rf photogenic photogenic.zip

# Exposition du port 80
EXPOSE 80

# Vérification de l'état du serveur Apache
HEALTHCHECK --interval=30s --timeout=10s \
    CMD curl -f http://localhost || exit 1

# Lancement d'Apache
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
