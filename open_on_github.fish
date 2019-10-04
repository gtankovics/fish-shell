function open_on_github --description "Open repo on GitHub if remote available"

	if test -e ./.git

		set -l remote (git remote -v | grep fetch | awk '{print $2}' | sed 's/git@/https:\/\//' | sed 's/com:/com\//')

		if string length -q $remote 
			set -l branch (git branch -a | awk '/\*/{print$2}')
			set -l remote_url (string join "/" "$remote" "tree" "$branch")
			echo $remote_url
			open $remote_url
		else
			echo "There is no remote."
		end
	else

		echo "This is not a git repo."
	end

end