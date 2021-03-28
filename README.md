# Nginx Lua Prometheus - Docker image

[![Latest Version](https://img.shields.io/github/v/release/kiwfy/nginx-lua-prometheus.svg?style=flat-square)](https://github.com/kiwfy/nginx-lua-prometheus/releases)
[![Build Status](https://img.shields.io/github/workflow/status/kiwfy/nginx-lua-prometheus/CI?label=ci%20build&style=flat-square)](https://github.com/kiwfy/nginx-lua-prometheus/actions?query=workflow%3ACI)
![Docker Image Size](https://img.shields.io/docker/image-size/kiwfydev/nginx-lua-prometheus/latest)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

Nginx with Prometheus, access and error logs exporter.

### How to use this image

Requires [Docker](https://www.docker.com/get-started).

Before get the image is necessary [authenticate](https://docs.github.com/pt/packages/using-github-packages-with-your-projects-ecosystem/configuring-docker-for-use-with-github-packages) in Github Package

You can run the container and service like so:

```sh
docker run -d -p 80:80 docker.pkg.github.com/kiwfy/nginx-lua-prometheus/nginx-lua-prometheus:latest
```

Or with [Docker Hub](https://hub.docker.com/r/kiwfydev/nginx-lua-prometheus) image

```sh
docker run -d kiwfydev/nginx-lua-prometheus:latest
```

### Docker with compose tool

It's a good way to use [docker-compose](https://docs.docker.com/compose/). Example:

```
version: '3.7'
services:
    nginx:
        image: docker.pkg.github.com/kiwfy/nginx-lua-prometheus/nginx-lua-prometheus:latest
        container_name: nginx
        ports:
            - 80:80
        volumes:
            - ./:/var/www/html
```

### Nginx

For default the Nginx is accessible in your [localhost](http://localhost:9436/) port 9436.

### Metrics

This project have route metric to using with [Prometheus](https://prometheus.io/) and [Grafana](https://grafana.com/) dashboard.

For testing and visualize all the metrics:

```sh
docker-compose up --build
```

After that, open [metrics dashboard](http://localhost:3000/d/rVSzEqEGk/nginx-lua-prometheus-monitoring) with:

```
Username: admin
password: admin
```

If you alreay have Prometheus service running or is a base image from another service, just call the route: http://nginx-lua-prometheus:9436/metrics

This route is enable only for internal requests in the same docker networking.

### Logs

To follow all nginx logs, you can use [Kibana](https://www.elastic.co/kibana) + [Elasticsearch](https://www.elastic.co/).

This imagem is ready to export and show this informations.

You can access your [Local Kibana](http://localhost:5601/) with:

```
Username: elastic
password: changeme
```

After that access [discover](http://localhost:5601/app/discover) menu to see the log.

If you already have this services enable, just configure [Filebeat](https://www.elastic.co/beats/filebeat) in [configuration folder](https://github.com/kiwfy/nginx-lua-prometheus/blob/master/filebeat/filebeat.yml).

### Development

Want to contribute? Great!

Make a change in image and be careful with your updates!

**Kiwfy - Open your code, open your mind!**
