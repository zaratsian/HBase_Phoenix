
#################################################################################
#
#  Query 2 - Check for uncrossed market within the 30 sec before order receipt
#
#  Usage:
#      ./zquery2.sh <Symbol> <mktOpenDtm> <RefDateTime>
#      ./zquery2.sh "AAPL" "2017-05-01 09:30:00.000" "2017-05-01 09:31:00.000"
#################################################################################

Symbol=$1       # "AAPL"
mktOpenDtm=$2   # "2017-05-01 09:30:00.000"
RefDateTime=$3  # "2017-05-01 09:31:00.000"

secs=$(date +%s --date="$RefDateTime")
date_minus_30sec=$(date '+%Y-%m-%d %H:%M:%S.%3N' --date="@$((secs - 30))")

echo "select
    SOURCE_DATETIME as uncrossTime
    from MktData
    where SECURITY_SYMBOL = '$Symbol'
        and SOURCE_DATETIME >= TO_TIME('$date_minus_30sec')
        and SOURCE_DATETIME <  TO_TIME('$RefDateTime')
        and (BID_PRICE <= ASK_PRICE or BID_PRICE = 0.0 or ASK_PRICE = 0.0)
    ORDER BY SOURCE_DATETIME desc, MSG_SEQ_NBR desc
    limit 1;" > phoenixquery2.sql

python /usr/hdp/2.6.1.0-129/phoenix/bin/sqlline.py biren-hbase0.field.hortonworks.com,biren-hbase1.field.hortonworks.com,biren-hbase2.field.hortonworks.com:2181:/hbase-unsecure phoenixquery2.sql
