#!/bin/sh
while getopts r:p:f:w:c: flag
do
    case "${flag}" in
        r) region=${OPTARG};;
        p) project=${OPTARG};;
        f) filename=${OPTARG};;
        w) clusterid=${OPTARG};;
        c) configname=${OPTARG};;
    esac
done
echo "Project: $project";
echo "Region: $region";
echo "Filename: $filename";
echo "Clusterid: $clusterid";
echo "Configname: $configname";

curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
	     -H "Content-Type: application/json" \
	          -d @$filename \
		  https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid/workstationConfigs?workstation_config_id=$configname
echo Your config is being created. This script will terminate once it is available.
while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid/workstationConfigs/$configname | grep -q reconciling)
do
	sleep 30
done
	echo Your config is ready