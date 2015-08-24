%{

This example shows the meaning of \relative {} (without
specifying a starting pitch that everything is relative
to...)

Results:
by default we are relative to c and not c' so c does
not mean middle c but rather one octave below.

References:
http://lilypond.org/doc/v2.18/Documentation/notation/writing-pitches

%}

\version "2.18.2"

\score {
	<<
		\new Voice="foo" \relative { c d e f g }
	>>
}
