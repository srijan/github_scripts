#!/usr/bin/env bash

usage() {
  echo "Usage: $(basename "$0") [org/repo] [workflow_id]"
  echo "Example $(basename "$0") github/docs test.yml"
}

if [[ -z $1 ]];
then
  usage
  exit 1
fi
org_repo=$1

if [[ -z $2 ]];
then
  usage
  exit 1
fi
workflow_id=$2

# --paginate can be added below to get all results
runs=($(gh api --cache 10m repos/$org_repo/actions/workflows/$workflow_id/runs?status=success -q '.workflow_runs[] | .id'))

for run_id in "${runs[@]}"
do
  sleep 0.5
  echo $(( $(gh api --cache 10m repos/$org_repo/actions/runs/$run_id/timing -q '.run_duration_ms') / 60000 )) minutes
done
