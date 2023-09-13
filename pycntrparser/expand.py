def expand(path):
    if path.is_dir():
        return path.glob("**/*.txt")
    return [path]
