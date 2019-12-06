function gcp --description "Open GCP apropriate part in default browser."

	set -l CONSOLE_URL "https://console.cloud.google.com"

	if test -n "$GOOGLE_PROJECT"

		if test -n "$argv"
			getopts $argv | while read -l key value
				switch $key
					case pubsub
						open $CONSOLE_URL/cloudpubsub\?project=$GOOGLE_PROJECT
					case \*
						printf "ERROR: unknown option. [%s]" $key
				end
		end
		else
			open $CONSOLE_URL\?project=$GOOGLE_PROJECT
		end

	else
		echo "GOOGLE_PROJECT env is not set."
	end


end