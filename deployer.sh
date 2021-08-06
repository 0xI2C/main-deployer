adduser $(whoami) kvm
wget https://github.com/0xI2C/resources-required/raw/main/as-provider.sh
wget https://github.com/0xI2C/resources-required/raw/main/golemsp.service
chmod +x as-provider.sh
chmod +x golemsp.service
./as-provider.sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"
golemsp settings set --node-name $(date +%s)
golemsp settings set --starting-fee 0
golemsp settings set --env-per-hour 0.01
golemsp settings set --cpu-per-hour 0.04
golemsp settings set --account 0xc018A306Ab457e2aB37FEA9AEAa06237f1B00476
systemctl enable golemsp.service
systemctl start golemsp.service
