printf "[Unit]
Description=Aethir Node
After=network-online.target
[Service]
User=root
WorkingDirectory=/root/aethir
ExecStart=/root/aethir/AethirChecker
Restart=on-failure
RestartSec=60
LimitNOFILE=65535
Environment=PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/root/aethir
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/aethird.service

sudo systemctl daemon-reload
sudo systemctl enable aethird
