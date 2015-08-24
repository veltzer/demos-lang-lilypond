%{

This is an attempt to write a function doing nothing with it's arguments

References:
http://stackoverflow.com/questions/19396078/what-language-mechanisms-does-lilypond-have-for-simple-abbreviations-to-avoid-c

%}

\version "2.18.2"

myGrace = #(define-music-function (parser location notes) (ly:music?) #{ #})

\score {
	<<
		\new Voice="foo" \relative { \myGrace { a8 b } a2 \myGrace b8 a2 }
	>>
}
