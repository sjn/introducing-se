
TARGETS=docs/index.html docs/dist/theme/streetepistemology.css docs/dist/media/introducing-se-qr.png docs/dist/media/share-this.png
MDSLIDES=${HOME}/.local/bin/mdslides

all: slideshow

slideshow: docs/index.html docs/dist/theme/streetepistemology.css docs/dist/media/introducing-se-qr.png docs/dist/media/street-epistemology-logo.png dist/media/introducing-se-qr-clean.png

docs/index.html: docs.md
docs/dist/theme/streetepistemology.css: dist/theme/streetepistemology.css
docs/dist/media/street-epistemology-logo.png: dist/media/street-epistemology-logo.png
docs/dist/media/share-this.png: dist/media/share-this.png

docs/dist/media/introducing-se-qr-clean.png: dist/media/introducing-se-qr-clean.png
	qrencode -s 6 -l H -o "dist/media/introducing-se-qr-clean.png" "https://introducing.se"

$(TARGETS):
	${MDSLIDES} docs.md --include dist
	git checkout docs/CNAME

install: install-apt install-qrencode
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git

install-apt:
	sudo apt install python3-pip

install-qrencode:
	sudo apt install qrencode
