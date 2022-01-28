#Variables 
PREFIX="https://workstations.googleapis.com/v1alpha1/"
DELETEWORKSTATIONS=""
DELETECONFIGS=""
DELETECLUSTER=""
if [ $1 == "workstations" ]; then
    DELETEWORKSTATIONS="yes";
fi
if [ $1 == "configs" ]; then
    DELETEWORKSTATIONS="yes"
    DELETECONFIGS="yes";
fi
if [ $1 == "cluster" ]; then
    DELETEWORKSTATIONS="yes"
    DELETECONFIGS="yes"
    DELETECLUSTER="yes";
fi
echo $DELETEWORKSTATIONS
echo $DELETECONFIGS
echo $DELETECLUSTER


#Workstation Deletion
if [ "$DELETEWORKSTATIONS" == "yes" ] 
then
    echo Deleting your Workstations.
    NUMWORKSTATIONS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/${CLUSTER_ID}/workstations/ | (grep -c '"name":'))"
    WORKSTATIONS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/${CLUSTER_ID}/workstations/ | (grep -oP '"name":\K.*') | tr -d '"')"
    for ((i=1;i<=$NUMWORKSTATIONS;i++)); 
    do
        WORKSTATIONSUFFIX=$(echo $WORKSTATIONS| cut -d',' -f $i)
        WORKSTATIONPATH=$PREFIX$WORKSTATIONSUFFIX
        WORKSTATIONPATH=$(echo $WORKSTATIONPATH | tr -d ' ')
        curl -s -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            $WORKSTATIONPATH
    while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
        -H "Content-Type: application/json" \ $WORKSTATIONPATH | grep -q reconciling)
        do
            sleep 10
        done
            echo Your Workstation at $WORKSTATIONPATH has been deleted.
    done
        echo All Workstations have been deleted.
        sleep 2
fi

    #Config Deletion
if [ "$DELETECONFIGS" == "yes" ] 
then
    echo Deleting your Workstation Configs.
    NUMCONFIGS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/${CLUSTER_ID}/workstationConfigs/ | (grep -c '"name":'))"
    CONFIGS="$(curl -s -X GET -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/${CLUSTER_ID}/workstationConfigs/ | (grep -oP '"name":\K.*') | tr -d '"')"
    for ((i=1;i<=$NUMCONFIGS;i++)); 
    do
        CONFIGSUFFIX=$(echo $CONFIGS| cut -d',' -f $i)
        CONFIGPATH=$PREFIX$CONFIGSUFFIX
        CONFIGPATH=$(echo $CONFIGPATH | tr -d ' ')
        curl -s -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            $CONFIGPATH
    while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
        -H "Content-Type: application/json" \ $CONFIGPATH | grep -q reconciling)
        do
            sleep 10
        done
            echo Your Workstation Config at $CONFIGPATH has been deleted.
    done
        echo All Workstation Configs have been deleted.
    sleep 2
fi

if [ "$DELETECLUSTER" == "yes" ] 
then
    #Cluster Deletion 
    echo Deleting your Cluster. 
    curl -s -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" \
            -H "Content-Type: application/json" \
            https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/${CLUSTER_ID}   

    while (curl -s -H "Authorization: Bearer $(gcloud auth print-access-token)" \
        -H "Content-Type: application/json" \
    https://workstations.googleapis.com/v1alpha1/projects/${PROJECT}/locations/us-central1/workstationClusters/${CLUSTER_ID} | grep -q reconciling)
    do
        sleep 120
    done
        echo Your cluster has been deleted.
fi
