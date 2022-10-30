CXX := g++-12
CXXFLAGS := -pedantic-errors -Wall -Werror -Wno-unused=unused-function -std=c++20 -O0
LDFLAGS := -L /usr/lib -lstdc++ -lm
FLEX_LIB := /opt/homebrew/opt/flex/include
BUILD := ./build
OBJ_DIR := $(BUILD)/objects
GEN_DIR := $(BUILD)/generated
APP_DIR := $(BUILD)/apps
TARGET  := librang.so
INCLUDE := -I include/ -I $(GEN_DIR)/ -I $(FLEX_LIB)/
LIBOBJECTS := $(OBJ_DIR)/ast.o $(OBJ_DIR)/error.o $(OBJ_DIR)/rangBase.o $(OBJ_DIR)/rangScanner.o $(OBJ_DIR)/rangParser.o    
RANGLIBRARY := -L $(APP_DIR) -Wl,-R -Wl,.$(APP_DIR) -l:librang.so

TO_WATCH_DIR := include src bison flex test

all: $(APP_DIR)/$(TARGET) ## Build the share library

##################################################################3
# Bison-Generated Files
##################################################################3
$(GEN_DIR)/rangParser.hpp: bison/rangParser.y
	@echo "\n### Generating Bison RangParser ###"
	@mkdir -p $(@D)
	bison -v -o $(GEN_DIR)/rangParser.cpp -d $<

##################################################################3
# Flex-Generated Files
##################################################################3
$(GEN_DIR)/rangScanner.cpp: flex/rangScanner.l
	@echo "\n### Generating Flex RangScanner ###"
	@mkdir -p $(@D)
	flex -o $@ $<

##################################################################3
# Special Rule
##################################################################3
$(GEN_DIR)/rangScanner.hpp: $(GEN_DIR)/rangScanner.cpp


$(GEN_DIR)/location.hh: $(GEN_DIR)/rangParser.hpp

##################################################################3
# Object Files
##################################################################3

$(OBJ_DIR)/ast.o: src/ast.cpp $(GEN_DIR)/location.hh
	@echo "\n### Compiling ast.o ###"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@ -fPIC

$(OBJ_DIR)/error.o: src/error.cpp $(GEN_DIR)/location.hh
	@echo "\n### Compiling error.o ###"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@ -fPIC

$(OBJ_DIR)/rangScanner.o: $(GEN_DIR)/rangScanner.cpp
	@echo "\n### Compiling rangScanner.o ###"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@ -fPIC

$(OBJ_DIR)/rangParser.o: $(GEN_DIR)/rangParser.cpp include/rangScanner.hpp
	@echo "\n### Compiling rangparser.o ###"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@ -fPIC

$(OBJ_DIR)/rangBase.o: src/rangBase.cpp include/rangBase.hpp
	@echo "\n### Compiling rangBase.o ###"
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -MMD -o $@ -fPIC
##################################################################3
# Shared Library
##################################################################3

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
		make; \
		echo "\033[0;32m";\
		echo "###########################";\
		echo "### Waiting for changes ###";\
		echo "###########################";\
		echo "\033[0m";\
		fswatch -1 -r $(TO_WATCH_DIR) >/dev/null 2>&1;\
		done

help: ## Display this help
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'
