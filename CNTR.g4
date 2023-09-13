grammar CNTR;

start: segment* EOF;
segment: head SPACE body;
body: block (SPACE block)*;
text: word (SPACE word)*;
block: word | edits;
word: element+;

element:
	page_break
	| column_break
	| line_break
	| line_remnant
	| character_damaged
	| character_missing
	| word_supplied
	| vid
	| nomina_sacra
	| verse_remnant
	| numeric_abbreviation
	| MACRON
	| LETTER;

count: DIGIT+;
page_break: BACKSLASH count?;
column_break: PIPE count?;
line_break: FORWARD_SLASH count?;
line_remnant: AMPERSAND;
character_damaged: PERCENT;
character_missing: CIRCUMFLEX;
word_supplied: TILDE;
nomina_sacra: EQUAL;
verse_remnant: ASTERISK;
vid: PLUS;
numeric_abbreviation: DOLLAR;

edits: first (SPACE second (SPACE third)?)?;
edit: OPEN_CURLY text? CLOSE_CURLY;
first: uncorrected SPACE corrected;
uncorrected: X edit;
corrected: edit;
second: A edit;
third: B edit;

head: book chapter verse;
book: DIGIT DIGIT;
chapter: DIGIT DIGIT DIGIT;
verse: DIGIT DIGIT DIGIT;

SPACE: ' ';
LETTER: [\u03b1-\u03c9];
DIGIT: [0-9];
BACKSLASH: '\\';
FORWARD_SLASH: '/';
AMPERSAND: '&';
PERCENT: '%';
CIRCUMFLEX: '^';
TILDE: '~';
EQUAL: '=';
ASTERISK: '*';
PLUS: '+';
DOLLAR: '$';
MACRON: '\u00af';
PIPE: '|';
OPEN_CURLY: '{';
CLOSE_CURLY: '}';
X: 'x';
A: 'a';
B: 'b';

LINE_COMMENT: '#' ~[\r\n]* -> skip;
NEWLINE: [\r\n]+ -> skip;
