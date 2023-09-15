grammar CNTR;

start: COMMENT* verses EOF;

verse: reference SPACE text NEWLINE?;
verses: verse (NEWLINE verse)*;
blocks: block (SPACE block)*;
words: word (SPACE word)*;
block: word | edited;
text: empty | blocks;
elements: element+;
word: elements;
empty: MINUS;

letter: ALPHA_TO_OMEGA | KAI | COPTIC_TAU_RO | REPLACEMENT;
symbol: letter | MACRON | LOWER_NUMERAL_SIGN;

element:
	numericAbbreviation
	| wordSuppliedByVid
	| characterDamaged
	| characterMissing
	| verseRemnant
	| wordSupplied
	| columnBreak
	| lineRemnant
	| nominaSacra
	| lineBreak
	| pageBreak
	| symbol;

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

edited: first (SPACE second)? (SPACE third)?;
edit: OPEN_CURLY words? CLOSE_CURLY;

first:
	elements? uncorrected elements? SPACE corrected
	| elements? corrected elements?;
uncorrected: X edit;
corrected: edit;
second: A edit;
third: B edit;

reference: bookNumber chapterNumber verseNumber;
chapterNumber: DIGIT DIGIT DIGIT;
verseNumber: DIGIT DIGIT DIGIT;
bookNumber: DIGIT DIGIT;

ALPHA_TO_OMEGA: [\u03b1-\u03c9];
LOWER_NUMERAL_SIGN: '\u0375';
COPTIC_TAU_RO: '\u2ce8';
REPLACEMENT: '\ufffd';
MACRON: '\u00af';
KAI: '\u03d7';

COMMENT: '#' ~[\r\n]* ('\r'? '\n')?;
NEWLINE: '\r'? '\n';
FORWARD_SLASH: '/';
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
