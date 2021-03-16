#!/bin/sh -e

psql --variable=ON_ERROR_STOP=1 --username "customersvc" <<-EOSQL
    DO
    $do$
    BEGIN
       IF NOT EXISTS (
          SELECT                       -- SELECT list can stay empty for this
          FROM   pg_catalog.pg_roles
          WHERE  rolname = 'postgres') THEN
          CREATE ROLE my_user LOGIN PASSWORD 'postgres';
       END IF;
       
#       CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres';
       CREATE DATABASE "customersvc" OWNER = postgres;
       GRANT ALL PRIVILEGES ON DATABASE "customersvc" TO postgres;
    END
    $do$;
EOSQL