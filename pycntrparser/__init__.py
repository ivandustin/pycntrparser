from .args.parse import parse as parse_args
from .expand import expand
from .parse import parse


def main():
    args = parse_args()
    paths = args.path
    filepaths = set(*map(expand, paths))
    list(map(parse, filepaths))
