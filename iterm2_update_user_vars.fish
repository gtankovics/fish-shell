function iterm2_update_user_vars --description "This function updates user variables for iterm2"

	iterm2_set_user_var GOOGLE_CONFIG (gcloud config configurations list --filter 'is_active=true' --format 'value(name)')
	iterm2_set_user_var GOOGLE_PROJECT (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.core.project)')
	iterm2_set_user_var GOOGLE_REGION (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.compute.region)')
	iterm2_set_user_var GOOGLE_ZONE (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.compute.zone)')
	iterm2_set_user_var K8S_CLUSTER (kubectl config current-context)
	iterm2_set_user_var K8S_CLUSTER_SHORT (kubectl config current-context | cut -d "_" -f 4)
	iterm2_set_user_var K8S_CLUSTER_VERSION (kubectl version --short | awk "/Server/{print\$3}")
	iterm2_set_user_var NVM_CURRENT_VERSION $NVM_CURRENT_VERSION

end