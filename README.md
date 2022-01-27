# dev-exp-cloud-workstation
Using Cloud Workstation to improve developer experience and secure software supply chain 

Creating a Cluster: 
1. Create a cluster.json file describing the cluster you want to create. A sample cluster.json can be found in the samples folder.
2. Export the PROJECT, REGION, and CLUSTER_ID as environment variables in your Cloud Shell. Project should be the name of your project, Region should be the name of the region your VPC is in, and CLUSTER_ID should be the name of the cluster you are attempting to create.
3. Run the create-cluster.sh script. 
4. The script will terminate once the cluster is created and available. It is also resilient to Cloud Shell automatic disconnects. 
