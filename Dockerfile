FROM shawoo/postgres:11-repmgr

USER root
RUN buildDependencies="build-essential \
    ca-certificates \
    curl \
    git-core \
    python \
    gpp \
    cpp \
    pkg-config \
    apt-transport-https \
    cmake \
    libc++-dev \
    postgresql-server-dev-11" \
    runtimeDependencies="libc++1" \
  && apt-get update \
  && apt-get install -y --no-install-recommends ${buildDependencies} ${runtimeDependencies}
  
RUN mkdir -p /tmp/build

WORKDIR /tmp/build
RUN git clone https://github.com/enterprisedb/mysql_fdw.git
RUN cd www_fdw \
  && export USE_PGXS=1 \
  && make && make install
  
WORKDIR /tmp/build
RUN git clone https://github.com/cyga/www_fdw.git
RUN cd www_fdw \
  && export USE_PGXS=1 \
  && make && make install
# psql -c "CREATE EXTENSION mysql_fdw" db

# CREATE SERVER mysql_server FOREIGN DATA WRAPPER mysql_fdw OPTIONS (host 'xx.xxx.xx.xxx’, port ‘xxxx’);

# CREATE USER MAPPING  FOR “postgres username”
# SERVER “Give your foreign server a name” 
# OPTIONS (username 'type mysql username', password 'type mysql password’);

# CREATE FOREIGN TABLE “table name”(id smallint,advert_id smallint, created_at timestamp)
# SERVER mysql_server OPTIONS (dbname 'remote mysql db name, table_name 'mysql table name');

RUN rm -rf /root/.vpython_cipd_cache /root/.vpython-root \
  && apt-get clean \
  && apt-get remove -y ${buildDependencies} \
  && apt-get autoremove -y \
  && rm -rf /tmp/build /var/lib/apt/lists/*
# psql -c "CREATE EXTENSION www_fdw" db
