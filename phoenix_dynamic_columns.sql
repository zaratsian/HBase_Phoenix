
####################################################################
#
#  Phoenix Dynamic Columns
#  https://phoenix.apache.org/dynamic_columns.html
#
####################################################################

###############################################
#  Create Phoenix Table
###############################################

CREATE TABLE IF NOT EXISTS MYTABLE (
  ID VARCHAR NOT NULL,
  NAME VARCHAR
  CONSTRAINT mypk PRIMARY KEY (ID))
SALT_BUCKETS = 1;

###############################################
#  Upsert Records
###############################################

UPSERT INTO MYTABLE VALUES ('111','NAME1');

###############################################
#  Upsert Records (with dynamic column: STATE)
###############################################

UPSERT INTO MYTABLE (STATE VARCHAR) VALUES ('222','NAME2','NC');
UPSERT INTO MYTABLE (STATE VARCHAR) VALUES ('333','NAME3','CA');

###############################################
#  Select from table, filtering by STATE
###############################################

SELECT ID, NAME, STATE FROM MYTABLE(STATE VARCHAR) WHERE STATE = 'NC';

#ZEND
