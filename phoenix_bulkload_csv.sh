
echo "CREATE TABLE if not exists ZORDERLOOKUPS (
    ORDERID INTEGER NOT NULL,
    SYMBOL CHAR(4),
    ORDERDATETIME TIMESTAMP,
    CONSTRAINT PK PRIMARY KEY (ORDERID))
    DATA_BLOCK_ENCODING='FAST_DIFF',
    IMMUTABLE_ROWS=true,
    DISABLE_WAL=true,
    SALT_BUCKETS=10;" > create_table_orderlookups.sql

/usr/hdp/2.6.1.0-129/phoenix/bin/psql.py -d '~' -t ZORDERLOOKUPS  biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181 create_table_orderlookups.sql /root/data/OrderLookups.csv


echo "CREATE TABLE if not exists ZMKTDATA (
    FEED                    VARCHAR(6),
    FEED_NAME               VARCHAR(10),
    MSG_SEQ_NBR             UNSIGNED_INT,
    SECURITY_SYMBOL         CHAR(4)         NOT NULL,
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
    CONSTRAINT pk PRIMARY KEY (SECURITY_SYMBOL,SOURCE_DATETIME))
    DATA_BLOCK_ENCODING='FAST_DIFF',
    IMMUTABLE_ROWS=true,
    DISABLE_WAL=true,
    SALT_BUCKETS=10;" > create_table_mktdata.sql

/usr/hdp/2.6.1.0-129/phoenix/bin/psql.py -d '~' -t ZMKTDATA  biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181 create_table_mktdata.sql /root/data/MktData.csv


echo "CREATE TABLE if not exists ZLOOKUPS (
    ORDERID             INTEGER         NOT NULL,
    SYMBOL              CHAR(4),
    ORDERDATETIME       TIMESTAMP,      
    ASKPRICE            DECIMAL(17,6),    
    ASKQTY              UNSIGNED_INT,
    BIDPRICE            DECIMAL(17,6),    
    BIDQTY              UNSIGNED_INT,
    QUOTETIME           TIMESTAMP, 
    FEED                VARCHAR(10),      
    SEQNUM              UNSIGNED_INT,
    WINDOWAVGASKQTY     UNSIGNED_INT,
    WINDOWAVGBIDQTY     UNSIGNED_INT,
    WINDOWTIMEBEGIN     TIMESTAMP,
    WindowTimeEnd       TIMESTAMP,
    Crossed30Plus       CHAR(1),       
    microsec1           BIGINT,         
    microsec2           BIGINT,          
    microsec3           BIGINT,          
    CONSTRAINT pk PRIMARY KEY (ORDERID))
    DATA_BLOCK_ENCODING='FAST_DIFF',
    IMMUTABLE_ROWS=true,
    DISABLE_WAL=true,
    SALT_BUCKETS=10;" > create_table_lookups.sql

/usr/hdp/2.6.1.0-129/phoenix/bin/psql.py biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181 create_table_lookups.sql


#ZEND
