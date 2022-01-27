# dev-exp-cloud-workstation
Using Cloud Workstation to improve developer experience and secure software supply chain 

Creating a Cluster: 
1. Create a cluster.json file describing the cluster you want to create. A sample cluster.json can be found in the samples folder.
2. Export PROJECT, REGION, and CLUSTER_ID as environment variables in your Cloud Shell. Project should be the name of your project, Region should be the name of the region your VPC is in, and CLUSTER_ID should be the name of the cluster you are attempting to create.
3. Run the create-cluster.sh script. "sh create-cluster.sh"
4. The script will terminate once the cluster is created and available. It is resilient to Cloud Shell automatic disconnects. This should take about 20 minutes.

Creating a Config:
1. Create a config.json file describing the config you want to create. A sample config.json can be found in the samples folder.
2. Export PROJECT, REGION, and CLUSTER_ID, and CONFIG_NAME as environment variables in your Cloud Shell. CONFIG_NAME should be the name of the config you are attempting to create. 
3. Run the create-config.sh script. "sh create-config.sh"
4. The script will terminate once the config is created and available. It is resilient to Cloud Shell automatic disconnects. This should take about 1 minute.

Cleaning Up:
1. Export PROJECT and CLUSTER_ID as environment variables in your Cloud Shell.
2. To delete all workstations on a cluster, run the delete.sh script with workstations as an argument via Cloud shell. "sh delete.sh workstations"
3. To delete all configs on a cluster, run the delete.sh script with configs as an argument via Cloud shell. "sh delete.sh configs". Note, this will also delete all workstations on the cluster since these workstations are dependant on the configs.
5. To delete a cluster, run the delete.sh script with cluster as an argument via Cloud shell. "sh delete.sh cluster". This will delete the cluster and all associated resources with it, including configs and workstations which reside on the cluster. 
