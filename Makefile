

all: slideshow

install:
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git

slideshow:
	mdslides slideshow.md
