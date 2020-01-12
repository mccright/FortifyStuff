#!/bin/bash

# Usage: This script should be sourced into your scripts to provide these logging functions
# Thanks to: https://github.com/cons3rt/test-asset-fortify-simple/blob/master/scripts/run_fortify.sh
#
# logger Options:
#  -i, --id              log the process ID too
#  -p, --priority <prio> mark given message with this priority
#  -s, --stderr          output message to standard error as well
#  -t, --tag <tag>       mark every line with this tag
#  -f, --file <file>     log the contents of this file
#  -h, --help            display this help text and exit
#  -S, --size <num>      maximum size for a single message (default 1024)
#  -n, --server <name>   write to this remote syslog server
#  -P, --port <port>     use this port for UDP or TCP connection
#  -T, --tcp             use TCP only
#  -d, --udp             use UDP only
#  -u, --socket <socket> write to this Unix socket
#  --                    End  the argument list.  This allows the message to start with a hyphen (-).
#
#        -s, --stderr
#           Output the message to standard error as well as to the system log.
#
#        -t, --tag tag
#           Mark every line to be logged with the specified tag.  The default tag is the  name
#           of the user logged in on the terminal (or a user name based on effective user ID).
#
# Here are some simplified examples for how this is used in your script
#!/bin/bash
#  source ~/bin/logit.sh
#  logTag="InScriptTesting"
#  logInfo "This is a test.  Logging an INFO message using ${thisScript}"
#  logWarn "This is a test.  Logging an WARN message using ${thisScript}"
#  logErr "This is a test.  Logging an ERROR message using ${thisScript}"
#
#

TIMESTAMP=$(date "+%Y-%m-%d-%H%M")
# Include a use-case-specific logTag in your script
logTag="logger"
thisScript="ScriptName: ${0}"
myLogDir="/home/${USER}/logs"
myLogFile="${myLogDir}/${logTag}-${TIMESTAMP}.log"

# Set up the log file
mkdir -p ${myLogDir}
chmod 700 ${myLogDir}
touch ${myLogFile}
chmod 644 ${myLogFile}

function logInfo() {
    logger -i -s -p syslog.info -t ${logTag} -- [INFO] "${1}"
    timeStamp=$(date "+%Y-%m-%d-%H:%M:%S")
    echo -e "${timeStamp} -- [INFO]: ${1}" >> ${myLogFile}
    echo -e "${timeStamp} -- [INFO]: ${1}"
}

function logWarn() {
    logger -i -s -p local3.warning -t ${logTag} -- [WARN] "${1}"
    timeStamp=$(date "+%Y-%m-%d-%H:%M:%S")
    echo -e "${timeStamp} -- [WARN]: ${1}" >> ${myLogFile}
    echo -e "${timeStamp} -- [WARN]: ${1}"
}

function logErr() {
    logger -i -s -p local3.err -t ${logTag} -- [ERROR] "${1}"
    timeStamp=$(date "+%Y-%m-%d-%H:%M:%S")
    echo -e "${timeStamp} -- [ERROR]: ${1}" >> ${myLogFile}
    echo -e "${timeStamp} -- [ERROR]: ${1}"
}

function logCrit() {
    logger -i -s -p local3.crit -t ${logTag} -- [CRITICAL] "${1}"
    timeStamp=$(date "+%Y-%m-%d-%H:%M:%S")
    echo -e "${timeStamp} -- [CRITICAL]: ${1}" >> ${myLogFile}
    echo -e "${timeStamp} -- [CRITICAL]: ${1}"
}

