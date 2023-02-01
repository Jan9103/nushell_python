# lint files with mypy
export def 'parsed mypy' [
	--config-file: path
	...paths: path
] {
	^mypy ([
		(if $config_file != null {$'--config-file ($config_file)'})
	] | compact) --show-error-codes $paths
	| lines
	| parse '{file}:{line}: {type}: {description}  [{error_code}]'
	| upsert line {|i| $i.line | into int}
}

def 'complete nor_sil_ski_err' [] { ['normal' 'silent' 'skip' 'error'] }

export extern 'mypy' [
	...files: path
	--help(-h)
	--verbose(-v) # More verbose messages
	--version(-V) # Show program's version number and exit
	--config-file: path # Configuration file, must have a [mypy] section (defaults to mypy.ini, .mypy.ini, pyproject.toml, setup.cfg, ~/.config/mypy/config, ~/.mypy.ini)
	--warn-unused-configs # Warn about unused '[mypy-<pattern>]' or '[[tool.mypy.overrides]]' config sections (inverse: --no-warn-unused-configs)
	--no-warn-unused-configs
	--namespace-packages # Support namespace packages (PEP 420, __init__.py-less) (inverse: --no-namespace-packages)
	--no-namespace-packages
	--ignore-missing-imports # Silently ignore imports of missing modules
	--follow-imports: string@'complete nor_sil_ski_err' # How to treat imports (default normal)
	--python-executable: path #  Python executable used for finding PEP 561 compliant installed packages and stubs
	--no-site-packages # Do not search for installed PEP 561 compliant packages
	--no-silence-site-packages # Do not silence errors in PEP 561 compliant installed packages
	--python-version: string # Type check code assuming it will be running on Python x.y
	--py2(-2) #  Use Python 2 mode (same as --python-version 2.7)
	--platform: string # Type check special-cased code for the given OS platform (defaults to sys.platform)
	--always-true: string # Additional variable to be considered True (may be repeated)
	--always-false: string # Additional variable to be considered False (may be repeated)
	--disallow-any-unimported # Disallow Any types resulting from unfollowed imports
	--disallow-any-expr # Disallow all expressions that have type Any
	--disallow-any-decorated # Disallow functions that have Any in their signature after decorator transformation
	--disallow-any-explicit # Disallow explicit Any in type positions
	--disallow-any-generics # Disallow usage of generic types that do not specify explicit type parameters (inverse: --allow-any-generics)
	--allow-any-generics
	--disallow-subclassing-any # Disallow subclassing values of type 'Any' when defining classes (inverse: --allow-subclassing-any)
	--allow-subclassing-any
	--disallow-untyped-calls # Disallow calling functions without type annotations from functions with type annotations (inverse: --allow-untyped-calls)
	--allow-untyped-calls
	--disallow-untyped-defs # Disallow defining functions without type annotations or with incomplete type annotations (inverse: --allow-untyped-defs)
	--allow-untyped-defs
	--disallow-incomplete-defs # Disallow defining functions with incomplete type annotations (inverse: --allow-incomplete-defs)
	--allow-incomplete-defs
	--check-untyped-defs # Type check the interior of functions without type annotations (inverse: --no-check-untyped-defs)
	--no-check-untyped-defs
	--disallow-untyped-decorators # Disallow decorating typed functions with untyped decorators (inverse: --allow-untyped-decorators)
	--allow-untyped-decorators
	--no-implicit-optional # Don't assume arguments with default values of None are Optional (inverse: --implicit-optional)
	--implicit-optional
	--no-strict-optional # Disable strict Optional checks (inverse: --strict-optional)
	--strict-optional
	--warn-redundant-casts # Warn about casting an expression to its inferred type (inverse: --no-warn-redundant-casts)
	--no-warn-redundant-casts
	--warn-unused-ignores # Warn about unneeded '# type: ignore' comments (inverse: --no-warn-unused-ignores)
	--no-warn-unused-ignores
	--no-warn-no-return # Do not warn about functions that end without returning (inverse: --warn-no-return)
	--warn-no-return
	--warn-return-any # Warn about returning values of type Any from non-Any typed functions (inverse: --no-warn-return-any)
	--no-warn-return-any
	--warn-unreachable # Warn about statements or expressions inferred to be unreachable (inverse: --no-warn-unreachable)
	--no-warn-unreachable
	--allow-untyped-globals # Suppress toplevel errors caused by missing annotations (inverse: --disallow-untyped-globals)
	--disallow-untyped-globals
	--allow-redefinition # Allow unconditional variable redefinition with a new type (inverse: --disallow-redefinition)
	--disallow-redefinition
	--no-implicit-reexport # Treat imports as private unless aliased (inverse: --implicit-reexport)
	--implicit-reexport
	--strict-equality # Prohibit equality, identity, and container checks for non-overlapping types (inverse: --no-strict-equality)
	--no-strict-equality
	--strict-concatenate # Make arguments prepended via Concatenate be truly positional-only (inverse: --no-strict-concatenate)
	--no-strict-concatenate
	--strict # Strict mode; enables the following flags: --warn-unused-configs, --disallow-any-generics, --disallow-subclassing-any, --disallow-untyped-calls,--disallow-untyped-defs, --disallow-incomplete-defs, --check-untyped-defs,--disallow-untyped-decorators, --no-implicit-optional, --warn-redundant-casts, --warn-unused-ignores, --warn-return-any, --no-implicit-reexport,--strict-equality, --strict-concatenate
	--disable-error-code: string # Disable a specific error code
	--enable-error-code: string # Enable a specific error code
	--show-error-context # Precede errors with "note:" messages explaining context (inverse: --hide-error-context)
	--hide-error-context
	--show-column-numbers # Show column numbers in error messages (inverse: --hide-column-numbers)
	--hide-column-numbers
	--show-error-end # Show end line/end column numbers in error messages. This implies --show-column-numbers (inverse: --hide-error-end)
	--hide-error-end
	--show-error-codes # Show error codes in error messages (inverse: --hide-error-codes)
	--hide-error-codes
	--pretty # Use visually nicer output in error messages: Use soft word wrap, show source code snippets, and show error location markers (inverse: --no-pretty)
	--no-pretty
	--no-color-output # Do not colorize error messages (inverse: --color-output)
	--color-output
	--no-error-summary # Do not show error stats summary (inverse: --error-summary)
	--error-summary
	--show-absolute-path # Show absolute paths to files (inverse: --hide-absolute-path)
	--hide-absolute-path
	--no-incremental # Disable module cache (inverse: --incremental)
	--incremental
	--cache-dir: path # Store module cache info in the given folder in incremental mode (defaults to '.mypy_cache')
	--sqlite-cache # Use a sqlite database to store the cache (inverse: --no-sqlite-cache)
	--no-sqlite-cache
	--cache-fine-grained # Include fine-grained dependency information in the cache for the mypy daemon
	--skip-version-check # Allow using cache written by older mypy version
	--skip-cache-mtime-checks # Skip cache internal consistency checks based on mtime
	--pdb # Invoke pdb on fatal error
	--show-traceback # Show traceback on fatal error
	--tb # Show traceback on fatal error
	--raise-exceptions # Raise exception on fatal error
	--custom-typing-module: string # Use a custom typing module
	--enable-recursive-aliases # Experimental support for recursive type aliases
	--custom-typeshed-dir: path # Use the custom typeshed in DIR
	--warn-incomplete-stub # Warn if missing type annotation in typeshed, only relevant with --disallow-untyped-defs or --disallow-incomplete-defs enabled (inverse: --no-warn-incomplete-stub)
	--no-warn-incomplete-stub
	--shadow-file: string # When encountering SOURCE_FILE, read and type check the contents of SHADOW_FILE instead.  # TODO: accepts 2 paths
	--any-exprs-report: path
	--cobertura-xml-report: path
	--html-report: path
	--linecount-report: path
	--linecoverage-report: path
	--lineprecision-report: path
	--txt-report: path
	--xml-report: path
	--xslt-html-report: path
	--xslt-txt-report: path
	--junit-xml: path # Write junit.xml to the given file
	--find-occurrences: string # Print out all usages of a class member (experimental)
	--scripts-are-modules # Script x becomes module x instead of __main__
	--install-types # Install detected missing library stub packages using pip (inverse: --no-install-types)
	--no-install-types
	--non-interactive # Install stubs without asking for confirmation and hide errors, with --install-types (inverse: --interactive)
	--interactive
	--explicit-package-bases # Use current directory and MYPYPATH to determine module names of files passed (inverse: --no-explicit-package-bases)
	--no-explicit-package-bases
	--exclude: string # Regular expression to match file names, directory names or paths which mypy should ignore while recursively discovering files to check, e.g. --exclude '/setup\.py$'. May be specified more than once, eg. --exclude a --exclude b
	--module(-m): string # Type-check module; can repeat for more modules
	--package(-p): string # Type-check package recursively; can be repeated
	--command(-c): string # Type-check program passed in as string
]
