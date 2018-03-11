#!/bin/bash

HOST=mar
IMAGE_FAMILY='ubuntu-1604-lts'
IMAGE_PROJECT='ubuntu-os-cloud' # image-project 
TYPE="n1-standard-2"
ZONE="us-west1-a"

if [ "$#" -lt 1 ] 
then
  echo "Usage: gcp.sh {add-disk | ssh | create | start | stop | delete |  reset}"
  exit 1 
fi

CMD="$1"

if [[ ${CMD} == "add-disk" ]]
then 
  if [ "$#" -eq 3 ]
  then
    DISK_NAME="$2"
    DISK_SIZE="$3"
  else
    echo "Usage: gcp.sh add-disk <name> <size>"
    echo "\t size is in gigabytes."
    exit 1
  fi
fi

case ${CMD} 
  in
  "add-disk") 
    gcloud compute disks create ${DISK_NAME} --size ${DISK_SIZE}GB --zone ${ZONE} 
    ;; 
  "reset")
    gcloud compute instances reset ${HOST} --zone ${ZONE}
    ;;
  "ssh")   
    gcloud compute ssh ${HOST} --zone ${ZONE} 
    ;;
  "create")
      if [[ "$#" -eq 1 ]]
      then
          gcloud compute instances create ${HOST} --zone ${ZONE} --machine-type ${TYPE} \
		 --image-family ${IMAGE_FAMILY} --image-project ${IMAGE_PROJECT}
      else
          gcloud compute instances create ${HOST} --zone ${ZONE}  --machine-type ${TYPE} \
		 --disk "name=${2}" \
		 --image-family ${IMAGE_FAMILY}  --image-project ${IMAGE_PROJECT}
      fi

      ;;
  "start") 
    gcloud compute instances start ${HOST} --zone ${ZONE} 
    ;;

  "stop") 
    gcloud compute instances stop ${HOST} --zone ${ZONE} 
    ;;
  "delete")
      gcloud compute instances delete ${HOST} --zone ${ZONE} # --keep-disks boot
      ;;
  *)  echo "unknown command, ${CMD}. Ignoring." ; exit 1 
esac
