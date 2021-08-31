

all: slideshow

slideshow: docs/index.html

docs/index.html: docs.md

docs/index.html:
	mdslides docs.md --include media
	git checkout docs/CNAME

install:
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git
