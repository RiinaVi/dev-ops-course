yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm


yum -y install postgresql14-server

/usr/pgsql-14/bin/postgresql-14-setup initdb

sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /var/lib/pgsql/14/data/postgresql.conf
sudo echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /var/lib/pgsql/14/data/pg_hba.conf

systemctl start postgresql-14
systemctl enable postgresql-14
systemctl status postgresql-14

sudo -u postgres psql -c "CREATE ROLE dev LOGIN PASSWORD 'secret' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=dev dev 

sudo firewall-cmd --zone=public --add-port=5432/tcp --permanent
sudo firewall-cmd --reload