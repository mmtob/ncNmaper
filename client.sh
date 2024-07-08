Data="Data"

echo "Searching server IP"
seq 1 254 | xargs -I {} -P 254 ping -c 1 -W 1 "192.168.1.{}" >/dev/null
while arp | grep -q "incomplete"; do sleep 1; done
net_ipam=$(ip route list | egrep -o "a [0-9\.]+")
net_ipam=${net_ipam:2}
server_ip=$(arp | grep -v "${net_ipam}" | egrep -o "[0-9\.]+)")
server_ip=${server_ip::-1}
echo "Server IP: $server_ip"

echo "Searching server PORT"
# seq 65535 | grep -v 80 | xargs -P 65535 -I {} sh -c "echo \"${Data}\" | nc ${server_ip} {} & echo \"PORT was: {}\nData sent\""
ports_list="$(seq 1 79) $(seq 81 65535)"
echo "${Data}" | for i in ${ports_list}; do nc ${server_ip} ${i} && echo "PORT was: ${i}" && echo "Data sent" && break; done # TODO: Encryption
echo "________________________________________"
