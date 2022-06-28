TARGET=docs/

CARD_SOURCES = src/introducing-se-card-2022-01-back.pdf src/introducing-se-card-2022-01-front.pdf
CARD_BUILD   = dist/media/introducing-se-card-2022-01.pdf
CARD_TARGET  = $(addprefix ${TARGET},${CARD_BUILD})

DOCS_SOURCES = dist/theme/streetepistemology.css dist/media/street-epistemology-logo.png dist/media/share-this.png
DOCS_BUILD   = dist/media/introducing-se-qr-clean.png
DOCS_TARGETS = $(addprefix ${TARGET},${DOCS_SOURCES})

WEB_TARGETS  = docs/index.html

MDSLIDES=${HOME}/.local/bin/mdslides
PDFUNITE=/usr/bin/pdfunite


all: slideshow card

slideshow: ${WEB_TARGETS}
card: ${CARD_TARGET}

docs/index.html: docs.md

dist/media/introducing-se-qr-clean.png:
	qrencode -s 6 -l H -m 2 -o "dist/media/introducing-se-qr-clean.png" "https://introducing.se"

${CARD_TARGET}: ${CARD_BUILD}
	cp -p ${CARD_BUILD} ${CARD_TARGET}

$(WEB_TARGETS): ${DOCS_SOURCES} ${DOCS_BUILD}
	${MDSLIDES} docs.md --include dist
	git checkout docs/CNAME

${CARD_BUILD}: ${CARD_SOURCES}
	${PDFUNITE} ${CARD_SOURCES} ${CARD_BUILD}


installdeps: install-apt install-qrencode install-mdslides install-poppler-utils

install-mdslides:
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git

install-apt:
	sudo apt install python3-pip

install-qrencode:
	sudo apt install qrencode

install-poppler-utils:
	sudo apt install poppler-utils
