grammar CNTR;

start: verses EOF;

verse: reference SPACE text NEWLINE?;
verses: verse (NEWLINE verse)*;

letter:
	ALPHA_TO_OMEGA
	| COPTIC_TAU_RO
	| REPLACEMENT
	| STIGMA
	| KOPPA
	| KAI
	| MOU;

symbol: letter | MACRON | LOWER_NUMERAL_SIGN;

character: symbol | characterDamaged | characterMissing;

format:
	verseRemnant
	| lineRemnant
	| columnBreak
	| lineBreak
	| pageBreak;

wordType: nominaSacra | numericAbbreviation;

word:
	format* (wordSupplied | wordSuppliedByVid)* wordType? character (
		character
		| format
	)*;

block: word | editedText;
blocks: block (SPACE block)*;

text: format* (alternateVersification? (blocks | empty))?;

lineBreak: FORWARD_SLASH count?;
alternateVersification: DIAMOND;
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
empty: MINUS;

editedText: first (SPACE second)? (SPACE third)?;
editedTextBody: OPEN_CURLY text CLOSE_CURLY;

first: uncorrected SPACE corrected | corrected;
uncorrected: X editedTextBody;
corrected: editedTextBody;
second: A editedTextBody;
third: B editedTextBody;

reference: bookNumber chapterNumber verseNumber;
chapterNumber: DIGIT DIGIT DIGIT;
verseNumber: DIGIT DIGIT DIGIT;
bookNumber: DIGIT DIGIT;

ALPHA_TO_OMEGA: [\u03b1-\u03c9];
LOWER_NUMERAL_SIGN: '\u0375';
COPTIC_TAU_RO: '\u2ce8';
REPLACEMENT: '\ufffd';
MACRON: '\u00af';
STIGMA: '\u03db';
KOPPA: '\u03df';
KAI: '\u03d7';
MOU: '\ue001';

NEWLINE: '\r'? '\n';
FORWARD_SLASH: '/';
DIAMOND: '\u22c4';
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