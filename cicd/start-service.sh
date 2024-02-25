#!/bin/bash

# store node version in a variable, it is used later..
NODE_VERSION=$(node -v)

# Enable port 80 for Node.js, there are other ways to do this, but this is I chose to do it
# you can use iptables or nginx to redirect traffic from port 80 to the port your app is running on
sudo setcap 'cap_net_bind_service=+ep' /.nvm/versions/node/${NODE_VERSION}/bin/node

# find ci folder and change directory to it
# this is sometimes a nice trick to find specific folders in a directory
PROJECT_PATH=$(find /home/ec2-user/app/ -type d -name 'cicd' -print -quit)
cd $PROJECT_PATH

# again check if in root folder if not change one folder up
if [ ! -f "pnpm-workspace.yaml" ]; then
  cd ..
fi

# Install dependencies for all packages in the workspace
sudo pnpm i -w --frozen-lockfile

# Write the service file to a temporary directory
cat > /tmp/tech-talk.service << EOF
[Unit]
Description=Tech Talk App
After=network.target

[Service]
Type=simple
User=ec2-user
ExecStart=/.nvm/versions/node/${NODE_VERSION}/bin/node /home/ec2-user/app/apps/backend/index.mjs
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Move the service file to /etc/systemd/system/ where it belongs
sudo mv /tmp/tech-talk.service /etc/systemd/system/

# Reload the systemd daemon to read the new service file
sudo systemctl daemon-reload

# If tech-talk service is running, restart it
if sudo systemctl is-active tech-talk &> /dev/null; then
  sudo systemctl restart tech-talk
else
  # otherwise enable and start the service
  sudo systemctl enable tech-talk
  sudo systemctl start tech-talk
fi
