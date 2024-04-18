#!/bin/csh -f

cd /home/016797092/273/273prj/uvm-ifft

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/apps/synopsys/VCS_current/vcs/R-2020.12/linux/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

