#!/usr/bin/env bash

if [[ -z $1 ]];
then
  exit 1
fi
org_repo=$1

if [[ -z $2 ]];
then
  size=0
else
  size=$2
fi

artifacts=($(gh api --paginate repos/$org_repo/actions/artifacts | jq --argjson size "${size}" '.artifacts[] | select(.size_in_bytes > $size) | .id'))

for artifact_id in "${artifacts[@]}"
do
  echo "Deleting Artifact Id $artifact_id"
  gh api repos/$org_repo/actions/artifacts/$artifact_id -X DELETE >/dev/null
done