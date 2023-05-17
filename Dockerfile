FROM postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB curation
ENV PGDATA /pgdata

RUN mkdir -p "$PGDATA" && chown -R postgres:postgres "$PGDATA" && chmod 777 "$PGDATA"

RUN echo 'fsync = off' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'synchronous_commit = off' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'max_wal_size = 32768' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'min_wal_size = 8192' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'log_checkpoints = off' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'checkpoint_timeout = 60min' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'checkpoint_completion_target = 0.85' >> /usr/share/postgresql/postgresql.conf.sample
