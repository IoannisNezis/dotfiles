def dcps [] {
	docker compose ps | lines | skip 1 | parse --regex '(\S+)\s+(\S+)\s+"(\S+)"\s+(\S+)\s+(\d+\s\w+\s\w+)\s+(\w+\s\d+\s\w+)\s+(.*)' | rename Name Image Command Service Created Status Ports 
}

def git-contributer [] {
	git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged_at | histogram committer merger | sort-by merger | reverse
}
