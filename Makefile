setup:
	@docker build -f Containerfile -t xhgui

up: PORT = 8080
up:
	@docker run --rm -p $(PORT):80 --name xhgui \
		xhgui
