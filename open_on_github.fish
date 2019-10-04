function open_on_github --description "Open repo on GitHub if remote available"

	set -l remote (git remote -v | grep fetch | awk '{print $2}' | sed 's/git@/https:\/\//' | sed 's/com:/com\//')
	set -l branch (git branch -a | awk '/\*/{print$2}')

	if string length -q $remote 
		set -l remote_url (string join "/" "$remote" "tree" "$branch")
		echo $remote_url
		open $remote_url
	else
		echo "There is no remote."
	end

end