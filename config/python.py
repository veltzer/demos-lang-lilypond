""" python deps for this project """

build_requires: list[str] = [
    "pydmt",
    "pymakehelper",
]
test_requires: list[str] = [
    "pylint",
]
requires = build_requires + test_requires
