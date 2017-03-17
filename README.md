# logshell
Starts a shell and logs it to a file. Requires bash, and either script or screen. Note: cat the log file back for full color.

# To install:
<pre>git clone https://github.com/dogoncouch/logshell.git
cd logshell
./setup.sh</pre>

Setup will install in /usr/local/bin if it has privileges there, ~/bin otherwise. You may need to add ~/bin to your path in ~/.profile:
<pre>echo PATH=$PATH:~/bin >> ~/.profile</pre>

# Usage information:
<pre>Usage: logshell [-h] [-c {script|screen}] [-f &lt;logfile&gt;] [-s &lt;shell&gt;]

Optional arguments:
  -h                          Print this help message
  -c {script|screen}          Command to use (script or screen)
  -f &lt;logfile&gt;                Output file (try default)
  -p &lt;logpath&gt;                Output path (do not use with -f)
  -s &lt;shell&gt;                  Shell to use</pre>

# Tips
If you set a command as your shell, logshell will execute it, log the output, and then exit. The following will start the quizlight program, log its output, and then log out of the system entirely so the test-taker can't do any tampering:

    logshell -s quizlight ; exit

Note: this only works with commands that output to standard output.
