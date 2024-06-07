#!/bin/sh
# system update
sudo yum update -y

# httpd install
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start  

sudo echo '<h1>Welcome to Tech Learnings : Prabu from east12</h1>' | sudo tee /var/www/html/index.html
