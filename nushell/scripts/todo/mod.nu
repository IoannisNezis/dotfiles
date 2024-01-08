use utils.nu * 
export use namespaces.nu *
# Very strange behaviour the env vars CURRENT_FILE are only avalible
# if i define export-env ...
# also this gets called when 'use' is called, i will use it as a setup funktion
export-env {
    let tables_file = $env | get CURRENT_FILE | path join 'tables.yaml'
    let tables = [todos namespaces]
    $env.todo.tables = ($tables | each {|table| {name: $table, file: ($env.CURRENT_FILE | path join $'($table).yaml'), next_id:0}})
   
   for table in $tables {
	let file = $env.todo.tables | where name == $table | get 0.file
	if not ($file | path exists) {
	   "" | save $file
	}
	if ($file | open | length) > 0 {
	    let max_id  = $file | open | select id? | sort | reverse | get 0?.id
	    if $max_id != null {
		$env.todo.tables = ($env.todo.tables | upsert next_id {|row| (if $row.name == $table {$max_id + 1} else { $row.next_id })})
	    }
	}
	
    }
    if (db_file namespaces | open | length) == 0 or (db_file namespaces | open | where name == root | length) == 0 {
	[{id: 0, name: root, parent: null, created: (date now)}] | save --append (db_file namespaces)
    }
    $env.todo.namespace_file = ($env | get CURRENT_FILE | path join namespace)
    if not ($env.todo.namespace_file | path exists) {
	0 | save $env.todo.namespace_file
    }
    $env.todo.namespace =  ($env.todo.namespace_file | open)
}

def load [] nothing -> table {
    let data = ((db_file todos) | open)
    $data | upsert created {|| $in | into datetime } | upsert closed {|| if $in != null {$in | into datetime }}
}

export def fill_namespace [] {
    upsert namespace {|todo| (open (db_file namespaces)) | where id == $todo.namespace | (first).name}
}

export def get_by_id [id: int] { 
    load | where id == $id | get 0?
}
# returns true if the ToDo is whithin the active namespace otherwise false
export def is_active [id: int] int -> bool {
    let todo = (get_by_id $id)
    let active_namespace = (active)
    $todo.namespace == $active_namespace.id or (is_decendant $todo.namespace (active).id)
}

export def in_scope [ns_id: int, ids: table<id: int>] {
    ($ids | where id == $ns_id | length) == 1
}

export def list [
    --all (-a) # list closed and open
    --closed (-c) # list closed ToDo's
    --global (-g)
] {
    let scope = (active scope | select id)
    load
    | filter {|todo| ($all or ((not $closed) and $todo.closed == null) or ($closed and $todo.closed != null)) }
    | filter {|todo| $global or (in_scope $todo.namespace $scope)}
    | fill_namespace
   
 #   if $closed {
	# load | filter {|todo| $todo.closed != null}
 #    }

   # $res |  filter {|todo| $todo.closed == null}  | reject closed
}

# Add a ToDo to the 'open' list
export def --env new [task: string] {
    let next_id = inc_id todos
    let todo = {id: $next_id, task: $task, namespace: (active).id, created: (date now), closed: null}
    [$todo] | save --append (db_file todos)
    list
}

# Move a ToDo from 'open' to 'closed'
export def close [
    todo_id: int # ID Task of the ToDo to close
] {
    load | upsert closed {|todo| if $todo.id == $todo_id { date now } else {$todo.closed}} | store todos
    list
}


export def main [
    --all (-a) # list all task
    --closed (-c) # list all closed tasks
] {
    print {active: (active).name, parent: (parent | get name?)}
    if $all {
	load | table -e
    } else if $closed {
	list --closed
    } else {
	list
    }
}
