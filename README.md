# Python nu package

Integrate python features into nu.

## Features
### Python venv

This Package adds functionality to use python venvs.

It allows stacking venvs (only the top one is active, but you can switch back a lot easier).

Usage:
- `pyvenv activate` (optional argument: specify which directory)
- `pyvenv deactivate`
- `pyvenv list`

### env-var conversion

[python docs: env vars](https://docs.python.org/3/using/cmdline.html#environment-variables)

The Package adds env-var conversions for:
- `PYTHONPATH`

### PIP

- [ ] Tab completion for integrated commands
- [ ] Parse output from `list`, etc
- `updateall`

### Pylint

- `parsed pylint`
- tab completion

### flake8

- `parsed flake8`
- tab completion

### mypy

- `parsed mypy`
- tab completion
