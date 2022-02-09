while getopts p:r:w:x: flag
do
    case "${flag}" in
        p) project=${OPTARG};;
        r) region=${OPTARG};;
        w) clusterid=${OPTARG};;
        x) resource=${OPTARG};;
    esac
done
echo "Project: $project";
echo "Region: $region";
echo "Clusterid: $clusterid";
echo "Deleting resource: $resource"

#Variables 
PREFIX="https://workstations.googleapis.com/v1alpha1/"
DELETEWORKSTATIONS=""
DELETECONFIGS=""
DELETECLUSTER=""
if [ $resource == "workstations" ]; then
    DELETEWORKSTATIONS="yes";
fi
if [ $resource == "configs" ]; then
    DELETEWORKSTATIONS="yes"
    DELETECONFIGS="yes";
fi
if [ $resource == "cluster" ]; then
    DELETEWORKSTATIONS="yes"
    DELETECONFIGS="yes"
    DELETECLUSTER="yes";
fi

#Workstation Deletion
if [ "$DELETEWORKSTATIONS" == "yes" ] 
then
    echo Deleting your Workstations.
    NUMWORKSTATIONS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid/workstations/ | (grep -c '"name":'))"
    WORKSTATIONS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid/workstations/ | (grep -oP '"name":\K.*') | tr -d '"')"
    for ((i=1;i<=$NUMWORKSTATIONS;i++)); 
    do
        WORKSTATIONSUFFIX=$(echo $WORKSTATIONS| cut -d',' -f $i)
        WORKSTATIONPATH=$PREFIX$WORKSTATIONSUFFIX
        WORKSTATIONPATH=$(echo $WORKSTATIONPATH | tr -d ' ')
        curl -s -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            $WORKSTATIONPATH
        while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            $WORKSTATIONPATH | grep -q reconciling)
            do
                sleep 10
            done
                echo Your Workstation at $WORKSTATIONPATH has been deleted.
    done
        echo All Workstations have been deleted.
fi

    #Config Deletion
if [ "$DELETECONFIGS" == "yes" ] 
then
    echo Deleting your Workstation Configs.
    NUMCONFIGS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid/workstationConfigs/ | (grep -c '"name":'))"
    CONFIGS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid/workstationConfigs/ | (grep -oP '"name":\K.*') | tr -d '"')"
    for ((i=1;i<=$NUMCONFIGS;i++)); 
    do
        CONFIGSUFFIX=$(echo $CONFIGS| cut -d',' -f $i)
        CONFIGPATH=$PREFIX$CONFIGSUFFIX
        CONFIGPATH=$(echo $CONFIGPATH | tr -d ' ')
        curl -s -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            $CONFIGPATH
        while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            $CONFIGPATH | grep -q reconciling)
            do
                sleep 10
            done
                echo Your Workstation Config at $CONFIGPATH has been deleted.
    done
        echo All Workstation Configs have been deleted.
fi

if [ "$DELETECLUSTER" == "yes" ] 
then
    #Cluster Deletion 
    echo Deleting your Cluster. 
    curl -s -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid   

    while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
        -H "Content-Type: application/json" \
        https://workstations.googleapis.com/v1alpha1/projects/$project/locations/$region/workstationClusters/$clusterid | grep -q reconciling)
    do
        sleep 120
    done
        echo Your cluster has been deleted.
fi