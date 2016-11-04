'''
dependencies for this project
'''

def populate(d):
    d.packs=[
        'lilypond',
        'lilypond-doc',
        'lilypond-doc-html',
        'lilypond-doc-pdf',
    ]

def getdeps():
    return [
        __file__, # myself
    ]
