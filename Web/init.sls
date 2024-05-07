# Instalar el nginx
ngingx:
   pkg.installed:
    - name: nginx

# Pasar la configuracion del nginx
nginx_conf:
  file.managed:
   - name: /etc/nginx/nginx.conf
   - source: salt://web/nginx.conf
   - makedirs: True

# Configurar el ssh para poder entrar desde cualquier maquina de la LAN para darle servicio remotamente
ssh_config:
  file.managed:
   - name: /etc/ssh/sshd_config
   - source: salt://web/sshd_config
   - makedirs: True

# Crar archivos y directorios de la pagina principal del servidor web
index.html:
  file.managed:
   - name: /var/www/blaus123.com/html
   - source: salt://web/index.html
   - makedirs: true

# Pasar los certificados de la pagina principal del servidor web
certs.crt:
  file.managed:
   - name: /etc/ssl/certs/blaus123.com.crt
   - source: salt://web/blaus123.com.crt
   - makedirs: true

# Pasar las claves de los certificados de la pagina principal del servidor web
cert.key:
  file.managed:
   - name: /etc/ssl/private/blaus123.com.key
   - source: salt://web/blaus123.com.key
   - makedirs: true

# Pasar configuracion del dns para que use como dns la maquina DNS 
dns-configweb:
  file.managed:
   - name: /etc/resolv.conf
   - source: salt://web/resolv.conf
   - makedirs: true

# Pasar el archivo el cual habilitara nuestra pagina en el navegador
sites-available:
  file.managed:
   - name: /etc/nginx/sites-available/blaus123.com
   - source: salt://web/blaus123.com
   - makedirs: True

# Pasar el archivo de configuracion de la pagina el cual autoarrancara la pagina que se haya introducido en esta ruta
sites-enabled:
  file.managed:
   - name: /etc/nginx/sites-enabled/blaus123.com
   - source: salt://web/blaus123.com
   - makedirs: True

# Pasar el archivo dhparam
dhparam:
  file.managed:
   - name: /etc/nginx/dhparam.pem
   - source: salt://web/dhparam.pem
   - makedirs: True

# Pasar las configuraciones de los certificados ssl del dhparam
ssl-params:
  file.managed:
   - name: /etc/nginx/snippets/ssl-params.conf
   - source: salt://web/ssl-params.conf
   - makedirs: true

# Habilitar y reiniciar el servicio nginx
nginx_started:
  service.running:
   - name: nginx.service
   - enable: True
   - enable_restart: True

# Pasar el script el cual nos facilitara la creacion de paginas web de clientes
nginx-sh:
  file.managed:
    - name: /root/nginx.sh
    - source: salt://web/nginx.sh
    - mode: '755'
    - makedirs: True

# Pasar la configuracion del interfaces
interfaces-configuracion:
  file.managed:
    - name: /etc/network/interfaces
    - source: salt://web/interfaces
    - makedirs: True

# Reiniciar maquina para que se reinicien los demas servicios entre estos el networking.service
reinciar-maquinaweb:
  cmd.run:
    - name: sleep 20 && reboot
