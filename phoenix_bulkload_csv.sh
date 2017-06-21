
echo "CREATE TABLE if not exists ZORDERLOOKUPS (
    OID INTEGER NOT NULL,
    SYM CHAR(4),
    ODT TIMESTAMP,
    CONSTRAINT PK PRIMARY KEY (OID))
    DATA_BLOCK_ENCODING='FAST_DIFF',
    IMMUTABLE_ROWS=true,
    DISABLE_WAL=true,
    SALT_BUCKETS=10;" > create_table_orderlookups.sql

/usr/hdp/2.6.1.0-129/phoenix/bin/psql.py -d '~' -t ZORDERLOOKUPS  biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181 create_table_orderlookups.sql /root/data/OrderLookups.csv


echo "CREATE TABLE if not exists ZMKTDATA (
    FEED                    VARCHAR(6),
    FEED_NAME               VARCHAR(10),
    MSG_SEQ_NBR             UNSIGNED_INT,
    SECURITY_SYM            CHAR(4)         NOT NULL,
    LVL1_QT_MSG_TYPE        CHAR(1),
    BID_PRICE               DECIMAL(19,8),
    BID_LOT_QTY             UNSIGNED_INT,
    BID_MKT_CTR_CD          CHAR(1),
    ASK_PRICE               DECIMAL(19,8),
    ASK_LOT_QTY             UNSIGNED_INT,
    ASK_MKT_CTR_CD          CHAR(1),
    LVL1_QT_COND_CD         CHAR(1),
    SRT_SALE_BID_CD         CHAR(1),
    CURRENCY_CD             VARCHAR(3),
    OTCBB_TYPE              CHAR(1),
    LVL1_ORIG_MKT_CD        CHAR(1),
    MKT_SESSION_CD          CHAR(1),
    SOURCE_DATE             DATE,
    SOURCE_DATETIME         TIMESTAMP       NOT NULL,
    LULD_NBBO               CHAR(1),
    CONSTRAINT pk PRIMARY KEY (SECURITY_SYM,SOURCE_DATETIME))
    DATA_BLOCK_ENCODING='FAST_DIFF',
    IMMUTABLE_ROWS=true,
    DISABLE_WAL=true,
    SALT_BUCKETS=10;" > create_table_mktdata.sql

/usr/hdp/2.6.1.0-129/phoenix/bin/psql.py -d '~' -t ZMKTDATA  biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181 create_table_mktdata.sql /root/data/MktData.csv

#ZEND
