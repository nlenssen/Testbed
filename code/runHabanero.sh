#!/bin/sh
#
# Script to run the testbed on the Habanero cluster. Useful for users that
# do not have local access to MATLAB
#
# Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
# D+A Testbed Version: 1.0.0 (December 6, 2017)
#
#
#SBATCH -A edu                   # The account name for the job.
#SBATCH -J dnaTestbed            # The job name.
#SBATCH -t 5:00                  # The time the job will take to run.
#SBATCH -N 1                     # The number of cores needed.

module load matlab

echo "Launching an Matlab run"
date

#define parameter lambda
PLOTTING=1
PLOTDIR='figures'
DATADIR='output'

# call the matlab master function passing in necessary inputs
matlab -nosplash -nodisplay -nodesktop -r "fullProcedure($PLOTTING,'$PLOTDIR','$DATADIR')"

# End of script