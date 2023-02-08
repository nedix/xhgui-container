# xhgui-docker

A Docker image for the [XHGui](https://github.com/perftools/xhgui) web interface
to turn PHP profiling data into a graphical representation. The example in this
readme describes how XHGui can be use together with Xhprof.

## Example

### Setup

*docker-compose-xhgui.yml*

```yaml
version: "3.8"

services:
  nginx-xhprof:
    image: wodby/nginx:1.19
    environment:
      NGINX_VHOST_PRESET: php
      NGINX_BACKEND_HOST: xhprof
      NGINX_SERVER_ROOT: '${NGINX_SERVER_ROOT:-/var/www/html/public_html}'
    ports:
      - 8000:80
    volumes:
      - app:/var/www/html

  xhprof:
    image: wodby/php:8.1-dev
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
      - 8001:80
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

### Usage

### Step 1.

Start the containers:

```shell
docker compose -f docker-compose.yml -f docker-compose-xhgui.yml up -d
```

### Step 2.

Navigate to your page on [localhost:8000](http://localhost:8000) to capture the profiling data.

### Step 3.

Execute the following command to load the data into XHGui:

```shell
docker compose -f docker-compose-xhgui.yml exec xhgui php /var/www/xhgui/external/import.php -f /data/xhprof/xhgui.data.jsonl
```

### Step 4.

Find XHGui on [localhost:8001](http://localhost:8001).
