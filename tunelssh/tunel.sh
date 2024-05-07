#!/bin/bash

# Contraseña que acceder a la puerta
password="alumnat"

# Ip que usara de puerta
ip="172.31.4.32"

# Comando que abrira el tunel
sshpass -p '$password' ssh -f -N -R 2240:localhost:22 root@$ip
