# install
# download
# uninstall
# freeze
# list
# show
# check
# config
# search
# wheel
# hash
# completion
# debug
# help

# update all installed packages
export def 'pip updateall' [] {
	python3 -m pip --disable-pip-version-check list --outdated --format=json
	| from json | get name
	| each {|i|
		python3 -m pip install -U $i
	}
}
