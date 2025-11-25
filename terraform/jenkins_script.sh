#!/bin/bash

# ----------------------------------------
# Disable IPv6 System Wide
# ----------------------------------------
echo "Disabling IPv6..."
sudo tee /etc/sysctl.d/99-disable-ipv6.conf <<EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

sudo sysctl -p

# ----------------------------------------
# Update system packages
# ----------------------------------------
sudo yum update -y

# ----------------------------------------
# Install Java (required for Jenkins)
# ----------------------------------------
sudo amazon-linux-extras install java-openjdk11 -y 2>/dev/null || sudo yum install java-11-openjdk -y

# Verify Java
java -version

# ----------------------------------------
# Download Jenkins Repo using IPv4
# ----------------------------------------
sudo wget -4 -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import Jenkins Key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# ----------------------------------------
# Install Jenkins
# ----------------------------------------
sudo yum install jenkins -y --disableplugin=fastestmirror

# Reload systemd and enable service
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins

# ----------------------------------------
# Install and Configure Firewall (Optional)
# ----------------------------------------
sudo yum install firewalld -y
sudo systemctl start firewalld
sudo systemctl enable firewalld

# Allow Jenkins & SSH through firewall
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# ----------------------------------------
# Print Jenkins Status
# ----------------------------------------
sudo systemctl status jenkins -l
