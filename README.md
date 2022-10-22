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

### Command wrappers

It wraps a few command to provide completions and parse the output:
- `pylint`
- `flake8`
- `mypy`
