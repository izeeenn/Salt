
    server {
        listen 443 ssl;
        listen [::]:443 ssl;
        ssl_certificate /etc/ssl/certs/blaus123.com.crt;
        ssl_certificate_key /etc/ssl/private/blaus123.com.key;
        include snippets/ssl-params.conf;

        root /var/www/blaus123.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name blaus123.com www.blaus123.com;

        location / {
                try_files $uri $uri/ =404;
        }
    }
    server {
        listen 80;
        listen [::]:80;

        server_name blaus123.com www.blaus123.com;

        return 302 https://$server_name$request_uri;
    }
