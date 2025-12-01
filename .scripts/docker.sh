#!/bin/bash

# clean all docker images
function clean_images() {
    docker rmi $(docker images -q)
}

# clean all docker containers
function clean_containers() {
    docker rm $(docker ps -a -q)
}