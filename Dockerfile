FROM amazon/aws-cli AS AWS

WORKDIR /setup

#RUN aws s3 cp s3://agr-db-backups/`aws s3api list-objects-v2 --bucket "agr-db-backups" --query 'reverse(sort_by(Contents[?contains(Key, \`curation/production/\`)], &LastModified))[:1].Key' --output=text` data.dump
RUN aws s3 cp s3://agr-db-backups/`aws s3 ls agr-db-backups --recursive | sort | tail -n 1 | awk '{print $4}'` data.dump

FROM postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB curation

RUN apt-get update && apt-get install pigz

COPY --from=AWS /setup/data.dump /docker-entrypoint-initdb.d/data.dump
RUN echo 'fsync = off' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'synchronous_commit = off' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'max_wal_size = 32768' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'min_wal_size = 8192' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'log_checkpoints = off' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'checkpoint_timeout = 60min' >> /usr/share/postgresql/postgresql.conf.sample
RUN echo 'checkpoint_completion_target = 0.85' >> /usr/share/postgresql/postgresql.conf.sample

RUN pg_restore -f /docker-entrypoint-initdb.d/data.sql /docker-entrypoint-initdb.d/data.dump && rm /docker-entrypoint-initdb.d/data.dump && pigz /docker-entrypoint-initdb.d/data.sql
