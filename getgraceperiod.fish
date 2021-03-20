function getgraceperiod --description "it counts graceperiod start/end from certain date and print in EPOCH format."

	if test -n "$argv"
		set -l gracePeriodDate (string join ' ' $argv)
		if date -j -f '%F %T' "$gracePeriodDate" > /dev/null
			set gracePeriodStart (date -v-2w -j -n -u -f '%F %T' $gracePeriodDate +%s)
			set gracePeriodEnd (date -j -n -u -f '%F %T' $gracePeriodDate +%s)
			echo -ne "gracePeriodStart:\t$gracePeriodStart\ngracePeriodEnd:\t\t$gracePeriodEnd\n"
		else
			echo "Date format is invalid. [YYYY-mm-dd HH:MM:SS]"
		end
	else
		echo "Please add date. Exp. 2020-12-28 00:00:00"
	end

end