export-env {
	let-env ENV_CONVERSIONS = (
		$env | get -i ENV_CONVERSIONS | default {}
		| upsert PYTHONPATH {||
			from_string: {|s| $s | split row ':'}
			to_string: {|v| $v | str join ':'}
		}
	)
	let-env PYLINTHOME = $'($env.HOME)/.pylint.d'  # this should be the default, but it somehow keeps breaking and resetting to HOME/.config/pylint
}
