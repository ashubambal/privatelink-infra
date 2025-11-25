#!/bin/bash

# Update packages
sudo yum update -y

# Install Java (required for Jenkins)
sudo amazon-linux-extras install java-openjdk11 -y 2>/dev/null || sudo yum install java-11-openjdk -y

# Add Jenkins repository
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo yum install jenkins -y

# Start and enable Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Allow Jenkins and SSH in firewall (optional)
sudo yum install firewalld -y
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload
