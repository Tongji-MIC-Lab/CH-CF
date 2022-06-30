#!/bin/bash

if [ $# -lt 1 ];then
echo "please specify the cfg file for the job!"
exit -1
fi

if [ ! -f $1 ];then
echo "the cfg file ($1) is NOT existed!"
exit -2
fi

THIS_PATH=`dirname "$0"`
THIS_PATH=`cd "$THIS_PATH"; pwd`

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$THIS_PATH/lib

FILES=$THIS_PATH/lib/libImageProc.so,$THIS_PATH/lib/libClustering.so,$THIS_PATH/lib/libBoW.so,$THIS_PATH/lib/libProtoMessage.so.1.0,\
$THIS_PATH/lib/libtbb.so.2,$THIS_PATH/lib/libprotobuf.so.7,$THIS_PATH/lib/libprotobuf-lite.so.7,$THIS_PATH/lib/libhdfs.so.0,\
$THIS_PATH/contrib/compute_descriptors.ln,$THIS_PATH/contrib/detect_points.ln,$THIS_PATH/contrib/hesaff,$THIS_PATH/contrib/colorDescriptor

LIBJARS=$THIS_PATH/contrib/protobuf-java-2.4.1.jar,/usr/local/hadoop/lib/commons-cli-1.2.jar
MAINCLS=mic.cv.spark.SparkDriver

/usr/local/spark/bin/spark-submit --master spark://node00:7077 --class $MAINCLS --jars $LIBJARS --files $FILES \
--driver-class-path /usr/local/hadoop/lib/commons-cli-1.2.jar --conf spark.executorEnv.LD_LIBRARY_PATH=. \
--executor-memory 10G --driver-memory 12G $THIS_PATH/SparkDriver.jar $1
