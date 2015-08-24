%{

This example shows how you can combine 'bookpart' and variables.
You must:
- define the variables BEFORE the 'bookpart' starts.
- you must not use 'book' as variables are not allowed inside 'book'

%}

\version "2.18.2"

PartChords=\chordmode {
	a1:m | d1:m | a1*2:m |
}
\bookpart {
	\score {
		\new ChordNames="Partchords" \PartChords
	}
}
