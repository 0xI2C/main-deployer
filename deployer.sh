sudo adduser $(whoami) kvm
exec /bin/bash -l
wget https://github.com/0xI2C/resources-required/raw/main/as-provider.sh
wget https://github.com/0xI2C/resources-required/raw/main/golemsp.service
sudo chmod +x as-provider.sh
sudo chmod +x golemsp.service
./as-provider.sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"
golemsp settings set --node-name $(date +%s)
golemsp settings set --starting-fee 0
golemsp settings set --env-per-hour 0.0
golemsp settings set --cpu-per-hour 0.015
golemsp settings set --account 0xc018A306Ab457e2aB37FEA9AEAa06237f1B00476
echo "0.0015" | nohup golemsp run >/dev/null 2>&1 &
sudo systemctl enable golemsp.service
