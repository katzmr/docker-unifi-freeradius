FROM freeradius/freeradius-server:latest

RUN apt-get update && apt-get install -y libmysqlclient-dev gettext && rm -rf /var/lib/apt/lists/*

COPY clients.conf.template /etc/freeradius/clients.conf.template
COPY update_certificates.sh /update_certificates.sh
COPY mods-available/sql.template /etc/freeradius/mods-available/sql.template
COPY certs/server.cnf /etc/freeradius/certs/server.cnf
COPY certs/client.cnf /etc/freeradius/certs/client.cnf
COPY certs/ca.cnf /etc/freeradius/certs/ca.cnf
COPY wait_for_db.sh /wait_for_db.sh
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /wait_for_db.sh /entrypoint.sh
RUN chmod +x /update_certificates.sh
RUN /update_certificates.sh

CMD ["/entrypoint.sh"]