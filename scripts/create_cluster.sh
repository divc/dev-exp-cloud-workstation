curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
     -d @cluster.json \
https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters?workstation_cluster_id=${CLUSTER_ID}
echo Your cluster is being created. This script will terminate once it is available.
while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/${CLUSTER_ID} | grep -q reconciling)
do
	sleep 120
done
	echo Your cluster is ready
