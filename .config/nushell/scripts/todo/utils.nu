export def db_file [table: string] {
    $env.todo.tables | where name == $table | get 0.file
}

export def --env inc_id [table: string] {
    let id = $env.todo.tables | where name == $table | get 0.next_id
    $env.todo.tables = ($env.todo.tables | upsert next_id {|row|(if $row.name == $table {$id + 1} else {$row.next_id})})
    return $id
}

export def store [table: string] table -> nothing {
    to yaml | save -f (db_file $table)
}

