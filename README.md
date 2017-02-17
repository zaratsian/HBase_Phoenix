<h3><a href="https://hbase.apache.org/book.html">Apache HBase</a> and <a href="https://phoenix.apache.org/">Apache Phoenix</a></h3>
Scripts, tricks, and references
<br>
<br><b>HBase Syntax:</b>
<br>
<br>./bin/hbase shell
<br>list                                 # List HBase Tables
<br>status                               # Server status
<br>create 'table_name','column_family'  # Create HBase Table
<br>alter 'ztable', NAME => 'colfam', VERSIONS => 5  # Set max versions to 5 for columnfamily 'colfam'
<br>scan 'table_name'                    # Scan Table
<br>get 'table_name','row1'              # Get row within Table
<br>get 'table_name', 'rowid', {COLUMN => 'column family:column name'}
<br>put 'table_name','row','Column family:column name','new value'
<br>disable 'table_name'                 # Delete Table - First disable
<br>drop 'table_name'                    # Delete Table - Then drop
<br>
<br>
<br><b>Phoenix Syntax:</b>
<br>
<br>python ./bin/sqlline.py zookeeper_host:zookeeper_port      # python ./bin/sqlline.py localhost:2181
<br>jdbc:phoenix:sandbox.hortonworks.com:2181:/hbase-unsecure  # Example database Connection URL
<br>
<br>
<br><b>References:</b>
<br><a href="https://hbase.apache.org/book.html">Docs - Apache HBase</a>
<br><a href="https://phoenix.apache.org">Docs - Apache Phoenix</a>
<br>
