
TARGETS=docs/index.html docs/dist/theme/streetepistemology.css docs/dist/media/introducing-se-qr.png docs/dist/media/street-epistemology-logo.png
MDSLIDES=${HOME}/.local/bin/mdslides

all: slideshow

slideshow: docs/index.html docs/dist/theme/streetepistemology.css docs/dist/media/introducing-se-qr.png docs/dist/media/street-epistemology-logo.png

docs/index.html: docs.md
docs/dist/theme/streetepistemology.css: dist/theme/streetepistemology.css
docs/dist/media/street-epistemology-logo.png: dist/media/street-epistemology-logo.png
docs/dist/media/introducing-se-qr.png: dist/media/introducing-se-qr.png

$(TARGETS):
	${MDSLIDES} docs.md --include dist
	git checkout docs/CNAME

install: install-apt
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git

install-apt:
	sudo apt install python3-pip
