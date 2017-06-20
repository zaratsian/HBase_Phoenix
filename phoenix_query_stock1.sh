#################################################################################
#
#  Query 1 - Find nearest prior quote within market hours
#
#  Usage:
#      ./zquery1.sh <Symbol> <mktOpenDtm> <RefDateTime>
#      ./zquery1.sh "AAPL" "2017-05-01 09:30:00.000" "2017-05-01 09:31:00.000"
#################################################################################

Symbol=$1       # "AAPL"
mktOpenDtm=$2   # "2017-05-01 09:30:00.000"
RefDateTime=$3  # "2017-05-01 09:31:00.000"

echo "select
    BID_PRICE as BidPrice,
    BID_LOT_QTY as BidQty,
    ASK_PRICE as AskPrice,
    ASK_LOT_QTY as AskQty,
    SOURCE_DATETIME as QuoteTime,
    FEED_NAME as Feed,
    MSG_SEQ_NBR as SeqNum
    from MktData
    where SECURITY_SYMBOL ='$Symbol'
        and SOURCE_DATETIME >= TO_TIME('2017-05-01 09:30:00.000')
        and SOURCE_DATETIME <  TO_TIME('2017-05-01 09:31:00.000')
    order by SOURCE_DATETIME desc, MSG_SEQ_NBR desc
    limit 1;""" > phoenixquery1.sql

python /usr/hdp/2.6.1.0-129/phoenix/bin/sqlline.py biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181:/hbase-unsecure phoenixquery1.sql
