FROM xhgui/xhgui:0.21.3 as xhgui
FROM php:8.1

COPY --from=xhgui /var/www/xhgui /var/www/xhgui

USER root

ADD rootfs /

WORKDIR /var/www/xhgui/webroot

ENV XHGUI_SAVE_HANDLER="pdo"
ENV XHGUI_PDO_DSN="sqlite:/tmp/xhgui.sqlite3"

CMD ["php", "-S", "0.0.0.0:80"]

EXPOSE 80
