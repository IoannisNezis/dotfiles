use utils.nu *
 
export def load [] {
   db_file namespaces | open | upsert created { $in | into datetime}
}

# creates a new Namespace nested in the currently active namespace
export def --env new [
    namespace: string
    --activate (-a) # Activates the new namespace
    ] {
    let id = (inc_id namespaces);
    [{id: $id,
      name: $namespace,
      parent: (active).id,
      created: (date now)}]
      | to yaml
      | save --append (db_file namespaces);
    if $activate {
	activate $id
    }
    map 0
} 

# returns the currently active namespace
export def active [] {
    load | where id == (active id) | first
}

export def "active id" [] {
    $env.todo.namespace | into int
}

export def "active scope" [] {
    load | filter {|namespace| (is_decendant $namespace.id (active id))} | append (active) | sort-by id
}

export def parent [] {
    if (active).parent != null {
	load | where id == (active).parent | first
    } else {
	return {}
    }
}

def exists [namespace_id: int] int -> bool {
    (load | where id == $namespace_id | length) != 0
}

# set the active namespace
export def --env activate [namespace_id: int] {
    if not (exists $namespace_id) {
	print $"there is no namespace: ($namespace_id)"
	return
    }

    $env.todo.namespace = $namespace_id
    $namespace_id | save --force $env.todo.namespace_file
    print {active: (active).name, parent: (parent | get name?)};
}

export def is_decendant [
    namespace_id: int
    ancestor: int
] {
    if $namespace_id == 0 {
	return false
    }
    let entrys = load | where id == $namespace_id
    if ($entrys | length) > 0 {
	let parent = ($entrys | (first).parent)
	if $parent == $ancestor {
	    return true
	}
	return (is_decendant $parent $ancestor)
    }
} 

export def childs [id: int] {
    load | where parent == $id
}

def fill_parent [] {
    upsert parent {|ns| (load | join -l (load) parent id | where id == $ns.id | get 0.name_?)}
}

export def list [
    --all (-a) # list all namespaces
] {
    if $all {
	load | fill_parent
    } else {
	active scope | fill_parent 
    }
}

export def map [id: int] {
    let child_maps = (childs $id | select id name | each {|namespace| (map $namespace.id)}) 
    let name =  $"[($id)]" + (load | where id == $id | (first).name)
    if ($child_maps | length) > 0 {
	return {$name: ($child_maps | reduce {|x,y| {...$x ...$y}})}
    }
    return {$name: null}
}

export def main [
    --all (-a) # display all namspaces not just the active scope
] {
    if $all {
	map 0
    } else {
	map (active id)
    }
}
