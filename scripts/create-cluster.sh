while getopts p:r:f:w: flag
do
    case "${flag}" in
        p) project=${OPTARG};;
        r) region=${OPTARG};;
        f) filename=${OPTARG};;
        w) clusterid=${OPTARG};;
    esac
done
echo "Project: $project";
echo "Region: $region";
echo "Filename: $filename";
echo "Clusterid: $clusterid";
curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
     -d @$filename \
https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters?workstation_cluster_id=$clusterid
echo Your cluster is being created. This script will terminate once it is available.
while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid | grep -q reconciling)
do
	sleep 120
done
	echo Your cluster is ready
