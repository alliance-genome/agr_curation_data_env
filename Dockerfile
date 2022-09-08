FROM amazon/aws-cli

WORKDIR /setup

RUN aws s3api list-objects-v2 --bucket "agr-db-backups" --query 'reverse(sort_by(Contents[?contains(Key, `curation/production/production-curation-`)], &LastModified))[:1].Key' --output=text 


#FROM postgres
#ENV POSTGRES_PASSWORD postgres
#ENV POSTGRES_DB curation
#COPY data.dump /docker-entrypoint-initdb.d/
#RUN pg_restore -f /docker-entrypoint-initdb.d/data.sql /docker-entrypoint-initdb.d/data.dump; rm /docker-entrypoint-initdb.d/data.dump

# aws s3 cp s3://agr-db-backups/`aws s3api list-objects-v2 --bucket "agr-db-backups" --query 'reverse(sort_by(Contents[?contains(Key, \`curation/production/production-curation-\`)], &LastModified))[:1].Key' --output=text` ./data.dump
#

#docker run --rm -it amazon/aws-cli s3api list-objects-v2 --bucket "agr-db-backups" --query 'reverse(sort_by(Contents[?contains(Key, `curation/production/production-curation-`)], &LastModified))[:1].Key' --output=text
