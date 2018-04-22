#!/bin/bash

# MIT License
# 
# Copyright (c) 2017 Dan Persons <dpersonsdev@gmail.com>
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

# logshell v0.3-beta - Starts a shell with logging.

# WARNING: Issue with programs that use full screen output;
# Log files can become difficult to read.

VERSION="0.5"

usage() {
    echo "Usage: ${0##*/} [-hvo] [-c {script|screen}] [-f <logfile>] [-s <shell>] [-e <file>]"
    echo
    echo "Optional arguments:"
    echo "  -h                      Print this help message"
    echo "  -v                      Print the version number"
    echo "  -o                      Strip escape sequences (and color) from output"
    echo "  -e <file>               Strip escape sequences from an existing file"
    echo "  -c [script|screen]      Command to use (script or screen)"
    echo "  -f <logfile>            Output file (try default)"
    echo "  -p <logpath>            Output path (do not use with -f)"
    echo "  -s <shell>              Shell to use (or command to execute)"
}

# Basic config in case no file is present:
# Command to use - current options are "script -f" and "screen -L"
COMMAND="script -f"
# Shell to use:
LSHELL="$SHELL"
# Log file
LOGPATH=~/.local/log/logshell
LOGFILE="shell.$(date -u +%Y%m%d-%H%M%S)-UTC.${USER}@${HOSTNAME:-$(hostname)}.$$.${RANDOM}.log"

# Read local user config file:
if [ -r ~/.config/logshell.conf ]; then
    . ~/.config/logshell.conf
else
    mkdir -p ~/.config
    if [ -f ~/.local/share/logshell/logshell.conf ]; then
        cp -n ~/.local/share/logshell/logshell.conf ~/.config
        . ~/.config/logshell.conf
    elif [-f /usr/local/share/logshell/logshell.conf ]; then
        cp -n /usr/local/share/logshell/logshell.conf ~/.config
        . ~/.config/logshell.conf
    fi
fi

while getopts ":c:f:p:s:e:ovh:" o; do
    case "${o}" in
        c)
            if [ "$OPTARG" = "script" ]; then
                COMMAND="script -f"
            fi
            if [ "$OPTARG" = "screen" ]; then
                COMMAND="screen -L"
            fi
            ;;
        f)
            LOGPATH=''
            LOGFILE="${OPTARG}"
            ;;
        p)
            LOGPATH="${OPTARG}"
            ;;
        s)
            LSHELL="${OPTARG}"
            ;;
        o)
            FORMATTING=1
            ;;
        e)
            perl -pi.alt -e 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' "${OPTARG}"
            exit 0
            ;;
        v)
            echo logshell-$VERSION
            exit 0
            ;;
        h)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

# Print a warning:
echo
echo ======== WARNING! ========
echo
echo Don\'t use vim, clear, less, or anything that manages the whole screen.
echo Output file can be difficult to read.
echo
echo ==========================
echo

# Prepare output path, make sure log path can be written:
if [ -n "$LOGPATH" ]; then
    FULLPATH="$LOGPATH/$LOGFILE"
    if [ ! -w "$LOGPATH" ]; then
        echo "Trying to create path for log file: $LOGPATH".
        mkdir -p "$LOGPATH"
    fi
else
    FULLPATH="$LOGFILE"
fi

# Execute the command:
SHELL="$LSHELL" $COMMAND "$FULLPATH"

# Strip special characters from output:
if [ $FORMATTING ]; then
    perl -pi.alt -e 's/\e([^\[\]]|\[.*?[a-zA-Z]|\].*?\a)//g' $FULLPATH
fi

# Print the size of the closed log file after the shell exits:
echo
echo Size of log file:
du -sh "$FULLPATH"
if [ $FORMATTING ]; then
    echo
    echo Size of unformatted log file:
    du -sh "$FULLPATH.alt"
fi
