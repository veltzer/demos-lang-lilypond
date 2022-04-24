##############
# parameters #
##############
# should we show commands executed ?
DO_MKDBG:=0
# should we do the tools?
DO_TOOLS:=1
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# vars #
########
ALL:=
TOOLS:=tools.stamp
SRC:=$(shell find src -name "*.ly")
TGT:=$(addsuffix .pdf, $(basename $(SRC)))

# dependency on tools.stamp
ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=tools.stamp
ALL+=$(TOOLS)
endif

# dependency on the makefile itself
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif

ifeq ($(DO_MKDBG),1)
Q=
# we are not silent in this branch
else # DO_MKDBG
Q=@
#.SILENT:
endif # DO_MKDBG

ALL+=$(TGT)

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

$(TOOLS):  config.deps packages.txt
	$(info doing $@)
	$(Q)xargs -a packages.txt sudo apt-get install
	$(Q)touch $@

.PHONY: clean
clean:
	$(Q)rm $(ALL)

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd

.PHONY: debug
debug:
	$(info SRC is $(SRC))
	$(info TGT is $(TGT))
	$(info ALL is $(ALL))

############
# patterns #
############
$(TGT): %.pdf: %.ly scripts/wrapper_lilypond.py
	$(info doing [$@])
	$(Q)scripts/wrapper_lilypond.py $(dir $@)$(basename $(notdir $@)).ps $(dir $@)$(basename $(notdir $@)).pdf $(dir $@)$(basename $(notdir $@)) $<
