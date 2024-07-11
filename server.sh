!#/bin/ash

echo "Netcat server started"
my_ip=$(ip addr show | egrep -o "inet 192.168.1.[0-9]{1,3}")
my_ip=${my_ip:5}
echo "${my_ip}" > /volume/server_ip/ip
echo "You connected to server" | nc -lp 10404
