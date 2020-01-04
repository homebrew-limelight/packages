# wait for opensight to close before running script
echo "Waiting for Opensight to exit..."
while ps aux | grep opensight | grep -v shellinaboxd | grep [p]ython; do sleep 1; done
echo "Starting upgrade."
# force overwrite for stdeb
dpkg --force-overwrite -Ri "deps"
apt-mark auto
for file in "deps/"*; do
    name="$(dpkg -I $file | grep -m1 Package | cut -d ' ' -f3)"
    echo "Marking $name as auto"
    apt-mark auto "$name"
done
apt-mark manual "opensight"
dpkg --skip-same-version -Ri "system-deps"
apt-get -y autoremove
reboot
