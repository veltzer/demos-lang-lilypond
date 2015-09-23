%{

This example explores issues with defining variables in book context
It seems that you can't.
Solutions? There are two options:
- Define the variable 'PartChords' *BEFORE* the '\book' context.
- Dont use the \book markup at all ...:)
	It seems that you can still have \bookpart without the \book markup.

%}

\version "2.18.2"

PartChords=\chordmode {
	a1:m | d1:m | a1*2:m |
}

\book {
	\score {
		\new ChordNames="Partchords" \PartChords
	}
}
