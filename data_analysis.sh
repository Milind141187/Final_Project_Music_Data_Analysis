batchid=`cat /home/acadgild/project/logs/current-batch.txt`
LOGFILE=/home/acadgild/project/logs/log_batch_$batchid

echo "Running script for data analysis in Spark..." >> $LOGFILE

chmod 775 /home/acadgild/project/lib/sparkanalysis.jar


/home/acadgild/install/spark/spark-2.1.0-bin-hadoop2.6/bin/spark-submit  \
--class /home/acadgild/project/scripts/Spark_analysis  \
--master local[2]  \
--driver-class-path /home/acadgild/install/hive/apache-hive-2.3.3-bin/lib/hive-hbase-handler-2.3.3.jar:/home/acadgild/install hbase/hbase-1.4.4/lib/*  \
/home/acadgild/project/lib/sparkanalysis.jar $batchid
   

/home/acadgild/install/spark/spark-2.1.0-bin-hadoop2.6/bin/spark-submit  \
--class /home/acadgild/project/scripts/Spark_analysis_2  \
--master local[2]  \
--driver-class-path /home/acadgild/install/hive/apache-hive-2.3.3-bin/lib/hive-hbase-handler-2.3.3.jar:/home/acadgild/install hbase/hbase-1.4.4/lib/*  \
/home/acadgild/project/lib/sparkanalysis.jar $batchid


sh /home/acadgild/project/scripts/data_export.sh


echo "Incrementing batchid..." >> $LOGFILE

batchid=`expr $batchid + 1`
echo -n $batchid > /home/acadgild/project/logs/current-batch.txt
