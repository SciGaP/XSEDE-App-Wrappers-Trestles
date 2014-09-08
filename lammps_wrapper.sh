#!/bin/sh
mv $1 .

module load lammps/1Aug14

mpirun_rsh -np 4 -hostfile $PBS_NODEFILE /opt/lammps/bin/lammps < in.friction

echo "LAMMPS_Simulation_Log=`pwd`/log.lammps"

exit 0
