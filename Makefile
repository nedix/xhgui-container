setup:
	@docker build . -t xhgui

up: detach =
up:
	@docker run --rm $(if $(detach),-d,) -p 1234:80 --name xhgui \
		xhgui
