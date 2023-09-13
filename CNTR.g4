grammar CNTR;

start: verses EOF;
verses: verse (NEWLINE verse)*;
verse: reference SPACE blocks NEWLINE?;
blocks: block (SPACE block)*;
words: word (SPACE word)*;
block: word | edits;
word: element+;

element:
	numericAbbreviation
	| wordSuppliedByVid
	| characterDamaged
	| characterMissing
	| verseRemnant
	| wordSupplied
	| columnBreak
	| nominaSacra
	| lineRemnant
	| REPLACEMENT
	| lineBreak
	| pageBreak
	| LETTER
	| MACRON;

lineBreak: FORWARD_SLASH count?;
characterMissing: CIRCUMFLEX;
numericAbbreviation: DOLLAR;
pageBreak: BACKSLASH count?;
characterDamaged: PERCENT;
columnBreak: PIPE count?;
wordSuppliedByVid: PLUS;
lineRemnant: AMPERSAND;
verseRemnant: ASTERISK;
wordSupplied: TILDE;
nominaSacra: EQUAL;
count: DIGIT+;

edits: first (SPACE second (SPACE third)?)?;
edit: OPEN_CURLY words? CLOSE_CURLY;
first: uncorrected SPACE corrected;
uncorrected: X edit;
corrected: edit;
second: A edit;
third: B edit;

reference: bookNumber chapterNumber verseNumber;
chapterNumber: DIGIT DIGIT DIGIT;
verseNumber: DIGIT DIGIT DIGIT;
bookNumber: DIGIT DIGIT;

LETTER: [\u03b1-\u03c9];
REPLACEMENT: '\ufffd';
NEWLINE: '\r'? '\n';
FORWARD_SLASH: '/';
MACRON: '\u00af';
CLOSE_CURLY: '}';
BACKSLASH: '\\';
CIRCUMFLEX: '^';
OPEN_CURLY: '{';
AMPERSAND: '&';
ASTERISK: '*';
DIGIT: [0-9];
PERCENT: '%';
DOLLAR: '$';
SPACE: ' ';
TILDE: '~';
EQUAL: '=';
PLUS: '+';
PIPE: '|';
X: 'x';
A: 'a';
B: 'b';

COMMENT: '#' ~[\r\n]* ('\r'? '\n')? -> skip;
