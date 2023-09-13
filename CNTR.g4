grammar CNTR;

start: verses EOF;
verses: verse (NEWLINE verse)*;
verse: reference SPACE blocks NEWLINE?;
blocks: block (SPACE block)*;
words: word (SPACE word)*;
block: word | edits;
word: element+;

element:
	pageBreak
	| columnBreak
	| lineBreak
	| lineRemnant
	| characterDamaged
	| characterMissing
	| wordSupplied
	| wordSuppliedByVid
	| nominaSacra
	| verseRemnant
	| numericAbbreviation
	| MACRON
	| LETTER;

count: DIGIT+;
pageBreak: BACKSLASH count?;
columnBreak: PIPE count?;
lineBreak: FORWARD_SLASH count?;
lineRemnant: AMPERSAND;
characterDamaged: PERCENT;
characterMissing: CIRCUMFLEX;
wordSupplied: TILDE;
nominaSacra: EQUAL;
verseRemnant: ASTERISK;
wordSuppliedByVid: PLUS;
numericAbbreviation: DOLLAR;

edits: first (SPACE second (SPACE third)?)?;
edit: OPEN_CURLY words? CLOSE_CURLY;
first: uncorrected SPACE corrected;
uncorrected: X edit;
corrected: edit;
second: A edit;
third: B edit;

reference: bookNumber chapterNumber verseNumber;
bookNumber: DIGIT DIGIT;
chapterNumber: DIGIT DIGIT DIGIT;
verseNumber: DIGIT DIGIT DIGIT;

NEWLINE: '\r'? '\n';
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

COMMENT: '#' ~[\r\n]* ('\r'? '\n')? -> skip;
