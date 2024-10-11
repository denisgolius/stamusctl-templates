all: pre-run post-run

CURRENT_DIR=$(shell pwd)

pre-run:
	$(MAKE) -C pre-run CURRENT_DIR=${CURRENT_DIR}

post-run:
	$(MAKE) -C post-run CURRENT_DIR=${CURRENT_DIR}

.PHONY: all pre-run post-run