# [xhgui-container](https://github.com/nedix/xhgui-container)

Web GUI for xhprof.

## Usage

#### Create a Docker Compose manifest

This example Docker Compose manifest expects that you have your main application services defined in `compose.yml`.
It will listen for requests on port `81` and `82`.

```shell
wget -q https://raw.githubusercontent.com/nedix/spx-container/main/docs/examples/compose-xhgui.yml
```

#### Start the services

```shell
docker compose -f compose.yml -f compose-xhgui.yml up -d
```

#### Capture a profiling report

Navigate to any page on http://127.0.0.1:81 to capture the profiling report.

#### Import data

Run the following command to load the data into XHGui:

```shell
docker compose -f compose-xhgui.yml exec xhgui php /var/www/xhgui/external/import.php -f /data/xhprof/xhgui.data.jsonl
```

#### Get insight into performance

Navigate to the [XHGui] web interface on http://127.0.0.1:82.

<hr>

## Attribution

Powered by [XHGui].

[XHGui]: https://github.com/perftools/xhgui
