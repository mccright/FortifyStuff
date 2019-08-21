#!/bin/bash
#  Cobbled together by Matt McCright for command line scans on Linux.
#
#  Licensed under the MIT (the "License").
#  You may not use this file except in compliance with the License.
#
# This script best used with JavaScript apps.
# There are other versions for Java & Python
#
# Usage:
# See usage() function below, or just run the script without parameters or run it with --help
#
usage()
{
    cat << EOF
 This script is used to simplify running individual Fortify SCA
 scans in a bash shell on Linux.

 usage:
 $0 --buildid BUILDID --targetfiles "your list of targeted files in quotes"

 OPTIONS:
   --buildid BUILDID  ... Fortify BuildID
   --targetfiles "list of targeted files"  ... Fortify-formatted list of files
                                               surrounded by quotes
   --debug    ...turn on additional output for problem-solving
   --help     ...this message

EOF
}

# This noglob is required so that the shell does not muck
# with your targetfiles input
set -o noglob
DEBUG=false
STARTTIMESTAMP=`date`
echo This scan started at: $STARTTIMESTAMP

# In a build server environment, you might want to
# specify the full path to Fortify executables constructed 
# from environment variables.
# Generic check for Fortify sourceanalyzer.
# Don't run if it is not in the path.
if ! command -v "sourceanalyzer" > /dev/null 2>&1
then
    echo "error: cannot find sourceanalyzer - abort" 1>&2
    exit 1
fi
# We know that sourceanalyzer is in the path
# so set a variable to the fully qualified path.
export SCA=`command -v "sourceanalyzer"`
if [ $DEBUG = true ]; then
    echo Using sca from:  $SCA
fi

# Check number of parameters. We must have 4,
# but the last string can add more.
if [ "$#" -lt 4 ]; then
   usage
   exit 1
fi

# parse arguments
while [ $# -gt 0 ]
do
    case $1 in
    --buildid)   export DIRTYBUILDID="$2";
        shift;;
    --targetfiles)   export DIRTYTARGETFILES=\""$2"\"; shift;;
    -buildid)   export DIRTYBUILDID="$2"; shift;;
    -targetfiles)   export DIRTYTARGETFILES=\""$2"\"; shift;;
    -debug)   export DEBUG=true; shift;;
    --help |-h) usage
                exit 0;;
           *)   break; ;;
    esac
    shift
done

if [ $DEBUG = true ]; then
    echo Tainted inputs produce:
    echo sca: $SCA -b $DIRTYBUILDID $DIRTYTARGETFILES
fi
# Replace each illegal character with an underscore in the BuildID
export BUILDID=$(echo "$DIRTYBUILDID" | sed 's%[\\\^!~&:/#@*+.-]%_%g')
# Remove each illegal character from the target file directives
export TARGETFILES=$(echo "$DIRTYTARGETFILES" | sed 's%[\\\^!&:#@+-]%%g')

# Maybe the input was only illegal characters and we removed them all?
if [[ $TARGETFILES = *[!\"]* ]]; then
    #echo TARGETFILES: $TARGETFILES
    if [ $DEBUG = true ]; then
        echo Scrubbed inputs are now:
        echo sca: $SCA -b $BUILDID $TARGETFILES
    fi
else
    echo "\$TARGETFILES consists of quotes only"
    echo "The TARGETFILES input was only illegal characters and we removed them all."
    echo "Exiting..."
    exit 1
fi

if [ $DEBUG = true ]; then
    # Get the currently-available RAM in Kilobytes
    AVAILABLE_MEM=$(cat /proc/meminfo | grep -i memavailable | awk '{print $2}')
    # Test that it is at least our minimum of 1000000K (or 1GB)
    if [ "$AVAILABLE_MEM" -lt 1000000 ]; then
        echo "Minimum memory for Fortify SCA scans is 1G, 1000M or 1000000K available"
        echo "This environment currently has: ${AVAILABLE_MEM}K"
        echo "Exiting..."
        exit 1
    else
        echo AVAILABLE_MEM: ${AVAILABLE_MEM}K, which meets our mimimum of 1000000K
    fi
fi

#exit 0
# Set up logs for 'translate' and 'scan' phases
export translateLog="-debug -logfile ./translate$BUILDID.log "
export scanLog="-debug -logfile ./scan$BUILDID.log "
export fprFile="$BUILDID.fpr"
if [ $DEBUG = true ]; then
    echo Doing a Fortify sourceanalyzer -clean with the following command:
    echo $SCA -b $BUILDID -clean
fi
# Do a sourceanalyzer 'clean'
$SCA -b $BUILDID -clean
ANALYSIS_RESULT=$?
if [ $ANALYSIS_RESULT -ne 0 ]; then
    echo "warning: sourceanalyzer returned a non-zero exit code."
    echo "         Something went wrong during the clean."
    ENDTIMESTAMP=`date`
    echo This scan started at: $STARTTIMESTAMP and ended with some problem at $ENDTIMESTAMP.
    echo Exiting...
    exit 1
fi
ANALYSIS_RESULT=0
if [ $DEBUG = true ]; then
    echo Doing a Fortify sourceanalyzer translate stage with the following command:
    echo $SCA $translateLog -b $BUILDID $TARGETFILES
fi
# Do a sourceanalyzer 'translate'
$SCA $translateLog -b $BUILDID $TARGETFILES
ANALYSIS_RESULT=$?
if [ $ANALYSIS_RESULT -ne 0 ]; then
    echo "warning: sourceanalyzer returned a non-zero exit code."
    echo "         Something went wrong. The following is grepped from the translate log:"
    echo "$(grep "^\[error\]:" ./translate$BUILDID.log 2> /dev/null)"
    ENDTIMESTAMP=`date`
    echo This scan started at: $STARTTIMESTAMP and ended with some problem at $ENDTIMESTAMP.
    echo Exiting...
    exit 1
fi
ANALYSIS_RESULT=0
echo $SCA $scanLog -b $BUILDID -scan -f $fprFile
# Do a sourceanalyzer 'scan'
$SCA $scanLog -b $BUILDID -scan -f $fprFile
ANALYSIS_RESULT=$?
if [ $ANALYSIS_RESULT -ne 0 ]; then
    echo "warning: sourceanalyzer returned a non-zero exit code."
    echo "         Something went wrong. The following is grepped from the scan log:"
    echo "$(grep "^\[error\]:" ./scan$BUILDID.log 2> /dev/null)"
    ENDTIMESTAMP=`date`
    echo This scan started at: $STARTTIMESTAMP and ended with some problem at $ENDTIMESTAMP.
    echo Exiting...
    exit 1
fi
ANALYSIS_RESULT=0
ENDTIMESTAMP=`date`
echo This scan started at: $STARTTIMESTAMP and ended at $ENDTIMESTAMP.
