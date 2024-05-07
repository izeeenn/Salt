# Instalar el openssh-server
install_ssh:
 pkg.installed:
  - name: 'openssh-server'
  - refresh: True

# Instalar el sshpass para poder ejecutar el script sin tener que poner ninguna contraseña
install_sshpass:
 pkg.installed:
  - name: 'sshpass'
  - refresh: True

# Pasar configuracion del dns para que use el dns de la maquina DNS
dns:
 file.managed:
   - name: /etc/resolv.conf
   - source: salt://tunelssh/resolv.conf

# Pasar la configuracion del sshd para poder entrar a la maquina tunel desde la LAN por ssh para darle mantenimiento
ssh:
 file.managed:
   - name: /etc/ssh/sshd_config
   - source: salt://tunelssh/sshd_config
   - makedirs: True

# Pasar el script dentro del archivo tunel.sh previamente creado en la configuracion de arriba
script-tunel2:
 file.managed:
  - name: /root/tunel.sh
  - source: salt://tunelssh/tunel.sh
  - mode: 755
  - makedir: True

# Reiniciar maquina para que se reinicien los demas servicios entre estos el networking.service
restart_machinessh:
 cmd.run:
  - name: sleep 20 && reboot


