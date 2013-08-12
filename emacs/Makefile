# sample makefile for installing configs

emacsfiles = .emacs.d
exclude = my-overrides.el

# install all config files except overrides
install:
	rsync -av $(emacsfiles) $(HOME) --exclude=$(exclude)

# install all config files
override:
	cp -R $(emacsfiles) $(HOME)
