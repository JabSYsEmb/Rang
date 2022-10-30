CXX := g++-12
CXXFLAGS := -pedantic-errors -Wall -Werror -Wno-unused=unused-function -std=c++20 -O0
LDFLAGS := -L /usr/lib -lstdc++ -lm
BUILD := ./build
OBJ_DIR := $(BUILD)/objects
GEN_DIR := $(BUILD)/generated
APP_DIR := $(BUILD)/apps
TARGET  := librang.so
INCLUDE := -I include/
LIBOBJECTS := $(OBJ_DIR)/rangBase.o
RANGLIBRARY := -L $(APP_DIR) -Wl,-R -Wl,.$(APP_DIR) -l:librang.so

all: $(APP_DIR)/$(TARGET) ## Build the share library

$(OBJ_DIR)/rangBase.o: src/rangBase.cpp include/rangBase.hpp
	@echo "\n### Compiling rangBase.o ###"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@ -fPIC

$(APP_DIR)/$(TARGET): $(LIBOBJECTS)
	@echo "\n### Compiling Rang Shared Library ###"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -shared -o $@ $^ $(LDFLAGS)


.PHONY: all docs clean cloc help

docs: ##
	doxygen

clean: ## Remove all contents of the build directories.
	+@rm -rv $(OBJ_DIR)/*
	+@rm -rv $(GEN_DIR)/*
	+@rm -rv $(APP_DIR)/*

cloc: ## Count the lines of code used in the project.
	cloc src include flex bison test Makefile

watch:
	@while true; do\
		make all; \
		echo "\033[0;32m";\
		echo "###########################";\
		echo "### Waiting for changes ###";\
		echo "###########################";\
		echo "\033[0m";\
		fswatch -1 -r $(LIBOBJECTS) $(INCLUDE) >/dev/null 2>&1;\
		done

help: ## Display this help
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'
