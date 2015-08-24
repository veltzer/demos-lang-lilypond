%{

This example demonstrates the problem with grace notes, appogiaturas and the like.

References:
http://www.lilypond.org/doc/v2.19/Documentation/notation/special-rhythmic-concerns

%}

\version "2.18.2"

\score {
	<<
		\new Staff \relative { e''4 \bar ".|:" \grace c16 d2. }
		\new Staff \relative { c''4 \bar ".|:" d2. }
	>>
}
