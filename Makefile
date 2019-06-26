.PHONY: test
test: 
	bundle exec guard -g tests

.PHONY: serve
serve: server.pid
	bundle exec guard -g serve
	@echo to stop run "make stop"

server.pid:
	bundle exec ruby app/server.rb & echo $$! > $@;

.PHONY: stop
stop: server.pid
	kill `cat $<` || true
	rm $<
