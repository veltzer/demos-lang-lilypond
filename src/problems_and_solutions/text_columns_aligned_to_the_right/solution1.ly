%{

The idea in this solution is to use 'right-align' to push everything to the right.
We have have one 'null' so 'fill-line' will be happy and will have something to put
on the left.
On the right side we gather everything under the 'concat' tag. We need this. otherwise
columns will be space by fill line and we want to determine the space between the columns.
We do this by the space. 'hspace' is the best here since it gives us control of how much space.

%}

\version "2.18.2"
\markup {
	\small {
		\fill-line {
			\hspace #0
			\right-align { % this gets pushed to the right by fill-line
				\concat {
					\right-column {
						\box "X"
						"נח - היונה כבר שבה עם עלה של זית"
						"נח - תן לנו לצאת ולחזור לבית"
						"כי כבר נמאסנו זה על זה"
						"האריה על הממותה, הגמל על השיבוטה"
					}
					\hspace #3
					\right-column {
						\box "Y"
						"נח - כמה זמן נמשיך לשוט על פני המים?"
						"נח - כל החלונות סגורים כמעט חודשיים."
						\vspace #0.5
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
}
