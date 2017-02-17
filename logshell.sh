#!/bin/bash

# MIT License
# 
# Copyright (c) 2017 Dan Persons
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# logshell - Starts a shell with logging.
# WARNING! Major issue with programs that use full screen output,
# Log files can become corrupt and/or fill up quickly.

# Basic config in case no file is present:
# Command to use - current options are "script -f" and "screen -l"
COMMAND="script -f"
# Log file
LOGPATH=~/log/lsh
LOGFILE=bash-log.$(date -u +%Y%m%d-%H%M%S)-UTC.${USER}@${HOSTNAME:-$(hostname)}.$$.${RANDOM}.log

# Read global config file:
if [ -r /etc/logshell.conf ]; then
    . /etc/logshell.conf
fi
# Read local user config file:
if [ -r ~/logshell.conf ]; then
    . ~/logshell.conf
fi

#Print a warning:
echo
echo ======== WARNING! ========
echo
echo Don\'t use vim, clear, less, or anything that manages the whole screen!
echo Files can get corrupted and/or fill up quickly.
echo
echo ==========================
echo

#Make sure log file can be written:
if [ ! -w $LOGPATH ]; then
    echo Trying to create path for log file.
    mkdir -p $LOGPATH
fi

#Execute the command:
$COMMAND $LOGPATH/$LOGFILE

#Print the size of the closed log file after the shell exits:
echo
echo Size of log file:
du -sh $LOGPATH/$LOGFILE
echo
