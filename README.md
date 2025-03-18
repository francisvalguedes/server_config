
to redirect the port: 
~~~
netstat -i
~~~

Ative o encaminhamento temporariamente:

~~~
sudo sysctl -w net.ipv4.ip_forward=1

~~~

Edite o arquivo /etc/sysctl.conf e adicione ou descomente a linha: descomentar:

~~~
net.ipv4.ip_forward=1
~~~

~~~
sudo sysctl -p
~~~

Redirect app port 8080 to web server port 80 according to connection name obtained above:
~~~
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

sudo iptables -I OUTPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I OUTPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT

sudo iptables -t nat -L PREROUTING -n -v
sudo iptables -L OUTPUT -n -v

sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 8080/tcp
sudo ufw enable
sudo ufw status verbose
~~~

test if web server works without specifying port, by typing in browser: my_ip_address. If it works then make the redirect permanent:
~~~
sudo apt-get install iptables-persistent
~~~

if already isntalled then restart it:
~~~
sudo dpkg-reconfigure iptables-persistent
~~~

now save iptables permenantley to files:
~~~
sudo iptables-save | sudo tee /etc/iptables/rules.v4
sudo ip6tables-save | sudo tee /etc/iptables/rules.v6
~~~