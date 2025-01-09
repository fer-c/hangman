.PHONY: devrun test devrun prodrun

devbuild:
	######### Get dependencies
	mix deps.get
	######### Start service
	MIX_ENV=dev \
	mix escript.build

prodbuild:
	######### Get dependencies
	mix deps.get
	######### Start service
	MIX_ENV=prod \
	mix escript.build

prodrun: prodbuild
	######### Start service
	WAMP_ENCODING=json \
	WAMP_HOST=localhost \
	WAMP_PORT=18082 \
	WAMP_REALM=com.magenta.public \
	WAMP_CALL_TIMEOUT="10000" \
	WAMP_RECONNECT_RETRIES="10" \
	WAMP_RECONNECT_MAX_RETRIES="30" \
	WAMP_RECONNECT_BACKOFF_MIN="200" \
	WAMP_RECONNECT_BACKOFF_MAX="60000" \
	WAMP_RECONNECT_BACKOFF_TYPE="jitter" \
	WAMP_AUTH_METHOD="cryptosign" \
	WAMP_AUTH_USERNAME="Weh4byK8zRgHXsTCA6tV9pUfSuxc5ZQJ" \
	WAMP_AUTH_PASSWORD="wny5bPsN8mgQuqfLDhMjRH297GZYBXSe" \
	WAMP_AUTH_PUBKEY="1766c9e6ec7d7b354fd7a2e4542753a23cae0b901228305621e5b8713299ccdd" \
	WAMP_AUTH_PRIVKEY="4ffddd896a530ce5ee8c86b83b0d31835490a97a9cd718cb2f09c9fd31c4a7d7" \
	CLOAK_KEY=TYrreA2RKuGyP2/oo1Twhs6ooZFGrkczDfqGdlMQbV8= \
	./bin/hangman --wamp
