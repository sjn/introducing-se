

all: slideshow

slideshow: docs/index.html

docs/index.html:
	mdslides docs.md

install:
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git
