MOCHA_OPTS=
REPORTER = dot

test-lib:
	@NODE_ENV=test ./node_modules/.bin/mocha -r coffee-script --globals data,sampled_data,stat,send_data\
		--reporter $(REPORTER) \
		--bail \
		spec/lib/**/*.coffee

build:
	coffee --compile lib/*.coffee
