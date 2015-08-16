%% This example explores how to do multiple voices right which are
%% well aligned. If you just write three voices and add them up they are not well
%% aligned. See the example

\version "2.18.2"

\score {
	<<
		\time 3/4
		%% The problem
		\new Staff <<
			\new Voice \relative { \voiceOne r8 e'' g f e dis | e2 e4 }
			\new Voice \relative { \voiceTwo s2. | s4 <c'' a>4 <c a>4 }
			\new Voice \relative { \voiceThree s2. | a2. }
		>>
		%% \parallelMusic DOES NOT solve the problem
		\parallelMusic #'(voiceA voiceB voiceC) \relative {
			\time 3/4
			% Bar 1
			r8 e'' g f e dis |
			s2. |
			s2. |
			% Bar 2
			e2 e4 |
			r4 <c a>4 <c a>4 |
			a,2. |
		}
		\new StaffGroup <<
			\new Staff << \voiceA \\ \voiceB \\ \voiceC >>
		>>
		%% \partcombine DOES NOT solve the problem
		\new Staff << \partcombine \voiceA \voiceB \voiceC >>
		\new Staff << \relative { r8 e'' g f e dis | <e a,,>2. } >>
	>>
}
