# Instalar el dnsmasq
instalardnsmasqDN1:
 pkg.installed:
  - name: 'dnsmasq'
  - makedirs: true

# Pasar configuracion del interfaces
enviarficheroDN1:
 file.managed:
  - name: /etc/network/interfaces
  - source: salt://dns/interfaces
  - makedirs: true

# Pasar la configuracion del dnsmasq para que esta maquina actue como dns
enviarficheroDN3:
 file.managed:
  - name: /etc/dnsmasq.d/dns.conf
  - source: salt://dns/dns.conf
  - makedirs: true

# Pasar el dns para que use como dns la maquina DNS
enviarficheroDN4:
 file.managed:
  - name: /etc/resolv.conf
  - source: salt://dns/resolv.conf
  - makedirs: true

# Habilitar la autoarrancada del servicio dnsmasq para que cuando reiniciemos la maquina se inicie automaticamente
reiniciardnsmasqDN1:
 cmd.run:
  - name: systemctl enable dnsmasq.service
  - makedirs: true

# Reiniciar maquina para que se reincien los demas servicios entre estos el networking.service
reiniciarmaquinaDN:
 cmd.run:
  - name: sleep 15 && reboot 
  - makedirs: true
 

