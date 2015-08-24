\version "2.18.2"

\score {
	<<
		\new ChordNames="mychordname" {
			\chordmode {
				c1 | g1 |
			}
		}
		\new Voice="foo" \relative { \appoggiatura e8 a4 b c d | \acciaccatura e8\f a4 b c d }
	>>
}
