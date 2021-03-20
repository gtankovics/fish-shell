function yesno -d "ask a question with yes or no answer. If yes continue else exit."

	set -l question $argv[1]

	while true
		read -l -P "$question [y/N] " confirm
		switch $confirm
		case Y y
			return 0
		case \*
			return 1
		end
	end
end

# Usage
#
# if yesno "Do you want to continue?"
#     // do stuff
# else
#    // break
# end