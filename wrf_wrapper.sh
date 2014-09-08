#!/bin/bash
#----------------------------------------------------
# Execute WRF for a case study 
#----------------------------------------------------

#Copy the Static Table files
cp /home/ogce/WRFV3.5.1/run/RRTM_DATA ./
cp /home/ogce/WRFV3.5.1/run/GENPARM.TBL ./
cp /home/ogce/WRFV3.5.1/run/MPTABLE.TBL ./
cp /home/ogce/WRFV3.5.1/run/VEGPARM.TBL ./

# Copy the case study 30KM data files 
#cp /home/ogce/case_studies/jan2000/namelist.input ./
#cp /home/ogce/case_studies/jan2000/wrfbdy_d01 ./
#cp /home/ogce/case_studies/jan2000/wrfinput_d01 ./

# Load the required modules
module load netcdf

#Run WRF Binary built wth PGI compilers and NETCDF 4.3
mpirun_rsh -np 64 -hostfile $PBS_NODEFILE /home/ogce/apps/wrf.exe

#cp /home/ogce/case_studies/jan2000/wrfout_d01_2000-01-24_12\:00\:00 ./
#cp /home/ogce/case_studies/jan2000/rsl.out.0000 ./

#Verify if WRF ran succeesfully
if grep --quiet "SUCCESS COMPLETE WRF" rsl.out.0000; then
  echo WRF Completed Successfully
  
  echo "WRF_Output=`pwd`/wrfout_d01_2000-01-24_12:00:00"
  echo "WRF_Execution_Log=`pwd`/rsl.out.0000"
  
  exit 0
else
  echo WRF Execution Failed, Check rsl out and err files
  # Exit with a non-zero exit code so application failure can be detected correctly
  exit 1
fi

