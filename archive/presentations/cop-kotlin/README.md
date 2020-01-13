# Installation/Building

# Dependencies

- [pandoc](http://pandoc.org/): Generates the HTML files.
- [inotify-install](https://github.com/rvoicilas/inotify-tools) (optional): Watches the directory for changes to trigger rebuilding.

# Setup

You might need to create an `index.html` first

    touch index.html

# Start docker container

    make docker

# Generate (manual)

    make

# Generate (automatic)

You can watch the directory and generate on demand by running:

    make watch

If `inotify` is not available for you, you can periodically call `make` instead,
e.g. like this:

    watch make
