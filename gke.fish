function gke --description "Open GKE page on GCP web interface"

	function show_gke_help --description "Show gke help"

		printf "Usage:
gke [OPTIONS]

Set ENVIRONMENT variables:
- GOOGLE_PROJECT - point to the Google Cloud Platform (GCP) Project
- GOOGLE_ZONE - set to one of GCP zone
- K8S_CLUSTER_SHORT - point to the running cluster

Available options:
-h or --help		- Show this help.
-n or --nodes		- Show the cluster nodes
-w or --workload	- Show the cluster workload
-s or --service		- Show the cluster services
-i or --ingress		- Show the cluster ingresses
-c or --config		- Show the cluster configMaps, Secrets
-p or --storage		- Show the cluster peristentVolumeClaims or storage-classes
-a or --application	- Show the cluster Applications\n"

	end

	if test -n "$GOOGLE_PROJECT"

		if test -n "$K8S_CLUSTER_SHORT" && test "$K8S_CLUSTER_SHORT" != "n/a" 

			if test -n "$argv"
				getopts $argv | while read -l key value
					switch $key
						case d details
							open https://console.cloud.google.com/kubernetes/clusters/details/$GOOGLE_ZONE/$K8S_CLUSTER_SHORT\?project=$GOOGLE_PROJECT\&tab=details
						case n nodes
							open https://console.cloud.google.com/kubernetes/clusters/details/$GOOGLE_ZONE/$K8S_CLUSTER_SHORT\?project=$GOOGLE_PROJECT\&tab=nodes
						case w workloads
							open https://console.cloud.google.com/kubernetes/workload\?project=$GOOGLE_PROJECT
						case s services
							open https://console.cloud.google.com/kubernetes/discovery\?project=$GOOGLE_PROJECT
						case i ingresses
							open https://console.cloud.google.com/kubernetes/ingresses\?project=$GOOGLE_PROJECT
						case c config configurations
							open https://console.cloud.google.com/kubernetes/config\?project=$GOOGLE_PROJECT
						case p storages
							open https://console.cloud.google.com/kubernetes/storage\?project=$GOOGLE_PROJECT
						case a applications
							open https://console.cloud.google.com/kubernetes/application\?project=$GOOGLE_PROJECT
						case h help
							show_gke_help
						case \*
							printf "ERROR: unknown option. [%s]\n" $key
							show_gke_help
					end
				end
			else
				open https://console.cloud.google.com/kubernetes\?project=$GOOGLE_PROJECT
			end
		else
			echo "ERROR: K8S_CLUSTER_SHORT [$K8S_CLUSTER_SHORT] is not set or $GOOGLE_PROJECT does not have running cluster in $GOOGLE_ZONE"
		end
	else
		echo "ERROR: GOOGLE_PROJECT [$GOOGLE_PROJECT] env is not set."
	end

end