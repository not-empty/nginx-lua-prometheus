FROM debian:10.8

RUN apt update \
    && apt install -y libnginx-mod-http-lua

RUN apt -y install --no-install-recommends wget gnupg ca-certificates \
    && wget -O - https://openresty.org/package/pubkey.gpg | apt-key add - \
    && codename=`grep -Po 'VERSION="[0-9]+ \(\K[^)]+' /etc/os-release` \
    && echo "deb http://openresty.org/package/debian $codename openresty" | tee /etc/apt/sources.list.d/openresty.list \
    && apt update \
    && apt -y install openresty \
    && opm get knyar/nginx-lua-prometheus/

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.11.1-amd64.deb \
    && dpkg -i filebeat-7.11.1-amd64.deb \
    && filebeat modules enable nginx

COPY ./filebeat/filebeat.yml /etc/filebeat/filebeat.yml
COPY ./filebeat/nginx.yml /etc/filebeat/modules.d/nginx.yml

COPY ./nginx/*.sh /tmp/
RUN chmod 777 /tmp/*.sh

COPY ./nginx/index.html /usr/local/openresty/nginx/html/index.html

ENV PATH "/usr/local/openresty/nginx/sbin:$PATH"

WORKDIR /usr/local/openresty/nginx/

COPY ./nginx/nginx.conf conf/nginx.conf

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-c", "conf/nginx.conf"]
