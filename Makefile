setup:
	@docker build -f Containerfile -t xhgui

destroy:
	-@docker rm -fv xhgui

up: HTTP_PORT = "80"
up:
	@docker run --rm -d --name xhgui \
		-p 127.0.0.1:$(HTTP_PORT):80  \
		xhgui
	@docker logs -f xhgui

down:
	-@docker stop xhgui

shell:
	@docker exec -it xhgui /bin/sh

test:
	@$(CURDIR)/tests/index.sh
