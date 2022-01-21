curl -H "Authorization: Bearer $(gcloud auth print-access-token)" \
	     -H "Content-Type: application/json" \
	          -d @config.json \
		  https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/my-cluster/workstationConfigs?workstation_config_id=${CONFIG_NAME}
		  
echo Your config is being created. This script will terminate once it is available.
while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
     -H "Content-Type: application/json" \
https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/my-cluster/workstationConfigs/${CONFIG_NAME} | grep -q reconciling)
do
	sleep 30
done
	echo Your config is ready
