#/bin/bash

# HELP: i3 help text

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]]; then
	echo "Please execute from axt.sh"
	exit
fi

WARNINGS=()

function print_help
{
	local INDENT=$1
	local COMMAND_PREFIX=$2
	local FIND_PATTERN="'${COMMAND_PREFIX}-*.sh'"
	local AXT_FILES=(`eval find ${AXT_PATH} -name ${FIND_PATTERN} -print`)

	if [[ ${AXT_FILES} ]]; then
		local SUBCOMMANDS=()
		local SUBCOMMANDS_HELP=()
		local MAX_SUBCOMMAND_LEN=0
		for AXT_FILE in "${AXT_FILES[@]}"
		do :
			if [[ ! ${AXT_FILE} =~ .*${COMMAND_PREFIX}-.*-.*sh ]]; then
				local HELP_LINE=$(grep '# HELP: ' ${AXT_FILE} | head -1)
				if [[ ${HELP_LINE} ]]; then
					local HELP_TEXT="${HELP_LINE#\# HELP: }"
					if [[ ${HELP_TEXT} ]]; then
						local BASENAME="$(basename ${AXT_FILE} .sh)"
						local SUBCOMMAND="${BASENAME#axt-}"
						local SUBCOMMAND_LEN=${#SUBCOMMAND}
						SUBCOMMANDS+=("${SUBCOMMAND}")
						SUBCOMMANDS_HELP+=("${HELP_TEXT}")
						if (( MAX_SUBCOMMAND_LEN < SUBCOMMAND_LEN )); then	
							MAX_SUBCOMMAND_LEN=${SUBCOMMAND_LEN}
						fi
					else
						WARNINGS+=("axt subcommand '${AXT_FILE}' has empty help.")
					fi
				else
					WARNINGS+=("axt subcommand '${AXT_FILE}' has no help tag.")
				fi 
			fi
		done

		for ((i = 0 ; i < ${#SUBCOMMANDS[@]} ; i++ )); do
		    local SUBCOMMAND="${SUBCOMMANDS[i]}"
			local SUBCOMMAND_HELP="${SUBCOMMANDS_HELP[i]}"
			printf "%-${INDENT}s%-${MAX_SUBCOMMAND_LEN}s - %s\n" "" "${SUBCOMMAND}" "${SUBCOMMAND_HELP}"
			print_help $((INDENT + MAX_SUBCOMMAND_LEN + 5)) "${PATTERN}${SUBCOMMAND}"
		done
	fi
}

print_help 2 "axt"

for WARNING in "${WARNINGS[@]}"
do :
	echo "AXT WARNING: ${WARNING}"
done

