grammar CNTR;

start: verse+ EOF;
verse: reference (SPACE word+)+;
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

reference: book_number chapter_number verse_number;
book_number: DIGIT DIGIT;
chapter_number: DIGIT DIGIT DIGIT;
verse_number: DIGIT DIGIT DIGIT;

LINE_COMMENT: '#' ~[\r\n]* -> skip;
NEWLINE: [\r\n]+ -> skip;
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
