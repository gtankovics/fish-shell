function iterm2_update_user_vars --description "This function updates user variables for iterm2"

	iterm2_set_user_var GOOGLE_CONFIG $GOOGLE_CONFIG
	# (gcloud config configurations list --filter 'is_active=true' --format 'value(name)')
	iterm2_set_user_var GOOGLE_PROJECT $GOOGLE_PROJECT
	# (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.core.project)')
	iterm2_set_user_var GOOGLE_REGION $GOOGLE_REGION
	# (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.compute.region)')
	iterm2_set_user_var GOOGLE_ZONE $GOOGLE_ZONE
	# (gcloud config configurations list --filter 'is_active=true' --format 'value(properties.compute.zone)')
	
	iterm2_set_user_var ACTIVE_DOMAIN_SUFFIX $ACTIVE_DOMAIN_SUFFIX
	iterm2_set_user_var K8S_CLUSTER_SHORT $K8S_CLUSTER_SHORT
	iterm2_set_user_var K8S_CLUSTER_VERSION $K8S_CLUSTER_VERSION

	iterm2_set_user_var NVM_CURRENT_VERSION $NVM_CURRENT_VERSION

end