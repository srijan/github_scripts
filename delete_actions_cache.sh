#!/usr/bin/env bash

if [[ -z $1 ]];
then
  exit 1
fi
org_repo=$1

# Get cache ids
cache_ids=($(gh api repos/$org_repo/actions/caches | jq '.actions_caches[] | .id'))

for cache_id in "${cache_ids[@]}"
do
  echo "Deleting cache_id $cache_id"
  gh api repos/$org_repo/actions/caches/$cache_id -X DELETE >/dev/null
done
