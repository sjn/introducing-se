TARGET=docs

DOCS_SOURCE  = docs.md
DOCS_TARGET  = ${TARGET}/index.html

ASSET_SOURCES = dist/theme/streetepistemology.css dist/media/street-epistemology-logo.png dist/media/to-this-site-qr.png
ASSET_TARGETS = $(addprefix ${TARGET}/,${ASSET_SOURCES})

CARD_SOURCES = src/introducing-se-card-2022-02-front.svg src/introducing-se-card-2022-02-back.svg
CARD_BUILD   = $(patsubst %.svg,%.pdf,${CARD_SOURCES})
CARD_TARGET  = ${TARGET}/dist/media/introducing-se-card-2022-02.pdf


# To install, run "make install-mdslides"
MDSLIDES = ${HOME}/.local/bin/mdslides

# To install, run "make install-poppler-utils"
PDFUNITE=/usr/bin/pdfunite

# To install, run "make install-inkscape"
INKSCAPE=/usr/bin/inkscape


all: site card

card: ${CARD_TARGET}

site: ${DOCS_TARGET} ${ASSET_TARGETS}
	${MDSLIDES} docs.md --include dist
	git checkout docs/CNAME


${CARD_TARGET}: ${CARD_BUILD}
	${PDFUNITE} ${CARD_BUILD} ${CARD_TARGET}
	touch ${CARD_TARGET}

${CARD_BUILD}: ${CARD_SOURCES}
	${INKSCAPE} -C -o $@ $(patsubst %.pdf,%.svg,$@)

${DOCS_TARGET}: ${DOCS_SOURCE}

${ASSETS_TARGETS}: ${ASSETS_SOURCES}



# TODO: improve QR code generation method
dist/media/introducing-se-qr-clean.png:
	qrencode -s 6 -l H -m 2 -o "dist/media/introducing-se-qr-clean.png" "https://introducing.se"


## Intalling dependencies
#
# These are useful for a recent Ubuntu (22.04 works)
#

installdeps: install-qrencode install-mdslides install-poppler-utils install-inkscape

# Installation instructions: https://github.com/dadoomer/markdown-slides
install-mdslides: install-pip3
	pip3 install git+https://gitlab.com/da_doomer/markdown-slides.git

install-pip3:
	sudo apt install python3-pip

install-qrencode:
	sudo apt install qrencode

# pdfunite is supplied by poppler-utils
install-poppler-utils:
	sudo apt install poppler-utils

install-inkscape:
	sudo apt install inkscape



## Graph this Makefile

make2graph:
	@echo 'make -Bnd | make2graph | dot -Lg -x -Tsvg -o out.svg'


.PHONY: all card site
