from pycntrparser.args.parse import parse as parse_args
from pycntrparser.expand import expand
from pycntrparser.parse import parse


def main():
    args = parse_args()
    paths = args.path
    filepaths = set(*map(expand, paths))
    list(map(parse, filepaths))


if __name__ == "__main__":
    main()
