FROM freeradius/freeradius-server:latest

RUN apt-get update && apt-get install -y libmysqlclient-dev gettext && rm -rf /var/lib/apt/lists/*

COPY mods-available/sql /etc/freeradius/mods-available/sql
COPY clients.conf /etc/freeradius/clients.conf
COPY wait_for_db.sh /wait_for_db.sh
RUN chmod +x /wait_for_db.sh

RUN envsubst < /etc/freeradius/clients.conf > /etc/freeradius/clients.conf
RUN envsubst < /etc/freeradius/mods-available/sql > /etc/freeradius/mods-available/sql

RUN ln -s /etc/freeradius/mods-available/sql /etc/freeradius/mods-enabled/sql

CMD ["/wait_for_db.sh", "mysql:3306", "--", "freeradius", "-X"]