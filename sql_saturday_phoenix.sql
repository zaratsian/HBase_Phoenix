
!tables

###############################################################################################################
#
#   Phoenix - Load Data
#
###############################################################################################################

CREATE TABLE IF NOT EXISTS mm_season
    (id VARCHAR, season VARCHAR, day VARCHAR, wteam VARCHAR, wscore INTEGER, lteam VARCHAR, lscore INTEGER, wloc VARCHAR, ot VARCHAR
    CONSTRAINT mypk PRIMARY KEY (id))
    SALT_BUCKETS = 1;

# Bulk Load CSV into Table
# NOTE: Run from CMD line
HADOOP_CLASSPATH=/usr/hdp/2.5.0.0-1245/hbase/lib/hbase-protocol.jar:/usr/hdp/2.5.0.0-1245/hbase/conf                            \
hadoop jar /usr/hdp/2.5.0.0-1245/phoenix/phoenix-4.7.0.2.5.0.0-1245-client.jar org.apache.phoenix.mapreduce.CsvBulkLoadTool     \
--table mm_season --d "," --ignore-errors                                                                                       \
--input /tmp/marchmadness/SeasonResults/SeasonResults.csv

SELECT * FROM MM_SEASON LIMIT 10;

!describe mm_season


###############################################################################################################


CREATE TABLE IF NOT EXISTS mm_teams
    (team_id VARCHAR, team_name VARCHAR
    CONSTRAINT mypk PRIMARY KEY (team_id))
    SALT_BUCKETS = 1;

# Bulk Load CSV into Table
# NOTE: Run from CMD line
HADOOP_CLASSPATH=/usr/hdp/2.5.0.0-1245/hbase/lib/hbase-protocol.jar:/usr/hdp/2.5.0.0-1245/hbase/conf                            \
hadoop jar /usr/hdp/2.5.0.0-1245/phoenix/phoenix-4.7.0.2.5.0.0-1245-client.jar org.apache.phoenix.mapreduce.CsvBulkLoadTool     \
--table mm_teams --d "," --ignore-errors                                                                                        \
--input /tmp/marchmadness/Teams/Teams.csv

SELECT * FROM mm_teams LIMIT 10;

!describe mm_teams;


###############################################################################################################
#
#   Phoenix - Join + Calculations
#
###############################################################################################################


# Calculate the Top 15 Teams with the most Wins
SELECT WTEAM_NAME, COUNT(*) AS WINS 

    FROM 

    (
    SELECT mm_season.*, 
        teams2a.team_name AS WTEAM_NAME, 
        teams2b.team_name AS LTEAM_NAME
        FROM mm_season
        LEFT JOIN mm_teams teams2a ON (mm_season.wteam = teams2a.team_id)
        LEFT JOIN mm_teams teams2b ON (mm_season.lteam = teams2b.team_id) 
    ) 
    
    GROUP BY WTEAM_NAME 
    ORDER BY WINS DESC 
    LIMIT 15;



# Calculate the Top 15 Teams with the most Losses
SELECT LTEAM_NAME, COUNT(*) AS LOSSES 

    FROM 

    (
    SELECT mm_season.*, 
        teams2a.team_name AS WTEAM_NAME, 
        teams2b.team_name AS LTEAM_NAME
        FROM mm_season
        LEFT JOIN mm_teams teams2a ON (mm_season.wteam = teams2a.team_id)
        LEFT JOIN mm_teams teams2b ON (mm_season.lteam = teams2b.team_id) 
    ) 
    
    GROUP BY LTEAM_NAME 
    ORDER BY LOSSES DESC 
    LIMIT 15;




# Calculate the Top 15 Matchups with the biggest score difference
SELECT SEASON, WSCORE, LSCORE, WLOC, (WSCORE-LSCORE) AS SCORE_DIFF, WTEAM_NAME, LTEAM_NAME

    FROM 

    (
    SELECT mm_season.*, 
        teams2a.team_name AS WTEAM_NAME, 
        teams2b.team_name AS LTEAM_NAME
        FROM mm_season
        LEFT JOIN mm_teams teams2a ON (mm_season.wteam = teams2a.team_id)
        LEFT JOIN mm_teams teams2b ON (mm_season.lteam = teams2b.team_id) 
    ) 
    
    ORDER BY SCORE_DIFF DESC
    LIMIT 15;



#ZEND
