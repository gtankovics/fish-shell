function cleandocker --description 'Clean local Docker registry'
	set -l running_containers (docker ps -a | awk '/Up/{print$1}') 
	if test "$running_containers"
		echo 'Stop running containers'
		docker stop (docker ps -a | awk '/[a-z0-9]{12}/{print$1}') 
	else 
		echo 'No running containers.'
	end
	set -l containers (docker ps -a | awk '/[a-z0-9]{12}/{print$1}')
	if test "$containers"
		echo 'Delete containers'
		docker rm (docker ps -a | awk '/[a-z0-9]{12}/{print$1}')
	else  
		echo 'No containers.'
	end
	set -l container_images (docker images | awk '/[a-z0-9]{12}/{print$3}')
	if test "$container_images"
		echo 'Delete container images'
		docker rmi (docker images | awk '/[a-z0-9]{12}/{print$3}') --force
	else
		echo "No container images."
	end
end