export def load [table: string] {
	$env.monitors.tables | get $table | open
}

export def read [] {
	 let regex = 'Monitor (\S+) \(ID (\d+)\):\n\s(\d+x\d+@\d+.\d+) at (\d+x\d+)\n\sdescription: (.+)\n\smake: (.+)\n\smodel: (.+)\n\sserial:(.*)\n\sactive workspace: (\d+) \((.*)\)\n\sspecial workspace: (\d+) \((.*)\)\n\sreserved: ([\d ]+)\n\sscale: (\d+.\d+)\n\stransform: (\d+)\n\sfocused: (yes|no)\n\sdpmsStatus: (\d+)\n\svrr: (\d+)\n\sactivelyTearing: (false|true)'
	 let monitor_strs = (hyprctl monitors | split row "\n\n")
	 $monitor_strs | each {|x| $x | parse --regex $regex } | flatten | rename port ID resolution location description make model serial activeWorkspace specialWorkspace reserved scale transform focused dpmsStatus vrr activelyTearing | insert hash {|mon| $mon.make + $mon.model | hash sha256}
}
export def --env main [target?: string] {
	read
}

export-env {
	$env.monitors.tables = {monitors: ($env.CURRENT_FILE | path join monitors.yaml)}
}
