#!/bin/sh

# HELP: axt git sinc <source file> <target file>

# check if we're in AXT environment
if [[ ! -v AXT_PATH ]] || [ -z "${AXT_PATH}" ]; then
	echo >&2 "AXT ERROR: Please execute $0 from axt"
	exit 1
fi


if (( $# == 2 )); then
	SOURCE_FULLFILE="$1"
	TARGET_FULLFILE="$2"

	SOURCE_BRANCH="$(echo "$SOURCE_FULLFILE" | cut -d':' -f 1)"
	SOURCE_FILE="$(  echo "$SOURCE_FULLFILE" | cut -d':' -f 2)"
	if [[ $SOURCE_BRANCH == $SOURCE_FILE ]]; then
	 	SOURCE_FILE=""
	fi

	TARGET_BRANCH="$(echo "$TARGET_FULLFILE" | cut -d':' -f 1)"
	TARGET_FILE="$(  echo "$TARGET_FULLFILE" | cut -d':' -f 2)"
	if [[ $TARGET_BRANCH == $TARGET_FILE ]]; then
	 	TARGET_FILE=""
	fi

	if [[ ! -z "$SOURCE_FILE" ]]; then
		if git cat-file -e $SOURCE_FULLFILE &>/dev/null; then
			if [[ ! -z "$TARGET_FILE" ]]; then
				if git cat-file -e $TARGET_FULLFILE &>/dev/null; then
					if [[ $SOURCE_FILE == $TARGET_FILE ]]; then
						if [[ ! -z "$(git --no-pager diff $SOURCE_FULLFILE $TARGET_FULLFILE)" ]]; then
							clear
							echo "Diff for '$SOURCE_FULLFILE' ==> '$TARGET_FULLFILE'"
							echo "         '$SOURCE_FILE' ==> '$TARGET_FILE'"
							echo ""
							echo ""
							git --no-pager diff $SOURCE_FULLFILE $TARGET_FULLFILE
							echo ""
							echo "Diff for '$SOURCE_FULLFILE' ==> '$TARGET_FULLFILE'"
							echo "         '$SOURCE_FILE' ==> '$TARGET_FILE'"
							read -p "(c)opy, (p)atch single chunks or (s)kip? " ACTION
							if [[ "$ACTION" == "c" ]]; then
								git checkout $SOURCE_BRANCH -- $SOURCE_FILE
								git restore --staged $TARGET_FILE
							elif [[ "$ACTION" == "p" ]]; then
								git checkout -p $SOURCE_BRANCH -- $SOURCE_FILE
								git restore --staged $TARGET_FILE
							fi
							if [[ "$ACTION" != "s" ]]; then
								echo ""
								echo ""
								echo "Current git status:"
								git status
								echo ""
								read -p "Press <Enter> to continue..." ENTER
							fi
						else
							echo "No diff for $SOURCE_FILE <-> $TARGET_FILE"
						fi
					else
						echo >&2 "AXT Error: Cannot handle rename diffs of '$SOURCE_FULLFILE' <--> '$TARGET_FULLFILE'"
						exit 1
					fi
				else
					echo >&2 "AXT ERROR: target file '$TARGET_FILE' specified but not in target branch '$TARGET_BRANCH'"
					exit 1
				fi
			else
				echo "File $SOURCE_FILE exists in $SOURCE_BRANCH but not in $TARGET_BRANCH"
				read -p "(c)opy or (s)kip " ACTION
				if [[ "$ACTION" == "c" ]]; then
					git checkout $SOURCE_FULLFILE
					git restore --staged $SOURCE_FILE
				fi
			fi
		else
			echo >&2 "AXT ERROR: source file '$SOURCE_FILE' specified but not in source branch '$SOURCE_BRANCH'"
			exit 1
		fi
	else
		if [[ ! -z "$TARGET_FILE" ]]; then
			if git cat-file -e $TARGET_FULLFILE &>/dev/null; then
				echo "File $TARGET_FILE exists in $TARGET_BRANCH but not in $SOURCE_BRANCH"
				read -p "(d)elete in $TARGET_BRANCH or (s)kip " ACTION
				if [[ "$ACTION" == "d" ]]; then
					git rm $TARGET_FULLFILE
				fi
			else
				echo >&2 "AXT ERROR: target file '$TARGET_FILE' specified but not in target branch '$TARGET_BRANCH'"
				exit 1
			fi
		else
			echo >&2 "AXT ERROR: neither source nor target file specified"
			exit 1
		fi
	fi
else
	echo >&2 "AXT ERROR: git sync needs source and target file"
	exit 1
fi
