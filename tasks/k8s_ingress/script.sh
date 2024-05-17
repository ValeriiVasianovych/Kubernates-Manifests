#!/bin/bash

# Update and upgrade packages
apt-get update -y
apt-get install -y curl 

PRIVATE_IP=$(hostname -I | awk '{print $1}')
PUBLIC_IP=$(curl -s ifconfig.me)

# Create index.html file
cat <<EOF > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html lang="en">
   <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Amazon EKS</title>
      <style>
         body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #ba6af0, #911919);
            color: white;
            text-align: center;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
         }

         h1 {
            font-size: 2.2em;
            margin-bottom: 20px;
         }

         p {
            font-size: 1.2em;
            margin-bottom: 20px;
         }

         .ip {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
         }

         p span {
            font-weight: bold;
         }
      </style>
   </head>
   <body>
      <h1>Amazon EKS Deployment #2</h1>
      <p><span>This is Nginx Ingress Controller example with HPA and Service</span></p>
      <div class="ip">
         <p><span>Public IP:</span> $PUBLIC_IP</p>
         <p><span>Private IP:</span> $PRIVATE_IP</p>
      </div>
   </body>
</html>
EOF

# Start and enable nginx service
service nginx -t
nginx -g 'daemon off;'
