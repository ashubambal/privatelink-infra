#!/bin/bash

# This script installs and starts Nginx on Ubuntu

# Update package list
echo "Updating package list..."
sudo apt update -y

# Install Nginx
echo "Installing Nginx..."
sudo apt install nginx -y

# Start and enable Nginx service
echo "Starting Nginx service..."
sudo systemctl start nginx

echo "Enabling Nginx to start on boot..."
sudo systemctl enable nginx

# Allow firewall rules (optional)
echo "Allowing HTTP and HTTPS in UFW..."
sudo ufw allow 'Nginx Full'

# Print status
echo "Checking Nginx status..."
systemctl status nginx

echo "Nginx installation and setup completed successfully!"
