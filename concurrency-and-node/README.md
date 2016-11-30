## Concurrency and Node

This package contains the example code used in the article at *replace
with URI*.

### Prerequisites
* Node.JS
* NPM
* Docker
* Haskell Stack

### Instructions - Local vs Remote Test

* Open a terminal tab in this directory and execute the command `make
  webserver`. Wait for it to say "Example Server Running".
* Open a new terminal tab in this directory and execute the command
  `make execute`.

### Instructions - Starvation Test

* Open a terminal tab in this directory and execute the command `make
  starvation-server-node`. Wait for it to say "Node Starvation Server
  Running".
* Open a new terminal tab in this directory and execute the command
  `make starvation-server-haskell`. Wait for it to say "Haskell
  Starvation Server Running".
* Open a new terminal tab in this directory and execute the command
  `make starvation`.

### Instructions - Thread Spawn

* Open a terminal tab in this directory and execute the command `make
  thread-spawn`.
