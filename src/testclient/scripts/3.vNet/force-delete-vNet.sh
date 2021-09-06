#!/bin/bash

function CallTB() {
	echo "- Delete vNet in ${MCIRRegionName}"

	curl -H "${AUTH}" -sX DELETE http://$TumblebugServer/tumblebug/ns/$NSID/resources/vNet/${CONN_CONFIG[$INDEX,$REGION]}-${POSTFIX}?force=true | jq ''
}

#function delete_vNet() {
	
	echo "####################################################################"
	echo "## 3. vNet: Delete"
	echo "####################################################################"

	source ../init.sh

	if [ "${INDEX}" == "0" ]; then
		echo "[Parallel excution for all CSP regions]"

		INDEXX=${NumCSP}
		for ((cspi = 1; cspi <= INDEXX; cspi++)); do
			echo $i
			INDEXY=${NumRegion[$cspi]}
			CSP=${CSPType[$cspi]}
			for ((cspj = 1; cspj <= INDEXY; cspj++)); do
				# INDEX=$(($INDEX+1))

				echo $j
				INDEX=$cspi
				REGION=$cspj
				echo $CSP
				echo $REGION
				echo ${RegionName[$cspi,$cspj]}
				MCIRRegionName=${RegionName[$cspi,$cspj]}

				CallTB

			done

		done
		wait

	else
		echo ""
		
		MCIRRegionName=${CONN_CONFIG[$INDEX,$REGION]}

		CallTB

	fi

#}

#delete_vNet