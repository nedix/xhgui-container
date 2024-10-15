# [xhgui]-container

Used with Xhprof to give insight into performance metrics of PHP applications.

## Setup

#### Create a Docker Compose manifest

This example Docker Compose manifest expects that you have your main application services defined in `docker-compose.yml`.
It will listen for requests on port `81` and `82`.

*docker-compose-xhgui.yml*

```yaml
services:
  nginx-xhprof:
    image: wodby/nginx:1.19
    environment:
      NGINX_VHOST_PRESET: php
      NGINX_BACKEND_HOST: xhprof
      NGINX_SERVER_ROOT: /var/www/html/public
    ports:
      - 81:80
    volumes:
      - app:/var/www/html

  xhprof:
    image: wodby/php:8.2-dev
    environment:
      - PHP_DEBUG=true
      - PHP_XHPROF=true
      - PHP_XHPROF_SAMPLING_INTERVAL=100000
      - PHP_XHPROF_SAMPLING_DEPTH=INT_MAX
      - PHP_XHPROF_COLLECT_ADDITIONAL_INFO=0
      - PHP_XHPROF_OUTPUT_DIR=/mnt/files/xhprof
    volumes:
      - app:/var/www/html
      - xhprof:/mnt/files/xhprof
    depends_on:
      - nginx-xhprof

  xhgui:
    image: ghcr.io/nedix/xhgui-docker
    volumes:
      - xhprof:/data/xhprof
    ports:
      - 82:80
    depends_on:
      - xhprof

volumes:
  app:
    driver: local
    driver_opts:
      device: ${PWD}
      o: bind
      type: none
  xhprof:
    driver: local
```

## Usage

#### Start the services

```shell
docker compose -f docker-compose.yml -f docker-compose-xhgui.yml up -d
```

#### Capture a profiling report

Navigate to any page on http://127.0.0.1:81 to capture the profiling report.

#### Import data

Run the following command to load the data into XHGui:

```shell
docker compose -f docker-compose-xhgui.yml exec xhgui php /var/www/xhgui/external/import.php -f /data/xhprof/xhgui.data.jsonl
```

#### Get insight into performance

Navigate to the [XHGui] web interface on http://127.0.0.1:82.

<hr>

## Attribution

Powered by [XHGui].

[XHGui]: https://github.com/perftools/xhgui
