# $env.PYTHON_VENVS:
# <list>:
#  <record>:
#   dir: path # venv directory
#   old_PATH  # <-> $env.PATH
#   old_PYTHONHOME  # <-> $env.PYTHONHOME
#   old_PYTHONPATH: <list<str>> # <-> $env.PYTHONPATH


# deactivate the newest venv
export def-env deactivate [] {
	# TODO: use return or something instead of default if nu ever adds it..

	let venv = ( # the venv you want to deactivate
		$env | get -i PYTHON_VENVS | default []
		| reverse | get -i 0 | default {}
	)

	let-env PYTHON_VENVS = ( # remove it from the list
		$env | get -i PYTHON_VENVS | default []
		| drop 1
	)

	# reset env vars
	let-env PATH = ($venv | get -i old_PATH | default $env.PATH)
	let-env PYTHONHOME = ($venv | get -i old_PYTHONHOME | default ($env | get -i PYTHONHOME))
}

# list the active venvs
export def list [] {
	$env | get -i PYTHON_VENVS.dir | default []
}

# register a venv
export def-env activate [
	dir: path = ''  # the venv directory (contains bin/ and pyvenv.cfg) (default: autodetect)
] {
	let dir = (
		if $dir == '' {
			(ls */pyvenv.cfg).0.name | path dirname
		} else {$dir}
	)
	let dir = ($dir | path expand)
	let-env PYTHON_VENVS = (
		$env | get -i PYTHON_VENVS | default []
		| append {
			dir: $dir
			old_PATH: $env.PATH
			old_PYTHONHOME: ($env | get -i PYTHONHOME)
			old_PYTHONPATH: ($env | get -i PYTHONPATH)
		}
	)
	let-env PATH = (
		$env.PATH
		| prepend $'($dir)/bin'
	)
	let-env VIRTUAL_ENV = $dir  # for other scripts, etc
	let-env PYTHONHOME = null
	let-env PYTHONPATH = ([
		(if ($'($env.PWD)/tests' | path exists) { $'($env.PWD)/tests' }),
		(if ($'($env.PWD)/src' | path exists) { $'($env.PWD)/src' }),
	] | flatten | compact)
}
