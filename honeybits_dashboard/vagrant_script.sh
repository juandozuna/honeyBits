sudo apt update -y --fix-missing;
sudo apt upgrade -y;

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -;
sudo apt install -y nodejs npm curl;

sudo npm install -g @angular/cli;
