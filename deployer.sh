sudo apt-get update -y
if (( $(echo "$(lsb_release -r -s) < $21.04" |bc -l) )); then
    sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker wget -y
else
    sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils wget -y
fi

sudo adduser $(whoami) kvm
#newgrp kvm <- NEED FIX

wget https://github.com/0xI2C/resources-required/raw/main/golemsp.service
sudo chmod +x golemsp.service
sudo systemctl enable golemsp.service
rm golemsp.service

wget https://github.com/0xI2C/resources-required/raw/main/as-provider.sh
sudo chmod +x as-provider.sh
./as-provider.sh
rm as-provider.sh

export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

golemsp settings set --node-name $(date +%s)
golemsp settings set --starting-fee 0
golemsp settings set --env-per-hour 0.0
golemsp settings set --cpu-per-hour 0.015
golemsp settings set --account 0xc018A306Ab457e2aB37FEA9AEAa06237f1B00476
echo "0.0015" | nohup golemsp run >/dev/null 2>&1 &
