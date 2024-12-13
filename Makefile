# Makeall
# Abeba Nigussie Turi, December 2024
# Makefile for automating word counting, plotting, and report generation

# Makefile to automate word count and plotting pipeline

.PHONY: all clean

# Variables
DATA_DIR = data
RESULTS_DIR = results
FIGURES_DIR = $(RESULTS_DIR)/figure
SCRIPTS_DIR = scripts

# Input and Output files
INPUT_FILE = $(DATA_DIR)/isles.txt
OUTPUT_FILE = $(RESULTS_DIR)/isles.dat
PLOT_OUTPUT_FILE = $(FIGURES_DIR)/isles.png

# Default target: Run all tasks
all: $(OUTPUT_FILE) $(PLOT_OUTPUT_FILE) report/count_report.html

# Task to generate the word counts (dat file)
$(OUTPUT_FILE): $(INPUT_FILE)
	python $(SCRIPTS_DIR)/wordcount.py --input_file=$(INPUT_FILE) --output_file=$(OUTPUT_FILE)

# Task to generate the plot (PNG file)
$(PLOT_OUTPUT_FILE): $(OUTPUT_FILE)
	python $(SCRIPTS_DIR)/plotcount.py --input_file=$(OUTPUT_FILE) --output_file=$(PLOT_OUTPUT_FILE)

# Task to generate the Quarto report
report/count_report.html: $(OUTPUT_FILE) $(PLOT_OUTPUT_FILE) report/count_report.qmd
	quarto render report/count_report.qmd


# Task to clean up generated files
clean:
	rm -f $(OUTPUT_FILE) $(PLOT_OUTPUT_FILE)
	rm -f $(RESULTS_DIR)/count_report.html
