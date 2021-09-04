
TARGETS=docs/index.html docs/dist/theme/streetepistemology.css
MDSLIDES=${HOME}/.local/bin/mdslides

all: slideshow

slideshow: docs/index.html docs/dist/theme/streetepistemology.css

docs/index.html: docs.md
docs/dist/theme/streetepistemology.css: dist/theme/streetepistemology.css

$(TARGETS):
	${MDSLIDES} docs.md --include dist
	git checkout docs/CNAME

install: install-apt
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git

install-apt:
	sudo apt install python3-pip
