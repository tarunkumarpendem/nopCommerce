FROM mcr.microsoft.com/dotnet/aspnet:6.0 as build
LABEL Author="tarun"
LABEL app="nopCommerce"
ENV MYSQL_ROOT_PASSWORD = "rootroot"
ENV MYSQL_DATABASE = "mysql-db"
ENV MYSQL_USER = "mysql-user"
ENV MYSQL_PASSWORD = "mysql-password"
VOLUME [ "/var/lib/mysql" ]
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip .
RUN apt update && \
    apt install unzip -y && \
    unzip ./nopCommerce_4.50.3_NoSource_linux_x64.zip && \
    mkdir bin logs && \
    chgrp -R www-data nopCommerce && \
    chown -R www-data nopCommerce 
ENTRYPOINT [ "dotnet", "Nop.Web.dll", "run", "--server.urls=http://0.0.0.0:*" ]
EXPOSE 80 3306



# Database
FROM mcr.microsoft.com/dotnet/aspnet:6.0 as db
LABEL Author="tarun"
LABEL app="nopCommerce"
ENV MYSQL_ROOT_PASSWORD = "rootroot"
ENV MYSQL_DATABASE = "mysql-db"
ENV MYSQL_USER = "mysql-user"
ENV MYSQL_PASSWORD = "mysql-password"
VOLUME [ "/var/lib/mysql" ]
RUN apt update && \
    apt install nginx unzip -y && \
    mkdir /var/www/nopCommerce && \
    cd /var/www/nopCommerce
ADD https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip  /var/www/nopCommerce
WORKDIR /var/www/nopCommerce
RUN unzip ./nopCommerce_4.50.3_NoSource_linux_x64.zip && \ 
    mkdir bin logs && \
    cd .. && \
    chgrp -R www-data nopCommerce && \
    chown -R www-data nopCommerce
ENTRYPOINT [ "dotnet", "Nop.Web.dll", "run", "--server.urls=http://0.0.0.0:*" ]
EXPOSE 80 3306    




