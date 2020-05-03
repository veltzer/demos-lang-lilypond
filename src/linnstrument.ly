\version "2.18.2"

\header {
  title = "Blue Bossa"
  composer = "Kenny Dorham"
  enteredby = "Adrian Sieber"
  head = "LinnStrument"
}

linnstrument-fourths = \stringTuning <f,, bes,, ees, aes, des ges b e'>

melody = \relative g {
  \time 4/4
  \key ees \major

  r4 r4 r4 g,4 \bar ".|:" g'4. f8 ees d4 c8~ | c2. bes4 | aes2 g'4. f8~ | f1 |
  f4. ees 8 d c4 bes8~ | bes2. aes4 | g2 f'4. ees8~ | ees1 |
  ees4. des8 c bes4 aes8~ | aes2. ges4 |
  ges f8 bes ~ bes4 aes8 aes8~ | aes2. r4 |
  aes4 g8 bes8 ~ bes4. aes8 | aes4 g8 bes~ bes4. aes8 | g1~ | g2. r4 \bar ":|."
}

chord_progression = \chords {
  r1 | c1*2:m7 | f1*2:m7 |
  d1:m7.5- | g:7 | c1*2:m7 |
  ees1:m7 | aes:7 | des1*2:maj |
  d1:m7.5- | g:7 | c1:m7 | d2:m7.5- g:7
}

\paper {
  system-system-spacing = #'((basic-distance . 22))
  markup-system-spacing = #'((basic-distance . 22))
}

\score {
  \layout {
    indent = 3\cm
    #(layout-set-staff-size 25)
  }

  <<
  \chord_progression
  {
    \new TabStaff \with {
      instrumentName = #"LinnStrument"
    }
    {
      \tabFullNotation
      \set TabStaff.stringTunings = #linnstrument-fourths
      % No open strings on Linnstrument, first pad is fret 1
      \set TabStaff.minimumFret = #1
      \set TabStaff.restrainOpenStrings = ##t
      \melody
    }
  }
  >>
}
