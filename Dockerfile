FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update && apt install wget unzip -y
RUN wget https://www.tooplate.com/zip-templates/2108_dashboard.zip
RUN unzip 2108_dashboard.zip && cd 2108_dashboard && tar -czf 2108.tgz * && mv 2108.tgz /root/2108.tgz

FROM ubuntu:latest
LABEL "project"="CICDcase2"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install apache2 git wget -y
COPY --from=BUILD_IMAGE /root/2108.tgz /var/www/html/
RUN cd /var/www/html/ && tar xzf 2108.tgz
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
VOLUME /var/log/apache2
WORKDIR /var/www/html/
EXPOSE 80

