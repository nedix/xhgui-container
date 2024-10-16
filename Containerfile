ARG PHP_VERSION=8.3
ARG XHGUI_VERSION=0.22.1

FROM xhgui/xhgui:${XHGUI_VERSION} as xhgui

FROM php:${PHP_VERSION}

COPY --from=xhgui /var/www/xhgui /var/www/xhgui

USER root

ADD rootfs /

WORKDIR /var/www/xhgui/webroot

ENV XHGUI_SAVE_HANDLER="pdo"
ENV XHGUI_PDO_DSN="sqlite:/tmp/xhgui.sqlite3"

ENTRYPOINT ["php", "-S", "0.0.0.0:80"]

EXPOSE 80
