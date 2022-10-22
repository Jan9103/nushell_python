# lint files with pylint
export def pylint [
	--rcfile: path
	--errors-only(-E)
	...paths: path
] {
	let options = ([
		(if $rcfile != null {$'--rcfile ($rcfile)'})
		(if $errors_only {'--errors-only'})
	] | compact)
	^pylint $options $paths
	| lines
	| parse '{file}:{line}:{column}: {id}: {description}'
	| upsert line {|i| $i.line | into int}
	| upsert column {|i| $i.column | into int}
}

# lint files with flake8 for pep8 compatability
export def flake8 [
	...paths: path
] {
	^flake8 $paths
	| lines
	| parse '{file}:{line}:{column}: {id} {description}'
	| upsert line {|i| $i.line | into int}
	| upsert column {|i| $i.column | into int}
}

# lint files with mypy
export def mypy [
	--config-file: path
	...paths: path
] {
	^mypy ([
		(if $config_file {$'--config-file ($config_file)'})
	] | compact) --show-error-codes $paths
	| lines
	| parse '{file}:{line}: {type}: {description}  [{error_code}]'
	| upsert line {|i| $i.line | into int}
}
