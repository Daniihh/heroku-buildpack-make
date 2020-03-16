.PHONY: clean
clean:
	rm -rf workspace
	mkdir workspace

.PHONY: run_detect
run_detect:
	cd ./workspace && ./../../bin/detect

.PHONY: setup_detect_none
setup_detect_none: clean

.PHONY: detect_none
detect_none: setup_detect_none run_detect

.PHONY: setup_detect_lower_case
setup_detect_lower_case: clean
	touch ./workspace/makefile

.PHONY: detect_lower_case
detect_lower_case: setup_detect_lower_case run_detect

.PHONY: setup_detect_upper_case
setup_detect_upper_case: clean
	touch ./workspace/Makefile

.PHONY: detect_upper_case
detect_upper_case: setup_detect_upper_case run_detect

.PHONY: setup_detect_gnu
setup_detect_gnu: clean
	touch ./workspace/GNUMakefile

.PHONY: detect_gnu
detect_gnu: setup_detect_gnu run_detect

# .PHONY: setup_compile_no_targets
# setup_compile_no_targets: clean
# 	touch ./workspace/makefile

# .PHONY: compile_no_targets
# compile_no_targets: setup_compile_no_targets
