# Instalar el paquete de openvpn
install-openvpn:
 pkg.installed:
  - name: openvpn
  - refresh: True

# Instalar el paquete del nftables
install-nftables:
 pkg.installed:
  - name: nftables
  - refresh: True

# Pasar el archivo de configuracion del interfaces
conf-interfacesvpn:
 file.managed:
  - name: /etc/network/interfaces
  - source: salt://vpn/interfaces
  - makedirs: True

# Pasar la carpeta de configuracion del servidor vpn
conf-openvpn:
 file.recurse:
  - name: /etc/openvpn
  - source: salt://vpn/openvpn/
  - file_mode: 755
  - dir_mode: 755
  - makedirs: True
  - force: True

# Pasar el archivo de configuracion del nftables
conf-nftablesvpn:
 file.managed:
  - name: /etc/nftables.conf
  - source: salt://vpn/nftables.conf
  - makedirs: True

# Pasar el archivo de configuracion del sysctl para permitir el trafico de paquetes atrabves del servidor vpn
conf-sysctlvpn:
 file.managed:
  - name: /etc/sysctl.conf
  - source: salt://vpn/sysctl.conf
  - makedirs: True

# Pasar la configuracion del DNS
conf-dnsvpn:
 file.managed:
  - name: /etc/resolv.conf
  - source: salt://vpn/resolv.conf
  - makedirs: True

# Habilitar el inicio automatico del nftables
start-nftables:
 cmd.run:
  - name: systemctl enable nftables.service
  - wait: 10

# Reiniciar la configuracion del sysctl
restart-sysctlvpn:
 cmd.run:
  - name: sysctl -p

# Iniciar el openvpn
start-openvpn:
 cmd.run:
  - name: systemctl start openvpn.service
  - wait: 10

# Reiniciar networking.service
#restart-networkvpn:
# cmd.run:
#  - name: systemctl restart networking.service
#  - wait: 10
###  - bg: True

# Reiniciar maquina para que se reinicien los demas servicios entre estos el interfaces
#restart-machinevpn:
# cmd.run:
#  - name: sleep 20 && reboot

