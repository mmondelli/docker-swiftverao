# docker-swiftverao
===========

This repo contains:
- A dockerfile with installation and configuration of programs needed to execute the swift-phylo and pagerank workflows, both developed using Swift (https://www.swift-lang.org/)
- Input files for both workflows

Requirements
===========

Docker: https://www.docker.com/

Steps to use this container
===========
$ sudo docker build -t swift-verao .
$ sudo docker run swift-verao -i /bin/bash
$ cd home
$ source env_verao

For more commands, please refer to the Docker documentation.
