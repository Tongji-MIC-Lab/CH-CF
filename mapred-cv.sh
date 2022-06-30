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

LIBJARS=$THIS_PATH/contrib/protobuf-java-2.4.1.jar

MAINCLASS=mic.cv.mapred.Mapreduce

hadoop jar $THIS_PATH/Mapreduce.jar $MAINCLASS -files $FILES -libjars $LIBJARS $THIS_PATH $1

