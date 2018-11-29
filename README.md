# spring-boot-hello-world
Ce projet d'application Spring Boot Web Hello World vous permet de tester la livraison continue � l'aide de l'outil Robot Framework.

Diff�rents outils seront mis � contribution tel que :
* [Ansible](https://www.ansible.com/) 
* [Jenkins](https://jenkins.io/)
* [Docker](https://www.docker.com/)
* [Maven](https://maven.apache.org/)
* [Robot Framework](http://robotframework.org/)
* [Projet jenkins-pipeline-library](https://github.com/gologic-nico/jenkins-pipeline-library.git)

## Requis
* VM CentOs 7 avec la base d'environnement "Infrastructure Server"
* Acc�s root

## �tape � suivre

### Connectez vous en ssh avec le user root
`ssh root@IpAddress`

### Ajouter le repo du package de Ansible

`yum install epel-release`

### Installer le package Ansible

`yum install ansible`

### Installer le package Git : 

`yum install git`

### Cloner le d�pot du projet jenkins-pipeline-library pour mettre en place l'environnement de livraison continue

`git clone https://github.com/gologic-nico/jenkins-pipeline-library.git /tmp/jenkins-pipeline-library`

### Acc�der le r�pertoire du playbook Ansible 

`cd /tmp/jenkins-pipeline-library/ansible`

### Lancer le playbook Ansible de Jenkins 

`ansible-playbook -i hosts install_jenkins.yml`
