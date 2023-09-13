grammar CNTR;

start: COMMENT* verses EOF;

verse: reference SPACE content NEWLINE?;
verses: verse (NEWLINE verse)*;
blocks: block (SPACE block)*;
words: word (SPACE word)*;
content: empty | blocks;
block: word | edits;
controls: control+;
word: element+;
empty: MINUS;

control:
	verseRemnant
	| columnBreak
	| lineRemnant
	| lineBreak
	| pageBreak;

element:
	numericAbbreviation
	| wordSuppliedByVid
	| characterDamaged
	| characterMissing
	| wordSupplied
	| nominaSacra
	| REPLACEMENT
	| control
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
uncorrected: controls? X edit controls?;
corrected: controls? edit controls?;
second: controls? A edit controls?;
third: controls? B edit controls?;

reference: bookNumber chapterNumber verseNumber;
chapterNumber: DIGIT DIGIT DIGIT;
verseNumber: DIGIT DIGIT DIGIT;
bookNumber: DIGIT DIGIT;

COMMENT: '#' ~[\r\n]* ('\r'? '\n')?;
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
MINUS: '-';
PLUS: '+';
PIPE: '|';
X: 'x';
A: 'a';
B: 'b';
