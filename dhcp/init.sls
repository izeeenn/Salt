instalardnsmasqF1:
 pkg.installed:
  - name: 'dnsmasq'

enviarficheroD1:
 file.managed:
  - name: /etc/network/interfaces
  - source: salt://dhcp/interfaces
  - makedirs: true

enviarficheroD3:
 file.managed:
  - name: /etc/dnsmasq.d/dhcp.conf
  - source: salt://dhcp/dhcp.conf
  - makedirs: true

enviarficheroD4:
 file.managed:
  - name: /etc/resolv.conf
  - source: salt://dhcp/resolv.conf
  - makedirs: true

reiniciardnsmasqD1:
 cmd.run:
  - name: systemctl enable dnsmasq.service
  - makedirs: true

reiniciarmaquinaD:
 cmd.run:
  - name: sleep 20 && reboot
  - makedirs: true

