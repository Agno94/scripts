SHELL := bash
PYTHON ?= python3
PIP ?= pip3

SHELL_FILES := $(shell find . -name "*.sh")
BINPATH := $(shell grep binpath config | sed "s|[a-z]*:\(.*\)|\1|")
TERMUXBINPATH := $(shell grep bintermuxpath config | sed "s|[a-z]*:\(.*\)|\1|")
SOURCE_PATH := $(shell if [ -d "build" ]; then echo "build/"; else echo "./"; fi)

default:
	@echo "Choose a target"
	@echo " + install copy termux clean + "

install:
	@echo "Not set"

debug:
	@echo "==="
	@echo $(SHELL_FILES)
	@echo $(BINPATH)
	@echo $(BUILD_PATH)
	@echo $(TERMUXBINPATH)
	@echo "==="

termux:
	@# Currently we do not use migrations
	@mkdir -p build
	@echo "=== I copy file and apply to them termux-fix-shebang ==="
	@for f in $(SHELL_FILES); do \
		echo $$f; \
		echo cp $$f build/$$f; \
		echo termux-fix-shebang build/$$f; \
	done
	@echo "=== Done ==="

copy:
	@# Currently we do not use migrations
	@mkdir -p build
	@echo "=== Copy file from $(SOURCE_PATH) to $(BINPATH) ==="
	@echo $(SOURCE_PATH)
	@for f in $(SHELL_FILES); do \
		echo cp $(SOURCE_PATH)$$f $(BINPATH)/$$f; \
		echo chmod +x $(BINPATH)$$f; \
	done
	@echo "=== Done ==="


clean:
	rm -f build/*

