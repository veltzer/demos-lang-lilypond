%{

This example explores issues with defining variables in book context
what is the solution? dont use the \book markup...:)
It seems that you can still have \bookpart without the \book markup.

%}

\version "2.18.2"

\book {
	PartChords=\chordmode {
		a1:m | d1:m | a1*2:m |
	}
	\score {
		\new ChordNames="Partchords" \PartChords
	}
}
