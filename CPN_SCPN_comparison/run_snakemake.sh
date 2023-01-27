#!/bin/bash

run_mode=$1

#live:
if [[ $run_mode == "live" ]]; then
snakemake --jobs 999 --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -c {cluster.cores}  -t {cluster.time} --mem={cluster.mem} -e {cluster.error} -o {cluster.output}"
elif [[ $run_mode == "touch" ]]; then
#touch
snakemake --touch
elif [[ $run_mode == "reason" ]]; then
#dry run with reasons
snakemake --jobs 999 --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -c {cluster.cores}  -t {cluster.time} --mem={cluster.mem} -e {cluster.error} -o {cluster.output}" -np --reason
elif [[ $run_mode == "dag" ]]; then
snakemake --jobs 999 --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -c {cluster.cores}  -t {cluster.time} --mem={cluster.mem} -e {cluster.error} -o {cluster.output}" -dag
else
#dry run:
snakemake --jobs 999 --cluster-config cluster.json --cluster "sbatch -p {cluster.partition} -c {cluster.cores}  -t {cluster.time} --mem={cluster.mem} -e {cluster.error} -o {cluster.output}" -np
fi


