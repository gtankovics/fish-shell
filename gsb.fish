function gsb --description "Open Storage part of GCP"

	if test -n "$GOOGLE_PROJECT"

		if test -n "$argv"
			getopts $argv | while read -l key value
				switch $key
					case ds
						# in this case add the -ds suffix to the GOOGLE_PROJECT 
						open https://console.cloud.google.com/storage/browser\?project=$GOOGLE_PROJECT-ds
					case \*
						printf "ERROR: unknown option. [%s]" $key
				end
		end
		else
			open https://console.cloud.google.com/storage/browser\?project=$GOOGLE_PROJECT
		end

	else
		echo "GOOGLE_PROJECT env is not set."
	end

end