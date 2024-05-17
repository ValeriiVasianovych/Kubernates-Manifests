#!/bin/bash

# Update and upgrade packages
apt-get update -y
apt-get install -y curl 

# Private IP
#TOKEN_PRI=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
#PRIVATE_IP=$(curl -sS -H "X-aws-ec2-metadata-token: $TOKEN_PRI" http://169.254.169.254/latest/meta-data/local-ipv4)

# Public IP
#TOKEN_PUB=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
#PUBLIC_IP=$(curl -sS -H "X-aws-ec2-metadata-token: $TOKEN_PUB" http://169.254.169.254/latest/meta-data/public-ipv4)


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
            background: linear-gradient(135deg, #2f74c0, #00bfb3);
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
      <h1>Amazon EKS Nginx POD</h1>
      <p><span>It is an example of a Nginx Deployment with Service and Horizontal Pod AutoScaler.</span></p>
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
