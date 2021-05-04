#!/bin/bash

#function create_vNet() {


	TestSetFile=${4:-../testSet.env}
    if [ ! -f "$TestSetFile" ]; then
        echo "$TestSetFile does not exist."
        exit
    fi
	source $TestSetFile
    source ../conf.env
	
	echo "####################################################################"
	echo "## 3. vNet: Status"
	echo "####################################################################"

	CSP=${1}
	REGION=${2:-1}
	POSTFIX=${3:-developer}

	source ../common-functions.sh
	getCloudIndex $CSP

	CIRDNum=$(($INDEX+1))
	CIDRDiff=$(($CIRDNum*$REGION))
	CIDRDiff=$(($CIDRDiff%254))

    resp=$(
        curl -H "${AUTH}" -sX GET http://$TumblebugServer/tumblebug/listVNetStatus -H 'Content-Type: application/json' -d @- <<EOF
        {
			"connectionName": "${CONN_CONFIG[$INDEX,$REGION]}"
		}
EOF
    ); echo ${resp} | jq ''
    echo ""
#}

#create_vNet
