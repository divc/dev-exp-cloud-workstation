# dev-exp-cloud-workstation
Using Cloud Workstation to improve developer experience and secure software supply chain 

Creating a Cluster: 
1. Create a cluster.json file describing the cluster you want to create. A sample cluster.json can be found in the samples/cluster_configs folder.
2. Provide Project Name, Region Name, Workstation cluster filename, and Workstation cluster id as the command line args while running the script. The args are as follows 
| Args | Description | Usage |
| :---: | :---: | :---: |
| -p | Project Name | -p project-a |
| -r | Region Name | -r us-central1 |
| -f | Workstation cluster filename | -f ../cluster.json |
| -w | Workstation cluster id | -w appdev-workstation-cluster |
3. Run the create-cluster.sh script. "sh create-cluster.sh -p project-a -r us-central1 -f ../cluster.json -w my-cluster"
4. The script will terminate once the cluster is created and available. It is resilient to Cloud Shell automatic disconnects. This should take about 20 minutes.

Creating a Config:
1. Create a config.json file describing the config you want to create. Sample config.json files can be found in the samples/workstation_configs folder.
2. Provide Project Name, Region Name, Workstation config filename, Workstation cluster id, and Configuration name as the command line args while running the script. The args are as follows 
| Args | Description | Usage |
| :---: | :---: | :---: |
| -p | Project Name | -p project-a |
| -r | Region Name | -r us-central1 |
| -f | Workstation config filename | -f ../rstudio-config.json |
| -w | Workstation cluster id | -w appdev-workstation-cluster |
| -c | Configuration name | -c rstudio-config |
3. Run the create-config.sh script. "sh create-config.sh -p project-a -r us-central1 -f ../rstudio-config.json -w appdev-workstation-cluster -c rstudio-config"
4. The script will terminate once the config is created and available. It is resilient to Cloud Shell automatic disconnects. This should take about 1 minute.

Cleaning Up:
1. Provide Project Name, Region Name, Workstation cluster id, and Resource Type as the command line args while running the script. The args are as follows 
| Args | Description | Usage |
| :---: | :---: | :---: |
| -p | Project Name | -p project-a |
| -r | Region Name | -r us-central1 |
| -w | Workstation cluster id | -w appdev-workstation-cluster |
| -x | Resource Type | -x configs |
2. Resource Type is required and supports three options: "workstations", "configs", and "cluster".
3. To delete all workstations on a cluster, run the delete.sh script with workstations as the Resource Type.
    "sh delete.sh -p project-a -r us-central1 -w appdev-workstation-cluster -x workstations"
4. To delete all configs on a cluster, run the delete.sh script with configs as the Resource Type. Note, this will also delete all workstations on the cluster since these workstations are dependant on the configs.
    "sh delete.sh -p project-a -r us-central1 -w appdev-workstation-cluster -x configs"
5. To delete a cluster, run the delete.sh script with cluster as the Resource Type. This will delete the cluster and all associated resources with it, including configs and workstations which reside on the cluster. 
    "sh delete.sh -p project-a -r us-central1 -w appdev-workstation-cluster -x cluster"
