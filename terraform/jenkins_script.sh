#!/bin/bash

# Disable IPv6
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.d/99-disable-ipv6.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.d/99-disable-ipv6.conf
sysctl -p

# Update system
sudo dnf update -y

# Install Java 17
sudo dnf install java-17-amazon-corretto -y

# Create Jenkins directory
sudo mkdir -p /opt/jenkins
cd /opt/jenkins

# Download Jenkins WAR
sudo wget -4 https://updates.jenkins-ci.org/latest/jenkins.war

# Create systemd service
sudo tee /etc/systemd/system/jenkins.service <<EOF
[Unit]
Description=Jenkins CI
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/opt/jenkins
ExecStart=/usr/bin/java -jar /opt/jenkins/jenkins.war --httpPort=8080
SuccessExitStatus=143

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reload

# Start and enable Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Open firewall port (if firewalld installed)
sudo dnf install firewalld -y
sudo systemctl enable firewalld --now
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
