%{

http://lsr.di.unimi.it/LSR/Item?id=765
see also http://lilypond.org/doc/v2.18/Documentation/notation/formatting-text
see also http://lilypond.org/doc/v2.18/Documentation/snippets/text

Defines right-aligned and centered long text with the possibility to set the baseline-skip as required. 
Code is taken from ./scm/define-mark-up-commands.scm and just slightly modified.
Author: harm6 from the german lilypondforum

%}


#(define (general-column align-dir baseline mols)
	(let* ((aligned-mols (map (lambda (x) (ly:stencil-aligned-to x X align-dir)) mols)))
	(stack-lines -1 0.0 baseline aligned-mols)))

#(define-markup-command (textRight layout props args)(markup-list?)
	#:properties ((baseline-skip))
	(general-column RIGHT baseline-skip (wordwrap-internal-markup-list layout props #f args)))

#(define-markup-command (textCenter layout props args)(markup-list?)
	#:properties ((baseline-skip))
	(general-column CENTER baseline-skip (wordwrap-internal-markup-list layout props #f args)))

\version "2.18.2"

\markup {
	\fill-line {
		\hspace #0 %% this is neccessary
		\concat {
			\textRight {
				\right-column {
					\box "A"
					"נח - היונה כבר שבה עם עלה של זית"
					"נח - תן לנו לצאת ולחזור לבית"
					"כי כבר נמאסנו זה על זה"
					"האריה על הממותה, הגמל על השיבוטה"
					\vspace #0.5
					\box "B"
					"נח - כמה זמן נמשיך לשוט על פני המים?"
					"נח - כל החלונות סגורים כמעט חודשיים."
				}
			}
			\hspace #3
			\textRight {
				\right-column {
					\box "Z"
					"נח - מה אתה דואג, הן כבר חדל הגשם"
					"נח - פתח את החלון, אולי הופיעה קשת"
					"ויראו אותה כולם"
					"האריה והממותה, הגמל והשיבוטה"
					"וגם ההיפופוטם."
					"פתח לרגע את הצוהר"
					"ואל תוך התכלת הלבנה"
					"שלח את היונה."
				}
			}
		}
	}
}
