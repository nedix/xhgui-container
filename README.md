# [xhgui-container][project]

Web GUI for XHProf profiling reports.


## Usage

This example expects that you have your main application services defined in `compose.yml`.
It will listen for requests on port `81` and `82`.


### 1. Create the Compose manifest

```shell
wget -q https://raw.githubusercontent.com/nedix/xhgui-container/main/docs/examples/compose-xhgui.yml
```


### 2. Start the services

```shell
docker compose -f compose.yml -f compose-xhgui.yml up -d
```


### 3. Capture a profiling report

Navigate to any page on http://127.0.0.1:81 to capture the profiling report.


### 4. Import the profiling data into XHGui

Run the following command to load the data into XHGui:

```shell
docker compose -f compose-xhgui.yml exec xhgui php /var/www/xhgui/external/import.php -f /data/xhprof/xhgui.data.jsonl
```


### 5. Get insight into performance metrics

Navigate to the XHGui web interface on http://127.0.0.1:82.


[project]: https://hub.docker.com/r/nedix/xhgui
