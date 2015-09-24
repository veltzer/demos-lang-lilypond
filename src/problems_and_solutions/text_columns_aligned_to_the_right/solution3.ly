%{

This is the simplest solution.
- \hspace #0 is needed so that 'fill-line' will have something to put on the right side.
- \concat is needed since otherwise you will not be able to control the space
between the columns.
- the columns must be 'right-column':
	right: because otherwise you won't get RTL text in them.
	column: because otherwise they will be on a single line.
- fill-line is needed because without it the text would not appear on the right side
	of the page.

%}

\version "2.18.2"

\markup {
	\fill-line {
		\hspace #0
		\concat {
			\right-column {
				\box "A"
				"נח - היונה כבר שבה עם עלה של זית"
				"נח - תן לנו לצאת ולחזור לבית"
				"כי כבר נמאסנו זה על זה"
				"האריה על הממותה, הגמל על השיבוטה"
				\vspace #0.3
				\box "B"
				"נח - כמה זמן נמשיך לשוט על פני המים?"
				"נח - כל החלונות סגורים כמעט חודשיים."
			}
			\hspace #3
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
