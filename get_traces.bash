#!/bin/bash

urlprefix="https://data.caida.org/datasets/passive-2015/equinix-chicago/20150219-130000.UTC/equinix-chicago"
day="20150219"
directions=("dirA" "dirB")
extensions=("pcap.gz" "pcap.stats" "times.gz")
timestamps=(125911 130000 130100 130200 130300 130400 130500 130600 130700 130800 130900 131000 131100 131200 131300
            131400 131500 131600 131700 131800 131900 132000 132100 132200 132300 132400 132500 132600 132700 132800
            132900 133000 133100 133200 133300 133400 133500 133600 133700 133800 133900 134000 134100 134200 134300
            134400 134500 134600 134700 134800 134900 135000 135100 135200 135300 135400 135500 135600 135700 135800
            135900 140000 140100 140200)

# Retries a command a configurable number of times with backoff.
#
# The retry count is given by ATTEMPTS (default 5), the initial backoff
# timeout is given by TIMEOUT in seconds (default 1.)
#
# Successive backoffs double the timeout.
function with_backoff {
  local max_attempts=${ATTEMPTS-5}
  local timeout=${TIMEOUT-1}
  local attempt=0
  local exitCode=0

  while (( $attempt < $max_attempts ))
  do
    set +e
    "$@"
    exitCode=$?
    set -e

    if [[ ${exitCode} == 0 ]]
    then
      break
    fi

    echo "Failure! Retrying in $timeout.." 1>&2
    sleep $timeout
    attempt=$(( attempt + 1 ))
    timeout=$(( timeout * 2 ))
  done

  if [[ $exitCode != 0 ]]
  then
    echo "You've failed me for the last time! ($@)" 1>&2
  fi

  return $exitCode
}

let "size=${#directions[@]}*${#timestamps[@]}*${#extensions[@]}"
count=1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
mkdir -p ./traces

for direct in ${directions}; do
	for ts in ${timestamps}; do
		for ext in ${extensions}; do
			name="${direct}.${day}-${ts}.UTC.anon.${ext}"
			echo "# Fetching ${count}/${size}: $name"
			cd ./traces
			with_backoff curl --user pontarelli@ing.uniroma2.it:pont313 -O ${urlprefix}.${name}
			cd ${DIR}
			let "count=${count}+1"
		done
	done
done
