
TARGETS=docs/index.html dist/theme/streetepi.css
MDSLIDES=${HOME}/.local/bin/mdslides

all: slideshow

slideshow: docs/index.html docs/dist/theme/streetepi.css

docs/index.html: docs.md
docs/dist/theme/streetepi.css: dist/theme/streetepi.css

$(TARGETS):
	${MDSLIDES} docs.md --include dist
	git checkout docs/CNAME

install: install-apt
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git

install-apt:
	sudo apt install python3-pip
