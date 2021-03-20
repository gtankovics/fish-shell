#!/usr/bin/env fish

set -l fishFunctionsDir "$__fish_config_dir/functions"
set -l fishBin ~/bin/fish

if not test -d $fishBin
	mkdir ~/bin/fish
end

for file in (ls *.fish)
	if not test -L "$fishFunctionsDir/$file"
		cp $file $fishBin/$file
		ln -s $fishBin/$file $fishFunctionsDir/$file
		echo "$file copied and linked."
	else
		if not diff -y -q $file $fishFunctionsDir/$file
			if yesno "Show the differencies?"
				diff $file $fishFunctionsDir/$file
			end
			if yesno "Do you want to create $file?"
				cp $file $fishBin/$file
				rm $fishFunctionsDir/$file
				ln -s $fishBin/$file $fishFunctionsDir/$file
				echo "$file replaced and relinked."
			else
				echo "$file skipped."
			end
		end
	end
end