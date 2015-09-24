%{

This example shows the problem of aligning text to the right in lilypond.
Without the following two empty 'right-column' entires this example
would show up with one column aligned to the right of the screen
and the other to the right with lots of space in between.

I am not aware of any other means to get at the result that you get
from this example which does not involved the two 'right-column' entires.

This is an unstable solution since the number of 'right-column' entries
involved is a function of the page width.

Is there a way in lilypond for a more straight forward solution to this
problem?

%}

\version "2.18.2"

\markup {
	\small {
		\fill-line {
			\right-column {
				\null
			}
			\right-column {
				\null
			}
			\right-column {

				\box "A"
				"נח - היונה כבר שבה עם עלה של זית"
				"נח - תן לנו לצאת ולחזור לבית"
				"כי כבר נמאסנו זה על זה"
				"האריה על הממותה, הגמל על השיבוטה"
				"וגם ההיפופוטם."
				"פתח לרגע את הצוהר"
				"ונעוף לתכלת הלבנה"
				"כך עם היונה."
			}
			\null
			\right-column {

				\box "A"
				"נח - כמה זמן נמשיך לשוט על פני המים?"
				"נח - כל החלונות סגורים כמעט חודשיים."
				"וכבר אין לנו אויר"
				"לאריה ולממותה לגמל ולשיבוטה"
				"וגם להיפופוטם."
				"פתח לרגע את הצוהר"
				"ואל תוך התכלת הלבנה"
				"שלח את היונה."
				\null

				\box "A"
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
