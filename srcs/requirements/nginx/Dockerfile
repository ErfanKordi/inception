FROM debian:latest

# Install Nginx and OpenSSL
RUN apt-get update \
    && apt-get install -y nginx && apt-get install -y openssl
COPY default /etc/nginx/sites-available/.

# Set up TLS
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/nginx/ekordi.key \
-out /etc/nginx/ekordi.crt \
-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42/OU=Student/CN=ekordi/emailAddress=ekordi@student.42heilbronn.de"
EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]
