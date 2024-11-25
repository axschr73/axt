#!/bin/bash

# HELP: View short list of git commits

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi
command -v peco  >/dev/null 2>&1 || { echo >&2 "AXT ERROR: axt git log requires helper 'peco'!"; exit 1; }


function handle_commit()
{
	local COMMIT=$1
	while true; do
		COMMIT_FILE=$(git --no-pager diff-tree --no-commit-id --name-only -r ${COMMIT} | peco)
		if [[ ! -z "${COMMIT_FILE}" ]]; then
			git diff ${COMMIT}~ ${COMMIT} ${COMMIT_FILE}
		else
			break
		fi
	done
}

function handle_full_log()
{
	while true; do
		COMMIT=$(git log --date=iso --pretty="%cd %h %s" --no-merges | cut -d " " -f 1,2,4,5-99 | peco | cut -d " " -f3)

		if [[ ! -z "${COMMIT}" ]]; then
			handle_commit ${COMMIT}
		else
			break
		fi
	done
}

function handle_single_file()
{
	while true; do
		COMMIT=$(git log --date=iso --pretty="%cd %h %s" --no-merges --follow -- $1 | cut -d " " -f 1,2,4,5-99 | peco | cut -d " " -f3)

		if [[ ! -z "${COMMIT}" ]]; then
			handle_commit ${COMMIT}
		else
			break
		fi
	done
}

function handle_paths()
{
	while true; do
		COMMIT=$(git log --date=iso --pretty="%cd %h %s" --no-merges -- $@ | cut -d " " -f 1,2,4,5-99 | peco | cut -d " " -f3)

		if [[ ! -z "${COMMIT}" ]]; then
			handle_commit ${COMMIT}
		else
			break
		fi
	done
}

function handle_commit_list()
{
	while true; do
		COMMIT=$(git log --date=iso --pretty="%H %cd %h %s" --no-merges -- $@ | grep ${@/#/-e} | cut -d " " -f 1,2,3,5,6-99 | peco | cut -d " " -f3)

		if [[ ! -z "${COMMIT}" ]]; then
			handle_commit ${COMMIT}
		else
			break
		fi
	done
}

PATHS=()
FILES=()

# Parse patterns and split into paths and files
for PATTERN in "$@"; do
	PATTERN_PATH=""
	PATTERN_FILE=""
	if [[ $PATTERN =~ */* ]]; then
		PATTERN_PATH=${PATTERN%/*}
		PATTERN_FILE=${PATTERN##*/}
		if [[ $PATTERN_FILE == "*" ]]; then
			PATTERN_FILE=""
		fi
	else
		PATTERN_PATH=$PATTERN
	fi

	if [[ -z "${PATTERN_FILE}" ]]; then
		PATHS+=($PATTERN_PATH)
	else
		FULL_FILES=(`eval find ${AXT_GIT_REPO_PATH}/${PATTERN_PATH} -name '${PATTERN_FILE}' -print`)
		for FULL_FILE in "${FULL_FILES[@]}"; do
			FILES+=(${FULL_FILE#${AXT_GIT_REPO_PATH}/})
		done
	fi
done

if (( 0 < $# )); then
	if (( 0 < ${#PATHS[@]} )) || (( 0 < ${#FILES[@]} )); then
		if (( 0 == ${#PATHS[@]} )) && (( 1 == ${#FILES[@]} )); then
			handle_single_file ${FILES[0]}
		elif (( 0 < ${#PATHS[@]} )) && (( 0 == ${#FILES[@]} )); then
			handle_paths ${PATHS[@]}
		else
			echo "Filtering commit list for given pattern(s)..."

			COMMIT_HASHES=()

			if (( 0 < ${#PATHS[@]} )); then
				echo "  - collecting commits for given path(s)..."
				COMMIT_HASHES+=($(git log --pretty="%H" --no-merges -- ${PATHS[@]}))
			fi

			if (( 0 < ${#FILES[@]} )); then
				echo "  - collecting commits for given files(s)..."
				FILE_INDEX=0
				NUM_FILES=${#FILES[@]}
				while (( FILE_INDEX < NUM_FILES )); do
					echo "    - collecting commits for file $((${FILE_INDEX}+1))/${NUM_FILES}: '${FILES[FILE_INDEX]}'..."
					COMMIT_HASHES+=($(git log --pretty="%H" --no-merges --follow -- ${FILES[FILE_INDEX]}))
				  ((FILE_INDEX++))
				done
			fi

			SORTED_UNIQUE_HASHES=($(echo "${COMMIT_HASHES[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

			handle_commit_list ${SORTED_UNIQUE_HASHES[@]}
		fi
	else
		echo >&2 "AXT ERROR: no files matching pattern(s) found"
	fi
else
	handle_full_log
fi
