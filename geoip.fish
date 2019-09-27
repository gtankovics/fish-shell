function geoip --description "IP details from ipstack.com"

	if test $argv
		if string match --regex --quiet '\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\b' $argv 
			if test -n "$ipstack_api_key"
				curl -s "http://api.ipstack.com/$argv?access_key=$ipstack_api_key" | jq 
			else
				echo "ipstack API key is not set. [ipstack_api_key=$ipstack_api_key]"
			end
		else
			echo 'Invalid IP format.'
		end
	else
		echo 'Add an IP address.'
	end 

end