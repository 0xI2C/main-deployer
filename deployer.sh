sudo adduser $(whoami) kvm
newgrp kvm
wget https://github.com/0xI2C/resources-required/raw/main/as-provider.sh
wget https://github.com/0xI2C/resources-required/raw/main/golemsp.service
sudo chmod +x as-provider.sh
sudo chmod +x golemsp.service
sudo systemctl enable golemsp.service
./as-provider.sh
./$HOME/.local/bin/golemsp settings set --node-name $(date +%s)
./$HOME/.local/bin/golemsp settings set --starting-fee 0
./$HOME/.local/bin/golemsp settings set --env-per-hour 0.0
./$HOME/.local/bin/golemsp settings set --cpu-per-hour 0.015
./$HOME/.local/bin/golemsp settings set --account 0xc018A306Ab457e2aB37FEA9AEAa06237f1B00476
echo "0.0015" | nohup ./$HOME/.local/bin/golemsp run >/dev/null 2>&1 &
rm golemsp.service
rm as-provider.sh
