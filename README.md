# logshell
Starts a shell and logs it to a file. Requires bash, and either script or screen. Note: cat the log file back for full color.

# To install:
    git clone https://github.com/dogoncouch/logshell.git
    cd logshell
    ./setup.sh

Setup will install in `` /usr/local/bin `` if it has privileges there, `` ~/bin `` otherwise. In the latter case, you may need to update your PATH variable:
    
    echo PATH=$PATH:~/bin >> ~/.profile

# Usage information:
    Usage: logshell [-h] [-c {script|screen}] [-f <logfile>] [-s <shell>]

    Optional arguments:
      -h                          Print this help message
      -c {script|screen}          Command to use (script or screen)
      -f <logfile>                Output file (try default)
      -p <logpath>                Output path (do not use with -f)
      -s <shell>                  Shell to use

# Tips
If you set a command as your shell, logshell will execute it, log the output, and then exit. The following will start the quizlight program, log its output, and then log out of the system entirely so the test-taker can't do any tampering:

    logshell -s quizlight ; exit

Note: this only works with commands that output to standard output.
