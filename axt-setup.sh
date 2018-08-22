#!/bin/sh

# HELP: Setup AXT environment

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit
fi

AXTRC_TMP="${AXT_RC}.tmp"
echo "# AXT environment" > ${AXTRC_TMP}
echo "# Do not edit directly! Use axt setup and add new parameters to \$AXT_PATH/.axtrc" >>  ${AXTRC_TMP}
echo "" >> ${AXTRC_TMP}

SRC_AXT_RCS=$(find ${AXT_PATH} -name .axtrc -print)
for SRC_AXT_RC in ${SRC_AXT_RCS[@]}; do
	IFS=$'\n'
    SRC_PARAMS=( $(grep "=" ${SRC_AXT_RC}) )
	for SRC_PARAM in ${SRC_PARAMS[@]}; do
		SRC_PARAM_NAME=${SRC_PARAM%%"="*}
		SRC_PARAM_REST=${SRC_PARAM##*"="}
        SRC_PARAM_VALUE=${SRC_PARAM_REST%%" "*"# "*}         
        SRC_PARAM_COMMENT=${SRC_PARAM_REST##*"# "}         
		if [[ ${SRC_PARAM_VALUE:0:1} == \" ]]; then
			SRC_PARAM_VALUE_QUOTED="TRUE"
			SRC_PARAM_VALUE="${SRC_PARAM_VALUE:1:-1}"
		else
			SRC_PARAM_VALUE_QUOTED="FALSE"
		fi 

		PARAM_NAME=${SRC_PARAM_NAME}
		PARAM_DEFAULT=${SRC_PARAM_VALUE}
		PARAM_COMMENT=${SRC_PARAM_COMMENT}
		if [ -f ${AXT_RC} ]; then
		    PREFIX="export ${PARAM_NAME}="
			AXTRC_PARAM_VALUE=$(grep "${PREFIX}" ${AXT_RC})
			if [ ! -z "${AXTRC_PARAM_VALUE}" ]; then
				PARAM_DEFAULT=${AXTRC_PARAM_VALUE#"${PREFIX}"}
				if [[ ${SRC_PARAM_VALUE_QUOTED} == TRUE ]]; then
					PARAM_DEFAULT=${PARAM_DEFAULT:1:-1}
				fi
			fi
		fi

		PARAM_VALUE=""
		if [ -z "${PARAM_DEFAULT}" ]; then
			while [[ ${PARAM_VALUE} == "" ]]; do
				echo "${PARAM_COMMENT}"
				read PARAM_VALUE
			done
		else
			echo "${PARAM_COMMENT}  -  <Enter> uses default '${PARAM_DEFAULT}'"
			read PARAM_VALUE
			if [ -z "${PARAM_VALUE}" ]; then
				PARAM_VALUE=${PARAM_DEFAULT}
			fi
		fi

		echo "# ${PARAM_COMMENT}" >> ${AXTRC_TMP}
		if [[ ${SRC_PARAM_VALUE_QUOTED} == TRUE ]]; then
	    	echo "export ${PARAM_NAME}=\"${PARAM_VALUE}\"" >>  ${AXTRC_TMP}
		else
			echo "export ${PARAM_NAME}=${PARAM_VALUE}" >> ${AXTRC_TMP}
		fi
		echo "" >>  ${AXTRC_TMP}
	done
done

mv ${AXTRC_TMP} ${AXT_RC}