# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `scripts/wrapper_lilypond.py:132,134` - the pdf-reduction step runs `pdf2ps` and `ps2pdf` (ghostscript), but `rsconstruct.toml:33-36` declares only `lilypond` and `qpdf` under `[dependencies] system`; add `ghostscript` so `rsconstruct tool install-deps` provisions everything the build runs.
- `scripts/wrapper_lilypond.py:24,30,143-148` - lilypond is run with `--ps` and the `.ps` is kept (`P_UNLINK_PS=False`), so every score leaves an undeclared `out/<name>.ps` next to the declared `out/<name>.pdf` (17 such files in `out/` now); rsconstruct neither tracks nor cleans them. Set `P_DO_PS=False` (the pdf-reduction step makes its own temporary ps) or unlink the ps at the end.
- `tera.templates/.github/dependabot.yml.tera` - never rendered: `rsconstruct.toml` has no `[processor.tera]` and the repo has no `config/personal.lua`/`config/version.lua`, so the committed `.github/dependabot.yml` is a hand-kept copy that already differs from what the template renders elsewhere (missing blank line, compare `../c-kcpp/.github/dependabot.yml`). Add the standard `[processor.tera]` stanza and the config files it needs.
- `README.md:1-6` - hand-written stub ("2011-2014", setext heading) instead of the fleet `tera.templates/README.md.tera`; add the shared template (with a `tera.snippets/main.md.tera` for the repo text) so the README is generated like the rest of the fleet.

## Low

- `rsconstruct.toml:10,14` - ruff and mypy `src_dirs` include `src`, which holds no Python files (only `.ly`); limit them to `scripts`.
- `pyproject.toml:10` - `pytest` is a dev dependency but the repo has no tests and no pytest processor; drop it.
- `src/book_example.ly.fixme`, `src/book_example_parts.ly.fixme` - examples that do not compile, tracked by `doc/TODO.txt:1`; fix them and rename to `.ly`, or delete them and the TODO.
- `src/multiple_voices.ly.moved` - leftover of a file moved elsewhere; delete it.
- `scripts/wrapper_lilypond.py:139-141` - the qpdf temp file is created with `delete=False`; if `system_check_output` exits on a qpdf error the temp file is leaked in `/tmp`. Remove it on the error path.
