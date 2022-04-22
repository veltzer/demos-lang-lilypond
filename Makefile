##############
# parameters #
##############
# should we show commands executed ?
DO_MKDBG:=0
# should we do the tools?
DO_TOOlS:=1
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# vars #
########
SRC:=$(shell find src -name "*.ly")
TGT:=$(addsuffix .pdf, $(basename $(SRC)))
ALL:=$(TGT)

# dependency on tools.stamp
ifeq ($(DO_TOOLS),1)
.EXTRA_PREREQS+=tools.stamp
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

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

tools.stamp: config/deps.py
	$(info doing [$@])
	@touch $@

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)git clean -qffxd

.PHONY: debug
debug:
	$(info SRC is $(SRC))
	$(info TGT is $(TGT))
	$(info ALL is $(ALL))

##################
# patterns rules #
##################
$(TGT): %.pdf: %.ly scripts/wrapper_lilypond.py
	$(info doing [$@])
	$(Q)scripts/wrapper_lilypond.py $(dir $@)$(basename $(notdir $@)).ps $(dir $@)$(basename $(notdir $@)).pdf $(dir $@)$(basename $(notdir $@)) $<
