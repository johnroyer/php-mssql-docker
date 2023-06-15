FROM php:8.1-fpm-alpine

# Microsoft ODBC
RUN curl -O https://download.microsoft.com/download/1/f/f/1fffb537-26ab-4947-a46a-7a45c27f6f77/msodbcsql18_18.2.1.1-1_amd64.apk && \
    curl -O https://download.microsoft.com/download/1/f/f/1fffb537-26ab-4947-a46a-7a45c27f6f77/mssql-tools18_18.2.1.1-1_amd64.apk && \
    apk add --allow-untrusted msodbcsql18_18.2.1.1-1_amd64.apk && \
    apk add --allow-untrusted mssql-tools18_18.2.1.1-1_amd64.apk && \
    rm msodbcsql18_18.2.1.1-1_amd64.apk mssql-tools18_18.2.1.1-1_amd64.apk

# MS SQL Server driver
RUN apk add unixodbc-dev && \
    apk add $PHPIZE_DEPS && \
    pecl install sqlsrv pdo_sqlsrv && \
    apk del unixodbc-dev

RUN rm -fr /var/cache/apk/* && \
    rm -fr /tmp/*


RUN echo 'extension=sqlsrv.so' >> /usr/local/etc/php/php.ini && \
    echo 'extension=pdo_sqlsrv.so' >> /usr/local/etc/php/php.ini

