SHELL = /bin/bash

install:
	./install

brew:
	./bin/is-executable.sh bash || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

git: brew
	brew install git git-extras

asdf: brew
	brew install asdf