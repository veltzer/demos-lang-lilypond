#!/usr/bin/env python3

"""
wrapper to run lilypond.
run lilypond to produce the book
lilypond --ps --pdf --output=$(OUT_BASE) $(OUT_LY)

Why do we need this script?
- To make sure to remove the outputs (all of them - ps, pdf, ...) in any case of error.
- To get over lilypond printing junk on the console that I dont want to see when building.
- To get over the fact that lilypond does not have a "treat warnings as errors and stop" flag.
- To print the lilypond output, but only in case of error.
- To do extra stuff on the output coming out from lilypond like reduce the size of the pdf and more.
"""

import sys
import os
import os.path
import subprocess
import shutil
import tempfile


# do postscript?
P_DO_PS=True
# do pdf?
P_DO_PDF=True
# emit debug info?
P_DEBUG=False
# unlink the postscript file at the end?
P_UNLINK_PS=False
# do you want to linearize the pdf file afterwards?
P_DO_QPDF=True
# what warning level do you want?
# we really need to work with warnings and solve all of them
P_LOGLEVEL="WARN"
#P_LOGLEVEL="ERROR"
# should we reduce the pdf size?
P_DO_PDFRED=True


def remove_outputs_if_exist(p_ps, p_pdf):
    """
    remove the target files, do nothing if they are not there
    """
    if os.path.isfile(p_ps):
        os.unlink(p_ps)
    if os.path.isfile(p_pdf):
        os.unlink(p_pdf)


def print_outputs(output, errout, status, args):
    """
    print output of the program in case of error
    """
    if output!="":
        print(f"{sys.argv[0]}: stdout is\n{output}", file=sys.stderr)
    if errout!="":
        print(f"{sys.argv[0]}: stderr is\n{errout}", file=sys.stderr)
    print(f"{sys.argv[0]}: return code is [{status}]", file=sys.stderr)
    print(f"{sys.argv[0]}: error in executing {args}", file=sys.stderr)


def system_check_output(args, p_ps, p_pdf, stop_on_output=True):
    """
    this function is here because we want to supress output until we know
    there is an error (and subprocess.check_output does not do this)
    """
    if P_DEBUG:
        print(f"{sys.argv[0]}: running [{args}]", file=sys.stderr)
    with subprocess.Popen(args,stdout=subprocess.PIPE,stderr=subprocess.PIPE) as process:
        (output,errout)=process.communicate()
        output=output.decode()
        errout=errout.decode()
        if P_DEBUG or process.returncode or (stop_on_output and (output!="" or errout!="")):
            print_outputs(output, errout, process.returncode, args)
            remove_outputs_if_exist(p_ps, p_pdf)
            sys.exit(1)


def main():
    """
    main entry point
    """
    if len(sys.argv)!=5:
        print(f"{sys.argv[0]}: usage: [ps] [pdf] [pdf without suffix] [lilypond input]")
        sys.exit(1)

    p_ps=sys.argv[1]
    p_pdf=sys.argv[2]
    p_out=sys.argv[3]
    p_ly=sys.argv[4]

    if P_DEBUG:
        print(f"{sys.argv[0]}: arguments are [{sys.argv}]", file=sys.stderr)

    remove_outputs_if_exist(p_ps, p_pdf)

    # run the command
    args=[]
    args.append("lilypond")
    args.append(f"--loglevel={P_LOGLEVEL}")
    if P_DO_PS:
        args.append("--ps")
    if P_DO_PDF:
        args.append("--pdf")
    args.append(f"--output={p_out}")
    args.append(p_ly)
    try:
        # to make sure that lilypond shuts up...
        #subprocess.check_output(args)
        system_check_output(args, p_ps, p_pdf)
        # chmod the results
        if P_DO_PS:
            os.chmod(p_ps,0o0444)
        if P_DO_PDF:
            os.chmod(p_pdf,0o0444)
    except Exception:
        remove_outputs_if_exist(p_ps, p_pdf)
        print(f"{sys.argv[0]}: exiting because of errors", file=sys.stderr)
        sys.exit(1)

    # do pdf reduction
    if P_DO_PDFRED:
        with tempfile.NamedTemporaryFile() as temp:
            # LanguageLevel=2 is the default
            system_check_output(["pdf2ps", "-dLanguageLevel=3", p_pdf, temp.name], p_ps, p_pdf)
            os.unlink(p_pdf)
            system_check_output(["ps2pdf", temp.name, p_pdf], p_ps, p_pdf, stop_on_output=False)

    # do linearization
    if P_DO_QPDF:
        # delete=False since we are going to move the file
        with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf") as temp:
            system_check_output(["qpdf", "--linearize", p_pdf, temp.name], p_ps, p_pdf)
            shutil.move(temp.name, p_pdf)

    # remove the postscript file if need be or chmod it
    if os.path.isfile(p_ps):
        if P_UNLINK_PS:
            os.unlink(p_ps)
        else:
            os.chmod(p_ps,0o0444)

    # chmod the pdf file
    if os.path.isfile(p_pdf):
        os.chmod(p_pdf,0o0444)


if __name__ == "__main__":
    main()
