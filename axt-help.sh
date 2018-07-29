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

<<<<<<< HEAD
	local FIND_PATTERN="'${COMMAND_PREFIX}-*.sh'"
=======
	local FIND_PATTERN="'${COMMAND_PREFIX}*.sh'"
>>>>>>> axt-help.sh
	local AXT_FILES=(`eval find ${AXT_PATH} -name ${FIND_PATTERN} -print`)

	if [[ ${AXT_FILES} ]]; then
		local SUBCOMMANDS=()
		local SUBCOMMANDS_HELP=()
		local MAX_SUBCOMMAND_LEN=0
		local FILE_INDEX=0
		local NUM_AXT_FILES=${#AXT_FILES[@]}
		while (( FILE_INDEX < NUM_AXT_FILES )); do
			local AXT_FILE=${AXT_FILES[${FILE_INDEX}]}
<<<<<<< HEAD
			if [[ ! ${AXT_FILE} =~ .*${COMMAND_PREFIX}-.*-.*sh ]]; then
				local HELP_LINE=$(grep '# HELP: ' ${AXT_FILE} | head -1)
=======
			if [[ ! ${AXT_FILE} =~ .*${COMMAND_PREFIX}.*-.*\.sh ]]; then
				local HELP_LINE=$(grep '^# HELP: ' ${AXT_FILE} | head -1)
>>>>>>> axt-help.sh
				if [[ ${HELP_LINE} ]]; then
					local HELP_TEXT="${HELP_LINE#\# HELP: }"
					if [[ ${HELP_TEXT} ]]; then
						local BASENAME="$(basename ${AXT_FILE} .sh)"
<<<<<<< HEAD
						local SUBCOMMAND="${BASENAME#${COMMAND_PREFIX}-}"
=======
						local SUBCOMMAND="${BASENAME##*-}"
>>>>>>> axt-help.sh
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
<<<<<<< HEAD
			print_help $((INDENT + MAX_SUBCOMMAND_LEN + 5)) "* " "${COMMAND_PREFIX}-${SUBCOMMAND}"
			((SUBCOMMAND_INDEX++))
		done
	fi
}

print_help 2 "" "axt"
=======
			local NEW_COMMAND_PREFIX=""
			if [[ ${COMMAND_PREFIX: -1} == "-" ]]; then
				NEW_COMMAND_PREFIX="${COMMAND_PREFIX}${SUBCOMMAND}-"
			else
				NEW_COMMAND_PREFIX="${COMMAND_PREFIX}-"
			fi
			print_help $((INDENT + MAX_SUBCOMMAND_LEN + 5)) "* " "${NEW_COMMAND_PREFIX}"
			((SUBCOMMAND_INDEX++))
		done
		return ${NUM_SUBCOMMANDS}
	fi
	return 0
}

COMMAND=""
COMMAND_PREFIX="axt"

if (( 0 < $# )); then
	while (( 0 < $# )); do
		COMMAND+="${COMMAND} ${1}"
		COMMAND_PREFIX="${COMMAND_PREFIX}-${1}"
		shift
	done
else	
	COMMAND_PREFIX="${COMMAND_PREFIX}-"
fi

print_help 2 "" "${COMMAND_PREFIX}"
NUM_SUBCOMMANDS=$?

if (( 0 < NUM_SUBCOMMANDS )); then
	if (( NUM_SUBCOMMANDS == 1 )); then
		FIND_PATTERN="'${COMMAND_PREFIX}.sh'"
		AXT_FILES=(`eval find ${AXT_PATH} -name ${FIND_PATTERN} -print`)
		if (( ${#AXT_FILES[@]} == 1 )); then
			USAGE_LINE=$(grep '^# USAGE: ' ${AXT_FILES[0]} | head -1)
			if [[ ${USAGE_LINE} ]]; then
				USAGE_TEXT="${USAGE_LINE#\# USAGE: }"
				if [[ ${USAGE_TEXT} ]]; then
					echo "  Usage: ${USAGE_TEXT}"
				else
					WARNINGS+=("axt subcommand ${FIND_PATTERN} has empty usage text.")
				fi
			fi
		else
			echo "AXT ERROR: command '${FIND_PATTERN}'' not found"
		fi
	fi
else
	if [[ ${COMMAND} ]]; then
		echo "AXT ERROR: No help found for ${COMMAND}."
	else
		echo "AXT_ERROR: No help found."
	fi
	exit
fi
>>>>>>> axt-help.sh

for WARNING in "${WARNINGS[@]}"
do :
	echo "AXT WARNING: ${WARNING}"
done

