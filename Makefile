TARGET=docs

DOCS_SOURCE  = docs.md
DOCS_TARGET  = ${TARGET}/index.html

ASSET_SOURCES = dist/theme/streetepistemology.css dist/media/street-epistemology-logo.png dist/media/to-this-site-qr.png
ASSET_TARGETS = $(addprefix ${TARGET}/,${ASSET_SOURCES})

CARD_SOURCES = src/introducing-se-card-2022-08-front.svg src/introducing-se-card-2022-05-back.svg
CARD_BUILD   = $(patsubst %.svg,%.pdf,${CARD_SOURCES})
CARD_TARGET  = dist/media/introducing-se-card-2022-08-05.pdf


# To install, run "make install-mdslides"
MDSLIDES = ${HOME}/.local/bin/mdslides

# To install, run "make install-poppler-utils"
PDFUNITE=/usr/bin/pdfunite

# To install, run "make install-inkscape"
INKSCAPE=/usr/bin/inkscape


all: card site

card: ${CARD_TARGET}

site: ${DOCS_TARGET} ${ASSET_TARGETS}


${CARD_TARGET}: ${CARD_BUILD}
	${PDFUNITE} ${CARD_BUILD} ${CARD_TARGET}
	# Strip some non-idempotent cruft that pdfunite/poppler adds to
    # the PDF, that makes the output non-reproducible
	perl -i~ -pE 'our $$match; s@(/ID \[\(.*\) \] )@@; $$match ||= length($$1); s@^(\d+)\r$$@$$1 - $$match@e if $$match; } END: { say STDERR "Stripped $$match bytes" if $$match' ${CARD_TARGET}
	touch ${CARD_TARGET}

${CARD_BUILD}: ${CARD_SOURCES}
	${INKSCAPE} -D -o $@ $(patsubst %.pdf,%.svg,$@)

${DOCS_TARGET}: ${DOCS_SOURCE}
	${MDSLIDES} docs.md --include dist
	# mdslides deletes unfamiliar files, but we need CNAME
	# for github to serve the files on the correct DNS hostname
	git checkout docs/CNAME

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
