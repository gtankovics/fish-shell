#!/usr/bin/env fish

set -l fishFunctionsDir "$__fish_config_dir/functions"
set -l fishBin ~/bin/fish

if not test -d $fishBin
	mkdir ~/bin/fish
end

cp *.fish $fishBin

for file in (ls *.fish)
	if not test -L "$fishFunctionsDir/$file"
		ln -s $fishBin/$file $fishFunctionsDir/$file
	else
		rm $fishFunctionsDir/$file
		ln -s $fishBin/$file $fishFunctionsDir/$file
	end
end