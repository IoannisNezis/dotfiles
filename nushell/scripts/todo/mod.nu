export def load [
    --todos (-t) # load only the todo items
] nothing -> table {
    let data = open $env.TODO.CONFIG.todo-file-path 
    let todos = $data | get todos | upsert created {|| $in | into datetime} | upsert closed {|x| $x.closed | into datetime }
    $data | upsert todos {$todos}
}

def store [] table -> nothing {
    save -f $env.TODO.CONFIG.todo-file-path
}

export def is_closed [todo: record] nothing -> bool {
    (load | get todos | filter {|elem| $elem == $todo } | length) >= 1
}

export def is_open [todo: string] nothing -> bool {
    (load | get open | filter {|elem| $elem == $todo } | length) >= 1
}

export def "list open" [] nothing -> table {
    load | get todos | filter {|todo| $todo.closed == null}  | reject closed
}

export def "list closed" [] nothing -> table {
    load | get todos | filter {|todo| $todo.closed != null}
}

# Add a ToDo to the 'open' list
export def add [task: string] {
    let data = load
    let next_id = $data | get next_todo_id
    let todo = {id: $next_id, task: $task, created: (date now), closed: null}
    {next_todo_id: ($next_id + 1), todos: ($data | get todos | append $todo )} | store

    list open
}


# Move a ToDo from 'open' to 'closed'
export def close [
    todo?: string # Task of the ToDo
    --identifier (-i): int # ID of the ToDo to close 
] {
    if $identifier != null {
	let data = load
	let updated_todo = $data | get todos | where id == $identifier | upsert closed (date now)

	$data | upsert todos  ($updated_todo | append ($data | get todos | filter {|| $in.id != $identifier})) | store
    }
    if ($todo != null) {
	if not (is_open $todo) {
	    print $"The ToDo \"($todo)\" is not open"
	    return 
	}
 sf	load | upsert open {|todos| ($todos.open | filter {|item| $item != $todo})} | store
	load | upsert closed {|| $in | append $todo} | store	
    }
    list open
}


export def main [] {
    list open
}


# Very strange behaviour the env vars CURRENT_FILE are only avalible
# if i define export-env ...
# also this gets called when 'use' is called, i will use it as a setup funktion
export-env {
    let todo_file = $env | get CURRENT_FILE | path join 'todos.yaml'
    $env.TODO.CONFIG = {
	todo-file-path: $todo_file
    }

    if not ($todo_file | path exists) {
	{next_todo_id: 0, todos: []} | save $todo_file
    }
}
