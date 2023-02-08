setup:
	@docker build . -t xhgui

up: detach =
up:
	@docker run --rm $(if $(detach),-d,) -p 1235:80 --name xhgui \
		xhgui
