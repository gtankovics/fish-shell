function terraform --description "Check local terraform.sh or run the general one"
	set_color -b brred -i brwhite
	if test -f "./terraform.sh"
		# echo "Local 'terraform.sh' found"
		if test -x "./terraform.sh"
			# echo "'terraform.sh' is executeable. Run it !"
			echo " Running terraform from local 'terraform.sh' "
			set_color normal
			./terraform.sh $argv
		else
			echo " Running terraform from local 'terraform.sh' is not possible because it's not executeable. "
		end
	else
		if find . -name "*.tf" -d 1 -type f > /dev/null
			set -l terraform_path (which terraform)
			echo " There's no 'terraform.sh' found. But found '*.tf' files. Run terraform from $terraform_path "
			set_color normal
			$terraform_path $argv
		else
			echo " This folder is not related to 'terraform'. "
		end
	end
	set_color normal
end