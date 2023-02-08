#!/bin/bash

mkdir -p /home/ubuntu/app
cd /home/ubuntu/app

sudo apt -y update
sudo apt -y upgrade
sudo apt -y install git
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install 16

cd /home/ubuntu/app
GIT_TERMINAL_PROMPT=0 
git clone --recurse-submodule -j8 https://github.com/SalvaChiLlo/Proyecto-IEI
cd Proyecto-IEI
git submodule foreach git checkout main
npm install
npm install -g ts-node
cd IEIBack

echo "
#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
cd /var/app/Proyecto-IEI/IEIBack
npm run serve
" > /home/ubuntu/app/execute_backend.sh

chmod a+x /home/ubuntu/app/execute_backend.sh

echo "
[Unit]
Description=Proyecto ICP Backend
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
User=ubuntu
ExecStart=/var/app/execute_backend.sh

[Install]
WantedBy=multi-user.target
" > /home/ubuntu/app/proyecto-icp-backend.service
sudo cp /home/ubuntu/app/proyecto-icp-backend.service /etc/systemd/system/proyecto-icp-backend.service

sudo mv /home/ubuntu/app /var/

sudo systemctl enable --now proyecto-icp-backend
