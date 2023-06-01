# pgpool
mkdir pg0

chmod +777 pg0

Todos:
   * CRUD for Axelor
   * pg_dump
   ** pg_dump --file axelor.2022-01-20 --username axelor --verbose --format=t --blobs axelor
   * pg_restore
   ** pg_restore --username axelor --dbname axelor --verbose axelor.2022-01-20
   
<pre>
# to be test
pg_dump --file noco.sql --host "10.17.1.22" --port "5555"  --username axelor --verbose  axelor -c  noco
psql -U postgres -d noco <noco.sql
</pre>


psql -U postgres -d axelor

CREATE EXTENSION IF NOT EXISTS unaccent;

 * \l
 * \connect foo;
 * CREATE SCHEMA yourschema;
 * \dn
# docker build -t shawoo/postgres:11-fdw .

