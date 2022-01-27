# dev-exp-cloud-workstation
Using Cloud Workstation to improve developer experience and secure software supply chain 

Creating a Cluster: 
1. Create a cluster.json file describing the cluster you want to create. A sample cluster.json can be found in the samples folder.
2. Export the PROJECT, REGION, and CLUSTER_ID as environment variables in your Cloud Shell. Project should be the name of your project, Region should be the name of the region your VPC is in, and CLUSTER_ID should be the name of the cluster you are attempting to create.
3. Run the create-cluster.sh script. 
4. The script will terminate once the cluster is created and available. It is resilient to Cloud Shell automatic disconnects. This should take about 20 minutes.

Creating a Config:
1. Create a config.json file describing the config you want to create. A sample config.json can be found in the samples folder.
2. Export the PROJECT, REGION, and CLUSTER_ID, and CONFIG_NAME as environment variables in your Cloud Shell. CONFIG_NAME should be the name of the config you are attempting to create. 
3. Run the create-config.sh script.
4. The script will terminate once the config is created and available. It is resilient to Cloud Shell automatic disconnects. This should take about 1 minute.

