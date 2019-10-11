function open_on_gcp --description "Open k8s cluster page on GCP web interface"

	if test -n "$GOOGLE_PROJECT"
		open https://console.cloud.google.com/kubernetes\?project=$GOOGLE_PROJECT
	else
		echo "GOOGLE_PROJECT env is not set."
	end

end