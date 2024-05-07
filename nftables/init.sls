# /srv/salt/nftables.sls

# Copia el archivo de configuración interfaces.conf
interfaces-config:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://nftables/interfaces.conf
    - makedirs: True

# Instala nftables
nftables-package:
  pkg.installed:
    - name: nftables
    - refresh: True

# Instalar dnsmasq
dnsmasq-package:
  pkg.installed:
    - name: dnsmasq
    - refresh: True

# Copiar archivo configuracion del sysctl
sysctl-conf:
  file.managed:
    - name: /etc/sysctl.conf
    - source: salt://nftables/sysctl.conf
    - makedirs: True

# Copia el archivo de configuración nftables.conf
nftables-config:
  file.managed:
    - name: /etc/nftables.conf
    - source: salt://nftables/nftables.conf
    - require:
      - pkg: nftables
    - makedirs: True

# Copia el archivo de configuración nftables.conf
dnsmasq-config:
  file.managed:
    - name: /etc/dnsmasq.d/dhcp.conf
    - source: salt://nftables/dhcp.conf
    - makedirs: True

# Reiniciar sysctl
sysctl-restart:
  cmd.run:
    - name: sysctl -p

# Copiar archivo configuracion del resolv.conf para usar como DNS a la maquina dns
resolv-confnftab:
  file.managed:
    - name: /etc/resolv.conf
    - source: salt://nftables/resolv.conf
    - makedirs: True

# Reiniciar dnsmasq
dnsmasq-restartfirewall:
  cmd.run:
    - name: systemctl restart dnsmasq.service && systemctl enable nftables.service


# Reiniciar servicios y activar servicio
restart-nftables:
  cmd.run:
    - name: sleep 20 && reboot

