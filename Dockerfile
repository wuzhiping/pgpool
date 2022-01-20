FROM shawoo/postgres:11-repmgr

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
    postgresql-server-dev-$PG_MAJOR" \
    runtimeDependencies="libc++1" \
  && apt-get update \
  && apt-get install -y --no-install-recommends ${buildDependencies} ${runtimeDependencies}
  
RUN mkdir -p /tmp/build
WORKDIR /tmp/build
RUN git clone https://github.com/cyga/www_fdw.git
RUN cd www_fdw \
  && export USE_PGXS=1 \
  && make && make install

RUN rm -rf /root/.vpython_cipd_cache /root/.vpython-root \
  && apt-get clean \
  && apt-get remove -y ${buildDependencies} \
  && apt-get autoremove -y \
  && rm -rf /tmp/build /var/lib/apt/lists/*
# psql -c "CREATE EXTENSION www_fdw" db
