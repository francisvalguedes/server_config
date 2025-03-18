Para redirecionar a porta 80 para 8080

~~~
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
~~~

se ao fazer isso for possivel executar o site sem especificar a porta no navegador a partir de um host, então é só fazer a mudança permanente com:

~~~
sudo apt install iptables-persistent
~~~

se já instalado fazer:
~~~
sudo dpkg-reconfigure iptables-persistent
~~~







now save iptables permenantley to files:
~~~
sudo iptables-save | sudo tee /etc/iptables/rules.v4
sudo ip6tables-save | sudo tee /etc/iptables/rules.v6
~~~



para testar se o app realmente ta rodando na porta 8080 pode-se utilizar o curl

~~~
curl http...
~~~

verificar conexões disponíveis e configuração do iptables

~~~
netstat -i
sudo iptables -t nat -L PREROUTING -n -v
sudo iptables -L OUTPUT -n -v
~~~


Ative o encaminhamento temporariamente (não foi necessário no ubuntu server):

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

outros comandos (não foi necessário)
~~~
sudo iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

sudo iptables -I OUTPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I OUTPUT -p tcp --dport 8080 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT -p tcp --dport 8080 -j ACCEPT

sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 8080/tcp
sudo ufw enable
sudo ufw status verbose
~~~

