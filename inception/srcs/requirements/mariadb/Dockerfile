FROM debian:latest

# Copy initialization scripts
RUN apt update && apt upgrade && apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY script.sh .

RUN mkdir /run/mysql \
chown mysql:mysql /run/mysqld \
&& chmod +x script.sh

# CMD ["mysqld_safe"]

CMD ["./script.sh", "mysqld_safe", "-f"]