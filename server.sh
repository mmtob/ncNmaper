echo "Netcat server started"
echo "Netcat logs in /volume/logging.txt"
while true; do nc -lvk 0>/dev/null 1> >(while read message; do echo "$(date +'%D %T') [$(cat /volume/ip)] (client) ${message}"; done) 2> >(egrep -o "[0-9\.]{7,}" | sed -n '2p' > /volume/ip) | tee -a /volume/logging.txt; done
