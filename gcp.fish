function gcp --description "Open GKE page on GCP web interface"

	if test -n "$GOOGLE_PROJECT"

		if test -n "$argv"
			getopts $argv | while read -l key value
				switch $key
					case d details
						open https://console.cloud.google.com/kubernetes/clusters/details/$GOOGLE_ZONE/$K8S_CLUSTER_SHORT\?project=bc-saas-test-be\&tab=details
					case n nodes
						open https://console.cloud.google.com/kubernetes/clusters/details/$GOOGLE_ZONE/$K8S_CLUSTER_SHORT\?project=$GOOGLE_PROJECT\&tab=nodes
					case w workload
						open https://console.cloud.google.com/kubernetes/workload\?project=$GOOGLE_PROJECT
					case s service
						open https://console.cloud.google.com/kubernetes/discovery\?project=$GOOGLE_PROJECT
					case i ingress
						open https://console.cloud.google.com/kubernetes/ingresses\?project=$GOOGLE_PROJECT
					case c config configurations
						open https://console.cloud.google.com/kubernetes/config\?project=$GOOGLE_PROJECT
					case p storage
						open https://console.cloud.google.com/kubernetes/storage\?project=$GOOGLE_PROJECT
					case a application
						open https://console.cloud.google.com/kubernetes/application\?project=$GOOGLE_PROJECT
					case \*
						printf "ERROR: unknown option. [%s]" $value
				end
		end
		else
			open https://console.cloud.google.com/kubernetes\?project=$GOOGLE_PROJECT
		end

	else
		echo "GOOGLE_PROJECT env is not set."
	end

end