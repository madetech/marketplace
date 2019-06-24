.PHONY: test
test: 
	bundle exec guard

.PHONY: serve
serve:
	bundle exec ruby app/server.rb
