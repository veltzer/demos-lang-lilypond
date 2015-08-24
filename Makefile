.PHONY: all
all:
	$(info Tell me what to do...)
	@exit 0

.PHONY: clean
clean:
	$(info doing [$@])
	@rm -f */*.pdf */*.midi */*.ps
