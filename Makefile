##############
# parameters #
##############
# should we show commands executed ?
DO_MKDBG:=0
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1

########
# code #
########
ALL:=
SRC:=$(shell find src -type f -and -name "*.ly")
TGT:=$(addprefix out/,$(addsuffix .pdf, $(basename $(SRC))))

# parallelize
# MAKEFLAGS := --jobs=$(shell nproc)

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
$(TGT): out/%.pdf: %.ly scripts/wrapper_lilypond.py
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)scripts/wrapper_lilypond.py $(dir $@)$(basename $(notdir $@)).ps $(dir $@)$(basename $(notdir $@)).pdf $(dir $@)$(basename $(notdir $@)) $<

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
