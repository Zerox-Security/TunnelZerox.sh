#!/bin/bash

show_banner() {
    clear
    echo -e "\e[32m"
    echo '
            ESTRUCTURA TUNNEL
 
┌──────┐      ┌─────────┐      ┌──────┐
│SERVER├────► │CLOUFLARE├────► │ USER │
└──────┘      └────┬────┘      └──────┘

    ╺━┓┏━╸┏━┓┏━┓╻ ╻   ┏━┓┏━╸┏━╸╻ ╻┏━┓╻╺┳╸╻ ╻
    ┏━┛┣╸ ┣┳┛┃ ┃┏╋┛   ┗━┓┣╸ ┃  ┃ ┃┣┳┛┃ ┃ ┗┳┛
    ┗━╸┗━╸╹┗╸┗━┛╹ ╹   ┗━┛┗━╸┗━╸┗━┛╹┗╸╹ ╹  ╹
             Protección Nivel 2
                Ubuntu 20.04
    '
    echo -e "\e[0m"
}

# ZEROX SECURITY - HORUS INNOVA
show_goodbye() {
    echo -e "\e[32mEstoy aquí para lo que necesites, solo invócame con la palabra zerox desde cualquier lugar y acá estaré,\e[0m"
    echo -n "Saliendo"
    for i in {1..8}
    do
        if (( i % 2 == 0 )); then
            echo -ne "\e[31m.\e[0m"
        else
            echo -ne "\e[34m.\e[0m"
        fi
        sleep 1
    done
    echo ""
}

# ZEROX SECURITY - HORUS INNOVA
main_menu() {
    show_banner
    echo -e "\e[34m1. CLOUDFLARE"
    echo -e "2. WORDPRESS"
    echo -e "3. RESPALDOS"
    echo -e "0. Salir de ZEROX\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1) cloudflare_menu;;  
        2) wordpress_menu;;  
        3) respaldo_archivos_menu;;  
        4) reset_menu;;  
        0) show_goodbye; exit;;
        *) echo "Opción inválida"; main_menu;;  
    esac
}

# ZEROX SECURITY - HORUS INNOVA
cloudflare_menu() {
    show_banner
    echo -e "\e[34m1. Instalar"  
    echo -e "2. Formatear"  
    echo -e "3. Tutorial"  
    echo -e "0. Volver"
    echo -e "9. Salir\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1) 
		
# ZEROX SECURITY - HORUS INNOVA
sudo apt update > /dev/null 2>&1
sudo apt upgrade -y > /dev/null 2>&1
echo "" | sudo tee /etc/hostname

# ZEROX SECURITY - HORUS INNOVA
while true; do
    read -p "Ingrese el nombre de dominio: " domain_name
    if [ -z "$domain_name" ]; then
        echo "El nombre de dominio es obligatorio. Por favor, inténtelo de nuevo."
    else
        break
    fi
done

# ZEROX SECURITY - HORUS INNOVA
local_ip=$(grep -Po '^\d+\.\d+\.\d+\.\d+\s+localhost' /etc/hosts | awk '{print $1}') > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
if [ -z "$local_ip" ]; then
    echo "No se pudo determinar la dirección IP local asociada a localhost del archivo /etc/hosts."
    exit 1
fi

# ZEROX SECURITY - HORUS INNOVA
domain_name_without_extension="${domain_name%%.*}"  > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
echo "$domain_name" | sudo tee /etc/hostname > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo sed -i "/$local_ip\s/d" /etc/hosts > /dev/null 2>&1
 
# ZEROX SECURITY - HORUS INNOVA
echo -e "$local_ip\tlocalhost" | sudo tee -a /etc/hosts > /dev/null

# ZEROX SECURITY - HORUS INNOVA
echo -e "$local_ip\t$domain_name\t$domain_name_without_extension" | sudo tee -a /etc/hosts > /dev/null

# ZEROX SECURITY - HORUS INNOVA
echo "El nombre de host y dominio se han configurado correctamente." > /dev/null 2>&1

# ZEROX SECURITY
architecture=$(uname -m)

# ZEROX SECURITY - HORUS INNOVA
case $architecture in
    "x86_64" | "amd64")
        download_url="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb"
        filename="cloudflared-linux-amd64.deb"
        ;;
    "i386")
        download_url="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386.deb"
        filename="cloudflared-linux-386.deb"
        ;;
    "armv7l")
        download_url="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm.deb"
        filename="cloudflared-linux-arm.deb"
        ;;
    "aarch64")
        download_url="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb"
        filename="cloudflared-linux-arm64.deb"
        ;;
    *)
        echo "Arquitectura no compatible: $architecture"
        exit 1
        ;;
esac

# ZEROX SECURITY
echo "Descargando Cloudflared desde $download_url..." > /dev/null 2>&1
wget "$download_url" -O "$filename" > /dev/null 2>&1
sudo dpkg -i "$filename" > /dev/null 2>&1

# ZEROX SECURITY
rm "$filename"

# ZEROX SECURITY
cloudflared tunnel login 

# ZEROX SECURITY
echo "Vamos a crear un túnel con Cloudflared."

# ZEROX SECURITY - HORUS INNOVA
while true; do
    read -p "Por favor, ingresa un nombre para el túnel: " tunnel_name
    if [ -z "$tunnel_name" ]; then
        echo "El nombre del túnel es obligatorio. Por favor, inténtelo de nuevo."
    else
        break
    fi
done

# ZEROX SECURITY
cloudflared tunnel create "$tunnel_name" > /dev/null 2>&1

echo "¡Túnel \"$tunnel_name\" creado exitosamente!" > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
cd ~/.cloudflared

# ZEROX SECURITY
json_filename=$(ls -1 ~/.cloudflared/*.json | tail -n 1)

# ZEROX SECURITY
filename_no_extension=$(basename "$json_filename" .json)

# ZEROX SECURITY
cat << EOF > ~/.cloudflared/config.yml
tunnel: $filename_no_extension
credentials-file: /root/.cloudflared/${filename_no_extension}.json

ingress:
  - hostname: $(hostnamectl --static)
    service: http://localhost:80
  - hostname: zerox.$(hostnamectl --static)
    service: http://localhost:80
    originRequest:
      noTLSVerify: true
  - service: http_status:404
EOF

echo "Se ha creado los ajustes solicitados."

# ZEROX SECURITY - HORUS INNOVA
while true; do
    # ZEROX SECURITY
    cloudflared tunnel route dns "$tunnel_name" "$domain_name" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Se ha agregado la ruta DNS al túnel \"$tunnel_name\" para el dominio \"$domain_name\"." > /dev/null 2>&1
        break
    else
        echo "El comando arrojó errores. Volviendo a ejecutar..."
    fi
done

mkdir -p --mode=0755 /usr/share/keyrings 

curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg > /dev/null 2>&1 
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared focal main' | sudo tee /etc/apt/sources.list.d/cloudflared.list > /dev/null 2>&1

echo "Se ha creado la actualizacíon automatica de CloudFlare" > /dev/null 2>&1

sudo apt-get update > /dev/null 2>&1
sudo apt-get upgrade -y > /dev/null 2>&1

cloudflared service install > /dev/null 2>&1

systemctl restart cloudflared > /dev/null 2>&1

rm -r /root/zeroxTunnel.sh > /dev/null 2>&1
# ZEROX SECURITY
sudo apt-get install iptables-persistent -y > /dev/null 2>&1

/sbin/iptables-save > /etc/iptables.conf > /dev/null 2>&1

iptables-restore < /etc/iptables.conf > /dev/null 2>&1

sudo netfilter-persistent save > /dev/null 2>&1

sudo netfilter-persistent reload > /dev/null 2>&1

# ZEROX SECURITY
curl -s https://www.cloudflare.com/ips-v4 > /tmp/cloudflare_ips.txt > /dev/null 2>&1

# ZEROX SECURITY 
cloudflare_rules_file="/usr/local/cloudflare/zerox-Clouflare.txt" > /dev/null 2>&1

# ZEROX SECURITY
if ! iptables -L CLOUDFLARE -n &>/dev/null; then
    iptables -N CLOUDFLARE
fi

# ZEROX SECURITY
iptables -F CLOUDFLARE > /dev/null 2>&1

# ZEROX SECURITY
while read -r ip; do
    iptables -A CLOUDFLARE -s "$ip" -p tcp -m multiport --dports 80,443 -j ACCEPT
done < /tmp/cloudflare_ips.txt > /dev/null 2>&1

# ZEROX SECURITY
if [ -f "$cloudflare_rules_file" ]; then
    source "$cloudflare_rules_file"
fi

# ZEROX SECURITY
iptables-save > /etc/iptables/rules.v4 > /dev/null 2>&1

# ZEROX SECURITY
echo "Script de actualización de reglas de Cloudflare ejecutado en $(date)" >> /var/log/cloudflare_update.log

lineas=("HEMOS INSTALADO CLOUDFLARED A NIVEL NUCLEO" "REVISA TU TUNEL EN CLOUDFLARED EN LA URL : https://one.dash.cloudflare.com/" "EN EL AREA networks/tunnels SI VES QUE ESTÁ EN VERDE ENTONCES TODO ESTÁ PERFECTO" "SI NO, PUEDES EJECUTAR ELIMINAR EN LA OPCION 2")
colores=('\033[0;32m' '\033[0;34m' '\033[0;35m' '\033[0;31m')

for j in "${!lineas[@]}"; do
  echo -ne "${colores[$j]}"
  for (( i=0; i<${#lineas[j]}; i++ )); do
    echo -n "${lineas[j]:$i:1}"
    sleep 0.05
  done
  echo -e '\033[0m'
  sleep 0.5
done

# ZEROX SECURITY - HORUS INNOVA
read -p "$(echo -e '\033[32mPresiona Enter para continuar...\033[0m')"
            cloudflare_menu;;
        2) 
		
# ZEROX SECURITY - HORUS INNOVA
sudo systemctl stop cloudflared cloudflared-update > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo systemctl disable cloudflared cloudflared-update > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo rm /etc/systemd/system/cloudflared.service /etc/systemd/system/cloudflared-update.service /etc/systemd/system/cloudflared-update.timer > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo systemctl daemon-reload > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo cloudflared service uninstall -y > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo rm -r /usr/local/bin/cloudflared /usr/local/etc/cloudflared /usr/share/doc/cloudflared > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo rm -r /usr/bin/cloudflared > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo rm -rf ~/.cloudflared > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo apt-get remove --purge cloudflared -y > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo find / -name "cloudflared" -exec rm -r {} \; > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
sudo rm -r /etc/cloudflared > /dev/null 2>&1

# ZEROX SECURITY - HORUS INNOVA
echo -e "\e[32mLa desinstalación de cloudflared ha finalizado. Ahora debes ir a tu cuenta de CloudFlare y eliminar el CNAME en el DNS. Después, debes eliminar el túnel en la cuenta de CloudFlare.\e[0m"

# ZEROX SECURITY - HORUS INNOVA
read -p "Presiona Enter para continuar..."
            cloudflare_menu;;
        3) 
	
# ZEROX SECURITY - HORUS INNOVA
lineas=("Ingresa a:" "zeroxsecurity.com/cloudflare/tunel" "Puedes compartirnos tus errores para solucionarlos juntos" "No olvides pasar por nuestro canal de YouTube")
colores=('\033[0;32m' '\033[0;34m' '\033[0;35m' '\033[0;31m')

for j in "${!lineas[@]}"; do
  echo -ne "${colores[$j]}"
  for (( i=0; i<${#lineas[j]}; i++ )); do
    echo -n "${lineas[j]:$i:1}"
    sleep 0.05
  done
  echo -e '\033[0m'
  sleep 0.5
done

# ZEROX SECURITY - HORUS INNOVA
read -p "$(echo -e '\033[32mPresiona Enter para continuar...\033[0m')"

           cloudflare_menu;;
        0) main_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; cloudflare_menu;;
    esac
}

wordpress_menu() {
    show_banner
    echo -e "\e[34m1. Instalar WordPress"  
    echo -e "2. Eliminar WordPress"  
    echo -e "3. Cambiar contraseña"  
    echo -e "4. Bloquear panel Admin"  
    echo -e "5. Configurar php.ini"  
    echo -e "6. MySQL"  
    echo -e "0. Volver al menú anterior"
    echo -e "9. Salir de Zerox\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1) 
		
# ZEROX SECURITY - HORUS INNOVA		
		
print_color() {
    echo -e "$1$2\e[0m"
}


# ZEROX SECURITY - HORUS INNOVA
RED='\033[0;31m'

NC='\033[0m'

mensaje="VAMOS A EMPEZAR A INSTALAR TODO - SOLO ESPERA..."

for (( i=0; i<${#mensaje}; i++ )); do
  echo -ne "${RED}${mensaje:$i:1}${NC}"
  sleep 0.01
done
echo ""

sudo apt update -qq  > /dev/null 2>&1
sudo apt install apache2 -y -qq > /dev/null 2>&1

while [[ -z "$carpeta_nombre" ]]; do
    print_color "\e[35m" "Indica el nombre de la carpeta donde deseas almacenar tus archivos: "
    read carpeta_nombre
    if [[ -z "$carpeta_nombre" ]]; then
        echo "Por favor, ingresa un nombre válido para la carpeta."
    fi
done

sudo mkdir -p "/var/www/html/$carpeta_nombre"
sudo chown -R www-data:www-data "/var/www/html/$carpeta_nombre"
sudo chmod -R 755 "/var/www/html/$carpeta_nombre"

dominio_nombre=$(cat /etc/hostname)

echo "<VirtualHost *:80> 
    ServerName $dominio_nombre
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html/$carpeta_nombre
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    <Directory /var/www/html/$carpeta_nombre>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    # Redirigir todas las solicitudes de la IP del servidor a la URL del sitio web
    RewriteEngine on
    RewriteCond %{HTTP_HOST} ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$
    RewriteRule ^(.*)$ https://$dominio_nombre/$1 [L,R=301]
</VirtualHost>" | sudo tee "/etc/apache2/sites-available/$dominio_nombre.conf" > /dev/null 2>&1
# ZEROX SECURITY - HORUS INNOVAsudo a2dissite 000-default > /dev/null 2>&1
sudo a2ensite "$dominio_nombre.conf" > /dev/null 2>&1

echo "ServerSignature Off 
ServerTokens Prod
TraceEnable Off
Header unset X-Powered-By
Header unset X-CF-Powered-By
Header unset X-Mod-Pagespeed
Header unset X-Pingback
Header unset X-Drupal-Cache 
Header unset X-Generator" | sudo tee /etc/apache2/conf-available/security.conf > /dev/null 2>&1
sudo a2enconf security > /dev/null 2>&1

sudo a2enmod rewrite > /dev/null 2>&1
sudo a2enmod headers > /dev/null 2>&1

sudo systemctl restart apache2 > /dev/null 2>&1
 
sudo wget -O "/var/www/html/$carpeta_nombre/index.html" https://archive.org/download/index_20240328_2318/index.html > /dev/null 2>&1
sudo chown www-data:www-data "/var/www/html/$carpeta_nombre/index.html" > /dev/null 2>&1
sudo chmod 644 "/var/www/html/$carpeta_nombre/index.html" > /dev/null 2>&1

echo "$(readlink -f "/var/www/html/$carpeta_nombre")" | sudo tee "/tmp/ZeroxRuta.txt" > /dev/null 2>&1

print_color "\e[35m" "Nombre de la carpeta: $carpeta_nombre" > /dev/null 2>&1

for ((i = 0 ; i <= 100 ; i+=10)); do
    sleep 1
    if [[ $i -lt 40 ]]; then
        print_color "\e[33m" "$i% "
    elif [[ $i -lt 80 ]]; then
        print_color "\e[31m" "$i% "
    else
        print_color "\e[34m" "$i% "
    fi
done

print_color "\e[34m" "100%"
print_color "\e[0m\e[35m100%\nHemos realizado la instalación y configuración de su servidor.\nVamos a instalar WordPress, este proceso puede demorar un poco.\n\e[0m"

sleep 5

sudo apt update -qq > /dev/null 2>&1
sudo apt install -y mysql-server php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-ldap php-zip php-curl > /dev/null 2>&1

sudo systemctl start mysql > /dev/null 2>&1

while true; do
    read -p "Nombre de la base de datos WordPress: " dbname
    if [[ -n "$dbname" ]]; then
        break
    fi
done

while true; do
    read -p "Usuario de la base de datos WordPress: " dbuser
    if [[ -n "$dbuser" ]]; then
        break
    fi
done

while true; do
    read -s -p "Contraseña del usuario de la base de datos WordPress: " dbpass
    echo
    if [[ -n "$dbpass" ]]; then
        break
    fi
done

mysql -u root <<EOF
CREATE DATABASE $dbname;
CREATE USER '$dbuser'@'localhost' IDENTIFIED BY '$dbpass';
GRANT ALL ON $dbname.* TO '$dbuser'@'localhost';
FLUSH PRIVILEGES;
EOF

ruta_archivos=$(cat "/tmp/ZeroxRuta.txt")

wget -q https://wordpress.org/latest.tar.gz > /dev/null 2>&1
unzip latest-es_ES.zip > /dev/null 2>&1

sudo mv wordpress/* "$ruta_archivos"
sudo mv wordpress/.htaccess "$ruta_archivos" 2>/dev/null
rm -rf wordpress latest.tar.gz > /dev/null 2>&1

sudo chown -R www-data:www-data "$ruta_archivos"
sudo chmod -R 755 "$ruta_archivos" > /dev/null 2>&1

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp

cd "$ruta_archivos"

while true; do
    read -p $'\e[1;34mNombre del sitio WordPress: \e[0m' sitename
    if [[ -n "$sitename" ]]; then
        break
    fi
done

while true; do
    read -p $'\e[1;34mNombre de usuario del administrador de WordPress: \e[0m' wpuser
    if [[ -n "$wpuser" ]]; then
        break
    fi
done

while true; do
    read -s -p $'\e[1;34mContraseña del administrador de WordPress: \e[0m' wppass
    echo
    if [[ -n "$wppass" ]]; then
        break
    fi
done

while true; do
    read -p $'\e[1;34mCorreo electrónico del administrador de WordPress: \e[0m' wpemail
    if [[ -n "$wpemail" && "$wpemail" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        break
    fi
    echo "Por favor, ingresa una dirección de correo electrónico válida."
done


wp config create --dbname="$dbname" --dbuser="$dbuser" --dbpass="$dbpass" --locale=es_ES --allow-root --quiet  > /dev/null 2>&1

wp core install --url="$dominio_nombre" --title="$sitename" --admin_user="$wpuser" --admin_password="$wppass" --admin_email="$wpemail" --allow-root --quiet  > /dev/null 2>&1

wget -q -O wp.keys https://api.wordpress.org/secret-key/1.1/salt/

sed -i '/AUTH_KEY/d; /SECURE_AUTH_KEY/d; /LOGGED_IN_KEY/d; /NONCE_KEY/d; /AUTH_SALT/d; /SECURE_AUTH_SALT/d; /LOGGED_IN_SALT/d; /NONCE_SALT/d' wp-config.php
sed -i '/@package WordPress/a require_once(ABSPATH . '\''wp.keys'\'');' wp-config.php

sudo apt install -y php7.4 libapache2-mod-php7.4 > /dev/null 2>&1
sudo a2enmod php7.4 > /dev/null 2>&1
sudo a2enmod headers > /dev/null 2>&1

sudo rm "$ruta_archivos/index.html" > /dev/null 2>&1
sudo rm "/var/www/html/index.html" > /dev/null 2>&1
sudo rm "$ruta_archivos/license.txt" > /dev/null 2>&1
sudo rm "$ruta_archivos/readme.html" > /dev/null 2>&1

sudo a2enmod rewrite > /dev/null 2>&1
sudo a2enmod php7.4 > /dev/null 2>&1
sudo a2enmod headers > /dev/null 2>&1

sudo apt-get install -y unattended-upgrades > /dev/null 2>&1
sudo cat <<EOF > /etc/apt/apt.conf.d/20auto-upgrades > /dev/null 2>&1
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
EOF
sudo systemctl enable unattended-upgrades > /dev/null 2>&1
sudo systemctl restart unattended-upgrades > /dev/null 2>&1

# En lugar de usar la variable $ruta, vamos a buscar el archivo wp-config.php y obtener su directorio
wp_config_path=$(sudo find / -name wp-config.php -exec dirname {} \; 2>/dev/null)

# Cambia al directorio de instalación de WordPress
cd "$wp_config_path" || { exit 1; }

# El resto de tu script sigue aquí...
if ! command -v wp > /dev/null; then
    curl -sS -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&
    chmod +x wp-cli.phar &&
    sudo mv wp-cli.phar /usr/local/bin/wp
fi

hostname=$(<"/etc/hostname")

wp option update home "https://${hostname}" --allow-root > /dev/null &&

wp option update siteurl "https://${hostname}" --allow-root > /dev/null &&

# ZEROX SECURITY - HORUS INNOVA
if wp plugin is-installed akismet --allow-root > /dev/null; then
    wp plugin delete akismet --allow-root > /dev/null
fi &&

# Aquí es donde agregamos el comando para eliminar el plugin hello.php
wp plugin delete hello --allow-root > /dev/null &&

wp rewrite structure '/%postname%' --allow-root > /dev/null &&

echo -e "\033[92mAhora tienes el SSL funcional\033[0m" > /dev/null
wp --allow-root option update thumbnail_crop 0 > /dev/null 2>&1
wp option update thumbnail_size_w 0 --allow-root > /dev/null 2>&1
wp option update thumbnail_size_h 0 --allow-root > /dev/null 2>&1
wp option update medium_size_w 0 --allow-root > /dev/null 2>&1
wp option update medium_size_h 0 --allow-root > /dev/null 2>&1
wp option update large_size_w 0 --allow-root > /dev/null 2>&1
wp option update large_size_h 0 --allow-root > /dev/null 2>&1
wp option update uploads_use_yearmonth_folders 0 --allow-root > /dev/null 2>&1

wp language core install es_ES --activate --allow-root > /dev/null 2>&1
wp rewrite structure '/%postname%' --allow-root > /dev/null &&
domain_name=$(cat /etc/hostname)

wp_config_path=$(sudo find / -name wp-config.php -exec dirname {} \; 2>/dev/null)

# Verifica si la ruta no está vacía
if [[ -n "$wp_config_path" ]]; then
    # Verifica si el archivo wp-config.php existe en la ruta encontrada
    if [[ -f "$wp_config_path/wp-config.php" ]]; then
        # Verifica si la línea ya existe en el archivo
        if ! grep -Fxq "\$_SERVER['HTTPS'] = 'on';" "$wp_config_path/wp-config.php"; then
            # Si la línea no existe, la añade antes de "/* That's all, stop editing! Happy publishing. */"
            sudo sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i \$_SERVER['HTTPS'] = 'on';" "$wp_config_path/wp-config.php" 2>/dev/null
        fi
    else
        # Redirige el mensaje de error a /dev/null para que no se muestre
        echo -e "\e[31mWordPress no está instalado, primero debes de instalarlo.\e[0m" > /dev/null 2>&1
    fi
else
    # Redirige el mensaje de error a /dev/null para que no se muestre
    echo -e "\e[31mWordPress no está instalado, primero debes de instalarlo.\e[0m" > /dev/null 2>&1
fi


wp_config_path=$(sudo find / -name wp-config.php -exec dirname {} \; 2>/dev/null)

cd "$wp_config_path" || { exit 1; }

echo -e '# BEGIN WordPress\n<IfModule mod_rewrite.c>\nRewriteEngine On\nRewriteBase /\nRewriteRule ^index\\.php$ - [L]\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule . /index.php [L]\n</IfModule>\n# END WordPress' > "$wp_config_path/.htaccess" > /dev/null 2>&1


cd "$wp_config_path" || { exit 1; }

# Usa wp-cli para actualizar la configuración de los enlaces permanentes
wp rewrite structure '/%postname%/' --hard --allow-root > /dev/null 2>&1
wp rewrite flush --hard --allow-root  > /dev/null 2>&1

echo -e "\e[94mBase de datos:\e[0m $dbname"
echo -e "\e[94mUsuario:\e[0m $dbuser"
echo -e "\e[94mContraseña:\e[0m $dbpass"
echo -e "\e[94mURL de acceso:\e[0m https://\e[32m$domain_name/wp-admin\e[0m"

mensaje="Ahora tienes WordPress funcionando bajo la red Zerox Tunnel"

color_inicio="\033[92m"
color_fin="\033[0m"

printf "%b" "$color_inicio" 
for ((i = 0; i < ${#mensaje}; i++)); do
    printf "%s" "${mensaje:$i:1}"
    sleep 0.03 
done
printf "%b\n\n" "$color_fin" 

rm -r /root/.wp-cli

# Cambia los permisos y el propietario en la ruta obtenida
find "$wp_config_path" -type d -exec chmod 755 {} \; 
find "$wp_config_path" -type f -exec chmod 644 {} \;

wp_config_path=$(sudo find / -name wp-config.php -exec dirname {} \; 2>/dev/null)

# Cambia al directorio de WordPress
cd "$wp_config_path" || { exit 1; }
wp theme delete twentytwentythree --allow-root > /dev/null 2>&1
wp theme delete twentytwentytwo --allow-root > /dev/null 2>&1
# Crea el archivo .htaccess con la configuración predeterminada de WordPress
echo -e '# BEGIN WordPress\n<IfModule mod_rewrite.c>\nRewriteEngine On\nRewriteBase /\nRewriteRule ^index\\.php$ - [L]\nRewriteCond %{REQUEST_FILENAME} !-f\nRewriteCond %{REQUEST_FILENAME} !-d\nRewriteRule . /index.php [L]\n</IfModule>\n# END WordPress' > "$wp_config_path/.htaccess"


chown -R www-data:www-data "$wp_config_path"



read -p "Presione Enter para continuar..."

            wordpress_menu;;
        2) 		

echo -e "\e[91mSe va a eliminar WordPress, Apache2, MySQL, PHP y Todo lo creado por WordPress, deseas continuar ? (y/n)\e[0m"
read -p "" confirm
confirm=$(echo $confirm | tr '[:upper:]' '[:lower:]')

if [[ $confirm != "y" ]]; then
    echo "Operación cancelada por el usuario."
    exit 0
fi

total_steps=9
current_step=0

show_progress() {
    echo -ne "["
    for ((i=0; i<total_steps; i++)); do
        if [[ $i -lt $current_step ]]; then
            echo -ne "\e[42m \e[0m"  # verde
        else
            echo -ne " "
        fi
    done
    echo -ne "] $((current_step * 100 / total_steps))% \r"
}

execute_command() {
    command=$1
    $command > /dev/null 2>&1
    let "current_step++"
    show_progress
}

echo "Procesando..."

execute_command "sudo systemctl stop mysql"

execute_command "sudo rm -rf /var/www"

execute_command "sudo apt purge -y mysql-server php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-mysql php-cli php-ldap php-zip php-curl php7.4 libapache2-mod-php7.4 unattended-upgrades"
execute_command "sudo apt autoremove -y"
execute_command "sudo apt autoclean -y"

execute_command "sudo dpkg --purge $(dpkg -l | grep '^rc' | awk '{print $2}')"

execute_command "sudo apt purge -y mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*"

execute_command "sudo rm -rf /etc/mysql /var/lib/mysql /var/log/mysql"

execute_command "sudo systemctl stop apache2 && sudo apt-get purge -y apache2* && sudo rm -rf /etc/apache2 && sudo rm -rf /var/lib/apache2 && sudo rm -rf /usr/lib/apache2/modules && sudo find / -iname '*apache2*' -exec rm -rf {} \\; && whereis apache2"

echo -e "\e[94mHemos terminado la limpieza, presiona enter para continuar\e[0m"
read -p ""


            wordpress_menu;;
        3) 
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
sudo find /var/www/html/ -name .htaccess | awk '{ print length, $0 }' | sort -n | cut -d' ' -f2- | head -n 1 | xargs dirname > /tmp/ZeroxRuta.txt

ruta=$(cat /tmp/ZeroxRuta.txt)

cd $ruta

if ! wp core is-installed --allow-root; then
    echo -e "${RED}No se encuentra la instalación de WordPress en $ruta${NC}"
    exit 1
fi

admins=$(wp user list --role=administrator --field=user_login --allow-root)
colabs=$(wp user list --role=editor --field=user_login --allow-root)

# Mostrar los usuarios
echo -e "${BLUE}+---------------+-------------+${NC}"
echo -e "${BLUE}| Administrador | Colaborador |${NC}"
echo -e "${BLUE}+---------------+-------------+${NC}"
paste <(echo "$admins") <(echo "$colabs") | while IFS=$'\t' read -r admin colab
do
  echo -e "| ${RED}$admin${NC} | $colab |"
done
echo -e "${BLUE}+---------------+-------------+${NC}"

while true; do
    echo -e "${GREEN}Por favor, introduce el nombre de usuario que deseas cambiar:${NC}"
    read usuario

    if wp user get $usuario --allow-root >/dev/null 2>&1; then
        break
    else
        echo -e "${RED}El usuario $usuario no existe. Por favor, intenta de nuevo.${NC}"
    fi
done

echo -e "${GREEN}Por favor, introduce la nueva contraseña para $usuario:${NC}"
read contrasena

echo -e "${GREEN}¿Estás seguro de que quieres cambiar la contraseña de $usuario? (S/s/N/n/Y/y)${NC}"
read confirmacion

confirmacion=$(echo "$confirmacion" | tr '[:upper:]' '[:lower:]')

if [ "$confirmacion" = "s" ] || [ "$confirmacion" = "y" ]; then
    wp user update $usuario --user_pass=$contrasena --allow-root >/dev/null 2>&1
    echo -e "${GREEN}La contraseña de $usuario ha sido cambiada a $contrasena${NC}"
else
    echo -e "${GREEN}Operación cancelada.${NC}"
fi


            wordpress_menu;;
        4) 
		
		
            bloquear_panel_menu;;
        5) 
		
            configurar_php_ini_menu;;
        6) 
            mysql_menu;;
        0) main_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; wordpress_menu;;
    esac
}


configurar_php_ini_menu() {
    show_banner
    echo -e "\e[34m1. Permitir Archivos grandes"  
    echo -e "2. No Permitir Archivos grandes"  
    echo -e "0. Volver al menú anterior"
    echo -e "9. Salir de Zerox\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1) 
		        
echo -e "\e[94mDesea ampliar capacidad de subida? si o no y/n\e[0m"
read respuesta
if [[ "$respuesta" =~ ^([sS][iI]|[yY])+$ ]]
then
    echo "Procesando ...."
    sudo sed -i 's/^;\?upload_max_filesize = .*/upload_max_filesize = 128M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?post_max_size = .*/post_max_size = 128M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?memory_limit = .*/memory_limit = 256M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?max_execution_time = .*/max_execution_time = 300/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?max_input_time = .*/max_input_time = 300/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?upload_max_filesize = .*/upload_max_filesize = 128M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?post_max_size = .*/post_max_size = 128M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?memory_limit = .*/memory_limit = 256M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?max_execution_time = .*/max_execution_time = 300/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
    sudo sed -i 's/^;\?max_input_time = .*/max_input_time = 300/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
    echo -e "\e[32mAhora puede subir archivos con un tamaño de 128 Mb\e[0m"
    sleep 3 
    systemctl restart apache2 > /dev/null 2>&1
    echo -e "\e[94mDesea ampliar aún más la capacidad de subida? si o no y/n\e[0m"
    read respuesta2
    if [[ "$respuesta2" =~ ^([sS][iI]|[yY])+$ ]]
    then
        echo "Procesando ...."
        sudo sed -i 's/^;\?upload_max_filesize = .*/upload_max_filesize = 500M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?post_max_size = .*/post_max_size = 500M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?memory_limit = .*/memory_limit = 1000M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?max_execution_time = .*/max_execution_time = 600/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?max_input_time = .*/max_input_time = 600/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?upload_max_filesize = .*/upload_max_filesize = 500M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?post_max_size = .*/post_max_size = 500M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?memory_limit = .*/memory_limit = 1000M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?max_execution_time = .*/max_execution_time = 600/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
        sudo sed -i 's/^;\?max_input_time = .*/max_input_time = 600/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
        echo -e "\e[32mAhora puede subir archivos con un tamaño de 500 Mb\e[0m"
        sleep 3 
        systemctl restart apache2 > /dev/null 2>&1
    fi
fi
echo "Presione enter para continuar"
read
            configurar_php_ini_menu;;
        2)
		
echo -e "\e[91mBajando capacidad de archivos... un momento por favor\e[0m"
sleep 4
sudo sed -i 's/^;\?upload_max_filesize = .*/upload_max_filesize = 2M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?post_max_size = .*/post_max_size = 2M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?memory_limit = .*/memory_limit = 8M/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?max_execution_time = .*/max_execution_time = 30/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?max_input_time = .*/max_input_time = 60/' /etc/php/7.4/apache2/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?upload_max_filesize = .*/upload_max_filesize = 2M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?post_max_size = .*/post_max_size = 2M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?memory_limit = .*/memory_limit = 8M/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?max_execution_time = .*/max_execution_time = 30/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
sudo sed -i 's/^;\?max_input_time = .*/max_input_time = 60/' /etc/php/7.4/cli/php.ini > /dev/null 2>&1
systemctl restart apache2 > /dev/null 2>&1
echo -e "\e[92mPerfecto se han cambiado los parametros a 2MB\e[0m"
echo -e "\e[94mPresione enter para continuar\e[0m"
read		
            configurar_php_ini_menu;;
        0) wordpress_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; configurar_php_ini_menu;;
    esac
}


bloquear_panel_menu() {
    show_banner
    echo -e "\e[34m1. Bloquear Panel Admin"  
    echo -e "2. Desbloquear Admin"  
    echo -e "0. Volver al menú anterior"
    echo -e "9. Salir de Zerox\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1) 
sudo find /var/www/html/ -name .htaccess | awk '{ print length, $0 }' | sort -n | cut -d' ' -f2- | head -n 1 | xargs dirname > /tmp/ZeroxRuta.txt

ruta=$(cat /tmp/ZeroxRuta.txt)

htaccess_file="${ruta}/wp-admin/.htaccess"

if [ ! -e "$htaccess_file" ]; then
    touch "$htaccess_file"
fi

if [ -e "$htaccess_file" ]; then
    > "$htaccess_file"
fi

read -p "¿Desea bloquear el acceso al panel administrativo? (y/n): " respuesta
respuesta=$(echo "$respuesta" | tr '[:upper:]' '[:lower:]')

if [ "$respuesta" == "y" ]; then
    echo "order deny,allow" > "$htaccess_file"
    echo "allow from 172.94.37.33" >> "$htaccess_file"
    echo "deny from all" >> "$htaccess_file"
    echo -n -e "\033[0;32mBloqueando Panel Admin\033[0m"
    sleep 1
    echo -n -e "\033[0;32m .\033[0m"
    sleep 1
    echo -n -e "\033[0;32m .\033[0m"
    sleep 1
    echo -n -e "\033[0;32m .\033[0m" 
    sleep 1
    echo -e "\033[0;32mPanel bloqueado\033[0m"

    read -p "Presione enter para salir"
fi       
            bloquear_panel_menu;;
        2) 

sudo find /var/www/html/ -name .htaccess | awk '{ print length, $0 }' | sort -n | cut -d' ' -f2- | head -n 1 | xargs dirname > /tmp/ZeroxRuta.txt

ruta=$(cat /tmp/ZeroxRuta.txt)
htaccess_file="${ruta}/wp-admin/.htaccess"
if [ ! -e "$htaccess_file" ]; then
    touch "$htaccess_file"
fi

if [ -e "$htaccess_file" ]; then
    > "$htaccess_file"
fi

echo -n -e "\033[0;32mProcesando\033[0m"
sleep 1
echo -n -e "\033[0;32m .\033[0m"
sleep 1
echo -n -e "\033[0;32m .\033[0m"
sleep 1
echo -n -e "\033[0;32m .\033[0m"
sleep 1
echo -e "\033[0;32mPanel desbloqueado\033[0m"

read -p "Presione enter para salir"
			bloquear_panel_menu;;
           
        0) wordpress_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; configurar_php_ini_menu;;
    esac
}

mysql_menu() {
    show_banner
    echo -e "\e[34m1. Crear Base de datos"  
    echo -e "2. Crear usuarios"  
    echo -e "3. Listar"  
    echo -e "4. Eliminar"  
    echo -e "0. Volver al menú anterior"
    echo -e "9. Salir de Zerox\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1) 
echo -e "\033[0;31mPor favor, ingresa el nombre de tu base de datos:\033[0m"
read nombre_db
while true; do
    echo -e "\033[0;94m¿Deseas crear la base de datos? (y/n)\033[0m"
    read respuesta
    respuesta=${respuesta,,}

    if [[ $respuesta =~ ^(yes|y|no|n)$ ]]; then
        break
    else
        echo "Respuesta inválida. Por favor, responde con 'y' para sí o 'n' para no."
    fi
done

if [[ $respuesta =~ ^(yes|y)$ ]]; then
    mysql -u root -e "CREATE DATABASE $nombre_db;"
    echo -e "\033[0;33mBase de datos $nombre_db creada\033[0m"
else
    echo "No se creó ninguna base de datos."
fi

echo -e "\033[0;32mPresiona enter para continuar...\033[0m"
read

            mysql_menu;;
        2) 
		
while true; do
    echo -e "\033[0;93mPor favor, ingresa el nombre de usuario que deseas crear:\033[0m" > /dev/tty
    read nombre_usuario
    if [[ -z "$nombre_usuario" ]]; then
        echo "El nombre de usuario es obligatorio." > /dev/tty
    else
        echo -e "\033[0;94m$nombre_usuario\033[0m" > /dev/tty
        break
    fi
done

while true; do
    echo -e "\033[0;35mPor favor, ingresa la contraseña para el usuario $nombre_usuario:\033[0m" > /dev/tty
    read -s contrasena_usuario
    if [[ -z "$contrasena_usuario" ]]; then
        echo "La contraseña es obligatoria." > /dev/tty
    else
        break
    fi
done

while true; do
    echo -e "\033[0;94m¿Deseas crear el usuario $nombre_usuario? (y/n)\033[0m" > /dev/tty
    read respuesta
    respuesta=${respuesta,,} 

    if [[ $respuesta =~ ^(yes|y|no|n)$ ]]; then
        break
    else
        echo "Respuesta inválida. Por favor, responde con 'y' para sí o 'n' para no." > /dev/tty
    fi
done

if [[ $respuesta =~ ^(yes|y)$ ]]; then
    mysql -u root -e "CREATE USER '$nombre_usuario'@'localhost' IDENTIFIED BY '$contrasena_usuario';"

    echo -e "\033[0;31mBases de datos vacías:\033[0m" > /dev/tty
    mapfile -t bases_de_datos < <(echo "SHOW DATABASES;" | mysql -u root | while read dbname; do
      if [[ "$dbname" != "information_schema" ]] && [[ "$dbname" != "mysql" ]] && [[ "$dbname" != "performance_schema" ]] && [[ "$dbname" != "sys" ]] && [[ "$dbname" != "Database" ]]; then
        table_list=$(echo "SHOW TABLES FROM \`$dbname\`;" | mysql -u root 2>/dev/null)
        if [[ "$table_list" == "" ]]; then
          echo "$dbname"
        fi
      fi
    done)
    for i in "${!bases_de_datos[@]}"; do
        echo -e "\033[0;94m$((i+1)). ${bases_de_datos[$i]}\033[0m" > /dev/tty
    done
 
    while true; do
        echo "Por favor, selecciona el número de la base de datos que deseas enlazar al usuario $nombre_usuario:" > /dev/tty
        read indice_db
        if [[ -z "$indice_db" || $indice_db -lt 1 || $indice_db -gt ${#bases_de_datos[@]} ]]; then
            echo "Por favor, selecciona un número válido de la lista." > /dev/tty
        else
            nombre_db=${bases_de_datos[$((indice_db-1))]}
            break
        fi
    done

    mysql -u root -e "GRANT ALL ON $nombre_db.* TO '$nombre_usuario'@'localhost';"

    echo -e "Base de datos: $nombre_db\nUsuario: $nombre_usuario\nContraseña: $contrasena_usuario" > /dev/tty
else
    echo "No se creó ningún usuario." > /dev/tty
fi

echo -e "\033[0;32mPresiona enter para continuar...\033[0m" > /dev/tty
read

            mysql_menu;;
        3) 
            listar_menu;;
        4) 
            eliminar_menu;;
        0) wordpress_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; mysql_menu;;
    esac
}

listar_menu() {
    show_banner
    echo -e "\e[34m1. Usuarios"  
    echo -e "2. Bases de DB"  
    echo -e "0. Volver al menú anterior"
    echo -e "9. Salir de Zerox\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1)    

USER_DEFAULTS=("root" "mysql.session" "mysql.sys" "mysql.infoschema" "debian-sys-maint")

printf "+------------------+-----------+\n"
printf "| %-16s | %-9s |\n" "Usuario" "Host"
printf "+------------------+-----------+\n"

mysql -u root -N -B -e "SELECT user, host FROM mysql.user;" | while read -r USER HOST; do
    if [[ ! " ${USER_DEFAULTS[@]} " =~ " ${USER} " ]]; then
        printf "| %-16s | %-9s |\n" "$USER" "$HOST"
    fi
done

printf "+------------------+-----------+\n"
read -p "Presiona Enter para salir..."
		
            listar_menu;;
        2)
		
DB_DEFAULTS=("information_schema" "performance_schema" "mysql" "sys")

printf "+---------------+----------------------+-----------------------------+\n"
printf "| %-13s | %-20s | %-27s |\n" "Base de datos" "tamaño" "Cantidad de tablas"
printf "+---------------+----------------------+-----------------------------+\n"

DBS=$(mysql -u root -e 'SHOW DATABASES;' | awk '{print $1}' | tail -n +2)
i=1
for DB in $DBS; do
    if [[ ! " ${DB_DEFAULTS[@]} " =~ " ${DB} " ]]; then
        SIZE=$(mysql -u root -N -s -e "SELECT IFNULL(ROUND(SUM(data_length + index_length) / 1024 / 1024, 2), 0.00) FROM information_schema.TABLES WHERE table_schema = '$DB';")
        
        # Obtiene el número de tablas en la base de datos
        TABLE_COUNT=$(mysql -u root -N -s -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = '$DB';")

        if [ "$SIZE" == "0.00" ] && [ "$TABLE_COUNT" == "0" ]; then
            printf "\e[37m%d. %-13s | %-20s MB | %-27s |\e[0m\n" "$i" "$DB" "$SIZE" "$TABLE_COUNT"
        else
            printf "\e[32m%d. %-13s | %-20s MB | %-27s |\e[0m\n" "$i" "$DB" "$SIZE" "$TABLE_COUNT"
        fi
        i=$((i+1))
    fi
done

printf "+---------------+----------------------+-----------------------------+\n"
read -p "Presiona Enter para salir..."

            listar_menu;;
        0) mysql_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; listar_menu;;
    esac
}


eliminar_menu() {
    while true; do
        show_banner
        echo -e "\e[34m1. Usuario"  
        echo -e "\e[34m2. Base de Datos"  
        echo -e "\e[34m0. Volver al menú anterior"
        echo -e "\e[34m9. Salir de Zerox\e[0m"
        echo -e "\e[97mSeleccione una opción:\e[0m"
        read opcion
        case $opcion in
           1) 
		   
	   

GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

eliminar_usuario_menu() {
    while true; do
        echo -e "${GREEN}Enumerando todos los usuarios de MySQL:${NC}"
        users=$(mysql -u root -e "SELECT User FROM mysql.user WHERE User NOT IN ('mysql.infoschema', 'mysql.session', 'mysql.sys', 'debian-sys-maint', 'root');" | tail -n +2)
        i=1
        for user in $users
        do
            echo -e "${GREEN}${i})${NC} ${BLUE}${user}${NC}"
            i=$((i+1))
        done
        echo -e "${GREEN}0)${NC} Salir"
        read -p "Por favor, selecciona un usuario para eliminar: " selection
        if [ "$selection" == "0" ]; then
            break
        elif [ "$selection" -gt 0 ] && [ "$selection" -lt "$i" ]; then
            user=$(echo $users | cut -d ' ' -f $selection)
            echo -e "Has seleccionado el usuario ${BLUE}$user${NC} para eliminar."
            read -p "¿Estás seguro de que quieres eliminar este usuario? (y/n): " confirm
            confirm=$(echo $confirm | tr '[:upper:]' '[:lower:]')
            if [ "$confirm" == "y" ]; then
                mysql -u root -e "DROP USER '$user'@'localhost';"
                echo "El usuario $user ha sido eliminado."
            fi
        else
            echo "Selección inválida."
        fi
        read -p "¿Deseas eliminar otro usuario? (y/n): " another
        another=$(echo $another | tr '[:upper:]' '[:lower:]')
        if [ "$another" != "y" ]; then
            break
        fi
    done
}
                eliminar_usuario_menu;;
            2)
			
			
			eliminar_base_datos_menu() {
    while true; do
        echo -e "${GREEN}Enumerando todas las bases de datos de MySQL:${NC}"
        databases=$(mysql -u root -e "SHOW DATABASES WHERE \`Database\` NOT IN ('information_schema', 'mysql', 'performance_schema', 'sys');" | tail -n +2)
        i=1
        for db in $databases
        do
            echo -e "${GREEN}${i})${NC} ${BLUE}${db}${NC}"
            i=$((i+1))
        done
        echo -e "${GREEN}0)${NC} Salir"
        read -p "Por favor, selecciona una base de datos para eliminar: " selection
        if [ "$selection" == "0" ]; then
            break
        elif [ "$selection" -gt 0 ] && [ "$selection" -lt "$i" ]; then
            db=$(echo $databases | cut -d ' ' -f $selection)
            echo -e "Has seleccionado la base de datos ${BLUE}$db${NC} para eliminar."
            read -p "¿Estás seguro de que quieres eliminar esta base de datos? (y/n): " confirm
            confirm=$(echo $confirm | tr '[:upper:]' '[:lower:]')
            if [ "$confirm" == "y" ]; then
                mysql -u root -e "DROP DATABASE $db;"
                echo "La base de datos $db ha sido eliminada."
            fi
        else
            echo "Selección inválida."
        fi
        read -p "¿Deseas eliminar otra base de datos? (y/n): " another
        another=$(echo $another | tr '[:upper:]' '[:lower:]')
        if [ "$another" != "y" ]; then
            break
        fi
    done
}

                eliminar_base_datos_menu;;
            0) mysql_menu;;
            9) show_goodbye; exit;;
            *) echo "Opción inválida";;
        esac
    done
}




respaldo_archivos_menu() {
    show_banner
    echo -e "\e[34m1. Respaldos"
    echo -e "0. Volver al menú anterior"
    echo -e "9. Salir de Zerox\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
        1) 
	
            respaldo_menu;;
        
        0) main_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; respaldo_archivos_menu;;
    esac
}

respaldo_menu() {
    show_banner
    echo -e "\e[34m1. Bases"
    echo -e "2. Archivos WP"
    echo -e "3. Ruta"
    echo -e "0. Volver al menú anterior"
    echo -e "9. Salir de Zerox\e[0m"
    echo -e "\e[97mSeleccione una opción:\e[0m"
    read opcion
    case $opcion in
	
	
        1) 
		
respaldo_bases_datos_menu() {
    while true; do
	
	clear_menu() {
    tput cup 10 0
    tput ed
}
        clear_menu

        databases=$(mysql -u root -e "SHOW DATABASES;" | tr -d "| " | grep -v -e Database -e mysql -e information_schema -e performance_schema -e sys)

        echo -e "\n\n\033[92mSelecciona una base de datos para hacer un respaldo:\033[0m"
        i=1
        for db in $databases; do
            echo -e "\033[92m$i) $db\033[0m"
            i=$((i+1))
        done
        echo -e "\033[34m0) Volver\033[0m"

        read -p "Introduce un número: " REPLY

        if [[ ! $REPLY =~ ^[0-9]+$ ]]; then
            echo -e "\033[34mPor favor, introduce un número válido.\033[0m"
            continue
        fi

        if [ "$REPLY" -eq "0" ]; then
            echo -e "\033[34mHas seleccionado volver al menú principal...\033[0m"
            respaldo_archivos_menu  
        elif [ "$REPLY" -gt "0" ] && [ "$REPLY" -le "$i" ]; then
            db="$(echo $databases | cut -d ' ' -f$REPLY)"
            if mysql -u root -e "USE $db;" 2>/dev/null; then
                # Directorio de respaldos
                backup_dir="/var/www/respaldos/Bases_de_Datos/"

                mysqldump -u root $db > "${backup_dir}${db}-$(date +%d-%m-%Y)-Hora-$(date +%I-%M-%S%p).sql"

                num_backups=$(ls -t "${backup_dir}" | wc -l)
                if [ $num_backups -gt 4 ]; then
                    oldest_backup=$(ls -t "${backup_dir}" | tail -1)
                    rm "${backup_dir}${oldest_backup}"
                fi

                echo -e "\033[34mLa base de datos ${db} ha sido respaldada.\033[0m"

                echo -e "\033[34mEl archivo de respaldo se ha guardado en: ${backup_dir}${db}-$(date +%d-%m-%Y)-Hora-$(date +%I-%M-%S%p).sql\033[0m"
            else
                echo -e "\033[34mLa base de datos seleccionada no existe. Por favor, intenta de nuevo.\033[0m"
            fi
        else
            echo -e "\033[34mLa opción seleccionada no es válida. Por favor, selecciona una opción válida.\033[0m"
        fi
        echo -e "\033[92mPresiona enter para continuar...\033[0m"
        read
    done
}

mkdir -p /var/www/respaldos/Bases_de_Datos/

		    respaldo_bases_datos_menu; respaldo_archivos_menu;;
        2) 
		
		


if ! command -v zip &> /dev/null; then
    echo "Instalando zip..."
    sudo apt-get install zip -y &>/dev/null
fi

backup_path_files="/var/www/respaldos/Archivos/"

mkdir -p "$backup_path_files"

current_time=$(date +%d-%m-%Y-Hora-%H-%M-%S)

backup_file_files="${backup_path_files}backup-${current_time}.zip"

ruta=$(cat /tmp/ZeroxRuta.txt)

if [ ! -d "$ruta" ]; then
    echo "La ruta especificada no existe."
    exit 1
fi

echo "Iniciando respaldo de los archivos..."
total_files=$(find "$ruta" -type f | wc -l)
current_file=0

find "$ruta" -type f -print0 | while IFS= read -r -d '' file; do
    zip -urq "$backup_file_files" "$file"
    current_file=$((current_file + 1))
    percent=$((current_file * 100 / total_files))
    echo -ne "\033[32mUn momento... $percent%\033[0m\r"
done

echo -e "\n\033[32;1mEl respaldo de los archivos ha sido generado exitosamente en:\033[0m"
echo -e "\033[32;1m$backup_file_files\033[0m"

cd "$backup_path_files" || exit
ls -t | grep 'backup-' | tail -n +4 | xargs -r rm --

echo -e "\033[32mRespaldo completado. Presiona enter para continuar...\033[0m"
read -r  


            respaldo_menu; respaldo_archivos_menu;;
        3) 



if ! command -v zip &> /dev/null; then
    echo "Instalando zip..."
    sudo apt-get install zip -y &>/dev/null
fi

get_user_response() {
    read -rp $'\e[96m¿Desea respaldar la carpeta? (y/n):\e[0m ' response
    case "$response" in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo "Por favor, responda con 'y' o 'n'."; get_user_response;;
    esac
}

get_user_response

if [ $? -eq 0 ]; then
    echo "Por favor, ingresa la ruta que deseas respaldar:"
    read -r ruta

    backup_path_files="/var/www/respaldos/Rutas/"

    mkdir -p "$backup_path_files"

    current_time=$(date +%d-%m-%Y-Hora-%H-%M-%S)

    backup_file_files="${backup_path_files}backup-${current_time}.zip"

    if [ ! -d "$ruta" ]; then
        echo "La ruta especificada no existe."
        exit 1
    fi

    echo "Iniciando respaldo de los archivos..."
    total_files=$(find "$ruta" -type f | wc -l)
    current_file=0

    find "$ruta" -type f -print0 | while IFS= read -r -d '' file; do
        zip -urq "$backup_file_files" "$file"
        current_file=$((current_file + 1))
        percent=$((current_file * 100 / total_files))
        echo -ne "\033[32mUn momento... $percent%\033[0m\r"
    done

    echo -e "\n\033[32;1mEl respaldo de los archivos ha sido generado exitosamente en:\033[0m"
    echo -e "\033[32;1m$backup_file_files\033[0m"

    cd "$backup_path_files" || exit
    ls -t | grep 'backup-' | tail -n +4 | xargs -r rm --

    echo -e "\033[32mRespaldo completado. Presiona enter para continuar...\033[0m"
    read -s -n 1
else
    echo "No se ha realizado el respaldo."
fi

		
            respaldo_menu; respaldo_archivos_menu;;
			
        0) respaldo_archivos_menu;;
        9) show_goodbye; exit;;
        *) echo "Opción inválida"; respaldo_menu; respaldo_archivos_menu;;
    esac
}

main_menu
