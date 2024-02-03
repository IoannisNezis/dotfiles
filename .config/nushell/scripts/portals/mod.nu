export def load [table: string] {
	$env.portals.tables | get $table | open
}

export def --env main [target?: string] {
	if $target == null {
		return (load portals)
	}
	let matches = load portals | where name =~ $target
	if ( $matches | length ) == 0 {
		print "no portal with this name was found :("
		return (load portals)
	}
	let target_path = $matches | first | get path
	cd $target_path
}

export-env {
	$env.portals.tables = {portals: ($env.CURRENT_FILE | path join portals.yaml)}
}
