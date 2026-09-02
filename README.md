# [xhgui-container][project]

Web GUI for XHProf profiling reports.


## Usage

This stack requires that you have a `compose.yml` for your PHP application's services.
It will listen for requests on port `8081` and `8082`.


### 1. Create the Compose manifest

```shell
wget https://raw.githubusercontent.com/nedix/xhgui-container/main/stacks/php/compose-xhgui.yml
```


### 2. Start the services

```shell
docker compose -f compose.yml -f compose-xhgui.yml up -d
```


### 3. Capture a profiling report

Navigate to your application on http://127.0.0.1:8081 to capture a profiling report.


### 4. Import the profiling report into XHGui

Run the following command to load the data into XHGui:

```shell
docker compose exec xhgui php /var/www/xhgui/external/import.php -f /data/xhprof/xhgui.data.jsonl
```


### 5. Gain insight into performance metrics

Navigate to the XHGui web interface on http://127.0.0.1:8082.


[project]: https://hub.docker.com/r/nedix/xhgui
