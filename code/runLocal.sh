#!/bin/bash

# Script to run the testbed on a local machine. Note that matlab must be
# correctly added to the PATH variable

# Author: Nathan Lenssen, Columbia University (lenssen@ldeo.columbia.edu)
# D+A Testbed Version: 1.0.0 (December 6, 2017)


PLOTTING=1
PLOTDIR='figures'
DATADIR='output'

matlab -nosplash -nodisplay -nodesktop -r "fullProcedure($PLOTTING,'$PLOTDIR','$DATADIR')"