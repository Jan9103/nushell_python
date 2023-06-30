export-env {
	load-env {
		ENV_CONVERSIONS: (
			$env | get -i ENV_CONVERSIONS | default {}
			| upsert PYTHONPATH {
				from_string: {|s| $s | split row ':'}
				to_string: {|v| $v | str join ':'}
			}
		)

		# this should be the default, but it somehow keeps
		# breaking and resetting to HOME/.config/pylint
		PYLINTHOME: $'($env.HOME)/.pylint.d'
	}
}
