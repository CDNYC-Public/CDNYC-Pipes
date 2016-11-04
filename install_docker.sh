sudo yum update
curl -sSL https://get.docker.com/ | sh
sudo docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
sudo service docker startsudo usermod -aG docker ec2-user