from antlr4 import InputStream, CommonTokenStream
from CNTRParser import CNTRParser
from CNTRLexer import CNTRLexer


def parse(filepath):
    content = filepath.read_text(encoding="utf-8")
    lexer = CNTRLexer(InputStream(content))
    stream = CommonTokenStream(lexer)
    parser = CNTRParser(stream)
    parser.start()
