def "docker compose ps" [] nothing -> list {
	^docker compose ps | lines | skip 1 | parse --regex '(\S+)\s+(\S+)\s+"(\S+)"\s+(\S+)\s+(\d+\s\w+\s\w+)\s+(\w+\s\d+\s\w+)\s+(.*)' | rename Name Image Command Service Created Status Ports | upsert Created {|| ($in | into datetime)}
}
alias "dc ps" = docker compose ps
