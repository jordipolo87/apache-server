FROM debian:jessie

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update && apt-get -y install apache2 libapache2-modsecurity php5 php5-mysql wget nano

#Install google mod_pagespeed
RUN wget https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-stable_current_amd64.deb
RUN dpkg -i mod-pagespeed-*.deb
RUN apt-get -f install
RUN apt-get -y remove wget
RUN rm mod-pagespeed-*.deb

RUN apt-get clean

RUN /bin/ln -sf ../sites-available/default-ssl /etc/apache2/sites-enabled/001-default-ssl
RUN /bin/ln -sf ../mods-available/ssl.conf /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/ssl.load /etc/apache2/mods-enabled/
RUN /bin/ln -sf ../mods-available/socache_shmcb.load /etc/apache2/mods-enabled/

#Copy server conf and sites conf files
COPY apache2.conf /etc/apache2/apache2.conf
COPY sites-available/ /etc/apache2/sites-available


#Enable sites
RUN a2ensite boandlu.com.conf
RUN a2ensite calfred.com.conf
RUN a2ensite drpcadomicili.com.conf
RUN a2ensite drpchosting.com.conf
RUN a2ensite ea3eis.com.conf
RUN a2ensite granadura.com.conf
RUN a2ensite hashslider.com.conf
RUN a2ensite inastanimirova.com.conf
RUN a2ensite oncoagora.org.conf
RUN a2ensite psicologo-en-barcelona.com.conf

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]