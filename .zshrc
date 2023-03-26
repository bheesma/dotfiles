

# Create fresh devops container
refresh_devops_container() {

    echo 'Refreshing devops container...'
    docker kill devops > /dev/null 2>&1 || true && docker rm  devops > /dev/null 2>&1 || true
    docker run -d -v "$HOME"/.aws:/root/.aws -v `PWD`:/app  --name devops devops:latest >/dev/null

}

#------------------------------------------------

check_devops_container() {

    # Vars
    container_name="devops"
    container_id=$(docker ps -aqf "name=$container_name")
    mapped_wd="false"
    container_status="DOESNTEXIST"

    # Get the status of docker container
    if docker ps --format '{{.Names}}' | grep -q $container_name; then
        container_status="RUNNING"
    else
        if docker ps -a --filter "name=$container_name" --filter "status=exited" | grep -q $container_name; then
            container_status="STOPPED"
        fi
    fi

    # Check if current working director is mapped to docker
    if [[ $container_status != "DOESNTEXIST" ]]; then
        if [ "$(docker inspect $container_name | grep ""$(pwd):"")" ]; then
            mapped_wd="true"
        fi
    fi

    # Start or refresh
    if [[ $container_status == "DOESNTEXIST" ]]; then
        refresh_devops_container
    elif [[ $mapped_wd == "true" &&  $container_status == "STOPPED" ]]; then
        docker start devops >/dev/null
    elif [[ $mapped_wd == "false" &&  $container_status == "RUNNING" ]]; then
        refresh_devops_container
    fi

    # Execute the commands in docker
    cmd="docker exec -it devops $@"
    eval $cmd

}

#------------------------------------------------

aws() { check_devops_container "$0 $*" }
terraform() { check_devops_container "$0 $*" }
cdk() { check_devops_container "$0 $*" }
ansible() { check_devops_container "$0 $*" }
node() { check_devops_container "$0 $*" }
npm() { check_devops_container "$0 $*" }
cdktf() { check_devops_container "$0 $*" }

#------------------------------------------------
