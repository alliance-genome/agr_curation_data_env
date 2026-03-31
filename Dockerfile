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

RUN echo 'shared_buffers = 16GB' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'effective_cache_size = 48GB' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'work_mem = 64MB' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'maintenance_work_mem = 2GB' >> /usr/share/postgresql/postgresql.conf.sample

RUN echo 'random_page_cost = 1.1' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'effective_io_concurrency = 200' >> /usr/share/postgresql/postgresql.conf.sample

RUN echo 'max_parallel_workers_per_gather = 4' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'max_parallel_workers = 8' >> /usr/share/postgresql/postgresql.conf.sample

RUN echo 'wal_buffers = 64MB' >> /usr/share/postgresql/postgresql.conf.sample
