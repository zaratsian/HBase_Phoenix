<h3><a href="https://hbase.apache.org/book.html">Apache HBase</a> and <a href="https://phoenix.apache.org/">Apache Phoenix</a></h3>
Scripts, tricks, and references
<br>
<br><b>APACHE HBASE</b>
<br>
<br>./bin/hbase shell
<br>list                                 # List HBase Tables
<br>status                               # Server status
<br>create 'table_name','column_family'  # Create HBase Table
<br>alter 'ztable', NAME => 'colfam', VERSIONS => 5  # Set max versions to 5 for columnfamily 'colfam'
<br>scan 'table_name'                    # Scan Table
<br>get 'table_name','row1'              # Get row within Table
<br>get 'table_name', 'rowid', {COLUMN => 'column family:column name'}
<br>get 'ztable', '111', {COLUMN => 'colfam:name', VERSIONS => 5}  # Get last 5 versions for colfam:name, row=111
<br>put 'table_name','row','Column family:column name','new value'
<br>disable 'table_name'                 # Delete Table - First disable
<br>drop 'table_name'                    # Delete Table - Then drop
<br>
<br>
<br><b>APACHE PHOENIX</b>
<br>
<br><b>Connecting to Phoenix:</b>
<br><code>python ./bin/sqlline.py zookeeper_host:zookeeper_port</code>
<br><code>jdbc:phoenix:zookeeper_host:zookeeper_port:/hbase-unsecure</code>
<br>
<br>Phoenix Syntax:
<br><code>!tables</code>
<br>
<br>
<br><b>References:</b>
<br><a href="https://hbase.apache.org/book.html">Apache HBase Docs</a>
<br><a href="https://phoenix.apache.org">Apache Phoenix Docs</a>
<br>
