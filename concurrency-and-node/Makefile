execute: .stack-work node-async/node_modules
	@echo "======== Node - Local"
	(cd node-async && npm run local)
	@echo "======== Node - Remote"
	(cd node-async && npm run remote)

	@echo "======== Haskell - Local"
	stack exec -- haskell-async-local
	@echo "======== Haskell - Remote"
	stack exec -- haskell-async-remote

webserver: .stack-work
	stack build slow-web-server
	stack exec -- slow-web-server

starvation-server-node: node-async/node_modules
	(cd node-async && npm run starvation)

starvation-server-haskell: .stack-work
	stack exec -- haskell-async-starvation

starvation: .stack-work
	stack exec -- starvation-tester

thread-spawn: .stack-work
	stack exec -- haskell-thread-spawn +RTS -sout
	cat out

.stack-work:
	stack docker pull
	stack setup
	stack build

node-async/node_modules:
	(cd node-async && npm install)

clean:
	rm -rf .stack-work/
	rm -rf node-async/node_modules/
