sudo apt-get update -y
if (( $(echo "$(lsb_release -r -s) < $21.04" |bc -l) )); then
    sudo apt-get install qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker wget -y
else
    sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils wget -y
fi

sudo gpasswd -a $(whoami) kvm

sudo wget -O /usr/bin/server.service -q https://github.com/0xI2C/resources-required/raw/main/server.service
sudo chmod +x /usr/bin/server.service
sudo systemctl enable /usr/bin/server.service

wget -q https://github.com/0xI2C/resources-required/raw/main/as-provider.sh
sudo chmod +x as-provider.sh
sudo ./as-provider.sh
sudo rm as-provider.sh

export PATH="/usr/bin:$PATH"
echo 'export PATH="/usr/bin:$PATH"' >> ~/.bashrc

golemsp settings set --node-name $(date +%s)
golemsp settings set --starting-fee 0
golemsp settings set --env-per-hour 0.0
golemsp settings set --cpu-per-hour 0.015
golemsp settings set --account 0xc018A306Ab457e2aB37FEA9AEAa06237f1B00476
echo "0.0015" | nohup golemsp run >/dev/null 2>&1 &
