
#################################################################################
#
#  Query 3 - Get avg bid and ask qty in a 5 second window
#
#  Usage:
#      ./zquery3.sh <Symbol> <mktOpenDtm> <RefDateTime>
#      ./zquery3.sh "AAPL" "2017-05-01 09:30:00.000" "2017-05-01 09:31:00.000"
#################################################################################

Symbol=$1       # "AAPL"
mktOpenDtm=$2   # "2017-05-01 09:30:00.000"
RefDateTime=$3  # "2017-05-01 09:31:00.000"

secs=$(date +%s --date="$RefDateTime")
date_minus_30sec=$(date '+%Y-%m-%d %H:%M:%S.%3N' --date="@$((secs - 30))")

echo "select
    ISNULL(AVG(cast(BID_LOT_QTY as bigint)),0) as WindowAvgBidQty,
    ISNULL(AVG(cast(ASK_LOT_QTY as bigint)),0) as WindowAvgAskQty
    from MktData
    where SECURITY_SYMBOL = '$Symbol'
        and SOURCE_DATETIME >= '$WindowTimeBegin'
        and SOURCE_DATETIME < '$WindowTimeEnd'
    limit 1;" > phoenixquery3.sql

python /usr/hdp/2.6.1.0-129/phoenix/bin/sqlline.py biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181:/hbase-unsecure phoenixquery3.sql
