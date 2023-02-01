# lint files with flake8 for pep8 compatability
export def 'parsed flake8' [
	...paths: path
] {
	^flake8 $paths
	| lines
	| parse '{file}:{line}:{column}: {id} {description}'
	| upsert line {|i| $i.line | into int}
	| upsert column {|i| $i.column | into int}
}

export extern 'flake8' [
	...file: path
	--version # show program's version number and exit
	--help(-h)
	--verbose(-v) # Print more information about what is happening in flake8. This option is repeatable and will increase verbosity each time it is repeated.
	--quiet(-q) # Report only file names, or nothing. This option is repeatable.
	--count # Print total number of errors and warnings to standard error and set the exit code to 1 if total is not empty.
	--diff # Report changes only within line number ranges in the unified diff provided on standard in by the user.
	--exclude: string # Comma-separated list of files or directories to exclude.
	--filename: string # Only check for filenames matching the patterns in this comma-separated list.
	--stdin-display-name: string # The name used when reporting errors from code passed via stdin. This is useful for editors piping the file contents to flake8.
	--format: string # Format errors according to the chosen formatter.
	--hang-closing # Hang closing bracket instead of matching indentation of opening bracket's line.
	--ignore: string # Comma-separated list of errors and warnings to ignore (or skip). For example, `--ignore=E4,E51,W234`.
	--extend-ignore: string # Comma-separated list of errors and warnings to add to the list of ignored ones. For example, `--extend-ignore=E4,E51,W234`.
	--per-file-ignores: string # A pairing of filenames and violation codes that defines which violations to ignore in a particular file. The filenames can be specified in a manner similar to the `--exclude` option and the violations work similarly to the `--ignore` and `--select` options.
	--max-line-length: int # Maximum allowed line length for the entirety of this run.
	--max-doc-length: int # Maximum allowed doc line length for the entirety of this run.
	--select: string # Comma-separated list of errors and warnings to enable. For example, `--select=E4,E51,W234`.
	--disable-noqa # Disable the effect of "# noqa". This will report errors on lines with "# noqa" at the end.
	--show-source # Show the source generate each error or warning.
	--statistics # Count errors and warnings.
	--enable-extensions: string # Enable plugins and extensions that are otherwise disabled by default
	--exit-zero # Exit with status code "0" even if there are errors.
	--install-hook: string # Install a hook that is run prior to a commit for the supported version control system.
	--jobs(-j): int # Number of subprocesses to use to run checks in parallel. This is ignored on Windows. The default, "auto", will auto-detect the number of processors available to use.
	--output-file: path # Redirect report to a file.
	--tee # Write to stdout and output-file.
	--append-config: path # Provide extra config files to parse in addition to the files found by Flake8 by default. These files are the last ones read and so they take the highest precedence when multiple files provide the same option.
	--config: path # Path to the config file that will be the authoritative config source. This will cause Flake8 to ignore all other configuration files.
	--isolated # Ignore all configuration files.
	--benchmark # Print benchmark information about this run of Flake8
	--bug-report # Print information necessary when preparing a bug report
	--max-complexity: string # McCabe complexity threshold
	--builtins: string # define more built-ins, comma separated
	--doctests # check syntax of the doctests
	--include-in-doctest: string # Run doctests only on these files
	--exclude-from-doctest: string # Skip these files when running doctests
]
