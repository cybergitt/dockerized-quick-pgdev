-- schema.sql
-- Since we might run the import many times we'll drop if exists
-- DROP DATABASE IF EXISTS customersvc;

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
END
$do$;

CREATE DATABASE customersvc OWNER = postgres;
GRANT ALL PRIVILEGES ON DATABASE customersvc TO postgres;
-- CREATE DATABASE customersvc;

-- Make sure we're using our `customersvc` database
\c customersvc;

-- We can create our request_logs table
CREATE TABLE IF NOT EXISTS request_logs (
  request_id VARCHAR ( 64 ) PRIMARY KEY,
  client_id VARCHAR ( 250 ),
  trace_no VARCHAR ( 50 ),
  reff_no VARCHAR ( 100 ),
  source_ip VARCHAR ( 50 ),
  request_method VARCHAR ( 10 ) NOT NULL,
  request_uri VARCHAR ( 1024 ) NOT NULL,
  request_date TIMESTAMP NOT NULL,
  request_headers TEXT,
  request_body TEXT,
  response_status VARCHAR ( 5 ),
  response_date TIMESTAMP,
  response_headers TEXT,
  response_body TEXT,
  created_by INT4,
  created_date TIMESTAMP,
  last_modified_by INT4,
  last_modified_date TIMESTAMP,
  version INT4 NOT NULL
);

-- We can create our request_reff_logs table
CREATE TABLE IF NOT EXISTS request_reff_logs (
  request_id VARCHAR ( 64 ) PRIMARY KEY,
  client_id VARCHAR ( 250 ) NOT NULL,
  reff_no VARCHAR ( 50 ) NOT NULL,
  request_type VARCHAR ( 250 ) NOT NULL,
  status VARCHAR ( 50 ) NOT NULL,
  errors TEXT,
  customer_no VARCHAR ( 100 ),
  account_no VARCHAR ( 100 ),
  reference_no VARCHAR ( 100 ),
  deposit_amount NUMERIC,
  due_date DATE,
  interest_rate NUMERIC,
  created_by INT4,
  created_date TIMESTAMP,
  last_modified_by INT4,
  last_modified_date TIMESTAMP,
  version INT4 NOT NULL
);