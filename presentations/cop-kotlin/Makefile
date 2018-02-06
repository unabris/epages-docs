#!/usr/bin/env make

# Start the container
# $ make docker
#
# Watch for changes 
# $ make watch
#
# If `make watch` does not work, `watch make` is also an option


FORMAT   = revealjs
THEME    = solarized

PANDOC_DIR      = /pandoc
WATCH_SCRIPT    = ../../watch.sh
DOCKER_SCRIPT   = ../../powerpoint.exe

HEADER_HTML     = $(PANDOC_DIR)/include-in-header.html
TEMPLATE        = $(PANDOC_DIR)/template.html

REVEALJS_URL    = reveal.js
S5_URL          = s5/default
SLIDEOUS_URL    = slideous

# SLIDY_URL		= slidy
# --variable=slidy-url:$(SLIDY_URL) \
# --variable=s5-url:$(S5_URL) \
# --variable=revealjs-url:$(REVEALJS_URL) \
# --variable=slideous-url:$(SLIDEOUS_URL) \


# html template if necessary
# https://github.com/jgm/pandoc-templates


OPEN = xdg-open

MAIN = index.html

DOCKER_ID = $(shell docker ps -qf "name=reveal")

all: $(MAIN)

%.html: %.md
	@echo "Rebuilding..."
	@docker exec -i $(DOCKER_ID) /bin/sh -c \
	"pandoc \
	  -t $(FORMAT) \
	  --template $(TEMPLATE) \
	  --include-in-header=$(HEADER_HTML) \
	  --section-divs \
	  --no-highlight \
	  -V revealjs-url="" \
	  -V theme=$(THEME) \
	  -V transition="slide" \
	  -V history \
	  -s \
	  -o index.html" < index.md


open: $(MAIN)
	$(OPEN) $(MAIN)


watch: all
	$(WATCH_SCRIPT)


docker:
	$(DOCKER_SCRIPT)


clean:
	rm -f index.html


.PHONY: open watch docker all clean
