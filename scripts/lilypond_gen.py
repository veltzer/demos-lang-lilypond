#!/usr/bin/env python

""" Generator adapter for the lilypond wrapper. rsconstruct's generator calls
this as lilypond_gen.py <input.ly> <output.pdf>; the existing
scripts/wrapper_lilypond.py wants four arguments (ps, pdf, base-without-suffix,
input), so this derives the ps and base paths from the pdf path and forwards. """

import os
import subprocess
import sys


def main():
    """ main entry point """
    source, pdf = sys.argv[1], sys.argv[2]
    base = os.path.splitext(pdf)[0]
    ps = base + ".ps"
    os.makedirs(os.path.dirname(pdf), exist_ok=True)
    wrapper = os.path.join(os.path.dirname(__file__), "wrapper_lilypond.py")
    sys.exit(subprocess.call([wrapper, ps, pdf, base, source]))


if __name__ == "__main__":
    main()
