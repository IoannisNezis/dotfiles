# A custom git command to create a histogram of all contributers and the amount of commits
def "git contributer" [] nothing -> table {
	git log --pretty=%h»¦«%aN»¦«%s»¦«%aD | lines | split column "»¦«" sha1 committer desc merged_at | histogram committer merger
}


# A custom git commant to show all changes in unstaged files
def "git review" [] nothing -> nothing {
	git diff --name-only | fzf -m --ansi --preview "git rev-parse --show-toplevel | to text | str trim | path join {} | git diff --color=always -- $in"
}
