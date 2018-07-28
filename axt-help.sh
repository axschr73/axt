#/bin/bash

# HELP: Print this help text

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

WARNINGS=()

function print_help
{
	local INDENT=$1
	local PREFIX=$2
	local COMMAND_PREFIX=$3

	local FIND_PATTERN="'${COMMAND_PREFIX}-*.sh'"
	local AXT_FILES=(`eval find ${AXT_PATH} -name ${FIND_PATTERN} -print`)

	if [[ ${AXT_FILES} ]]; then
		local SUBCOMMANDS=()
		local SUBCOMMANDS_HELP=()
		local MAX_SUBCOMMAND_LEN=0
		local FILE_INDEX=0
		local NUM_AXT_FILES=${#AXT_FILES[@]}
		while (( FILE_INDEX < NUM_AXT_FILES )); do
			local AXT_FILE=${AXT_FILES[${FILE_INDEX}]}
			if [[ ! ${AXT_FILE} =~ .*${COMMAND_PREFIX}-.*-.*sh ]]; then
				local HELP_LINE=$(grep '# HELP: ' ${AXT_FILE} | head -1)
				if [[ ${HELP_LINE} ]]; then
					local HELP_TEXT="${HELP_LINE#\# HELP: }"
					if [[ ${HELP_TEXT} ]]; then
						local BASENAME="$(basename ${AXT_FILE} .sh)"
						local SUBCOMMAND="${BASENAME#${COMMAND_PREFIX}-}"
						local SUBCOMMAND_LEN=${#SUBCOMMAND}
						local SUBCOMMANDS+=("${SUBCOMMAND}")
						local SUBCOMMANDS_HELP+=("${HELP_TEXT}")
						if (( MAX_SUBCOMMAND_LEN < SUBCOMMAND_LEN )); then	
							local MAX_SUBCOMMAND_LEN=${SUBCOMMAND_LEN}
						fi
					else
						WARNINGS+=("axt subcommand '${AXT_FILE}' has empty help.")
					fi
				else
					WARNINGS+=("axt subcommand '${AXT_FILE}' has no help tag.")
				fi 
			fi
			((FILE_INDEX++))
		done

		local SUBCOMMAND_INDEX=0
		local NUM_SUBCOMMANDS=${#SUBCOMMANDS[@]}
		while (( SUBCOMMAND_INDEX < NUM_SUBCOMMANDS )); do
		    local SUBCOMMAND="${SUBCOMMANDS[${SUBCOMMAND_INDEX}]}"
			local SUBCOMMAND_HELP="${SUBCOMMANDS_HELP[${SUBCOMMAND_INDEX}]}"
			printf "%-${INDENT}s%s%-${MAX_SUBCOMMAND_LEN}s - %s\n" "" "${PREFIX}" "${SUBCOMMAND}" "${SUBCOMMAND_HELP}"
			print_help $((INDENT + MAX_SUBCOMMAND_LEN + 5)) "* " "${COMMAND_PREFIX}-${SUBCOMMAND}"
			((SUBCOMMAND_INDEX++))
		done
	fi
}

print_help 2 "" "axt"

for WARNING in "${WARNINGS[@]}"
do :
	echo "AXT WARNING: ${WARNING}"
done

