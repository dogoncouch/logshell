# logshell
Starts a shell and logs it to a file.

# To install:
<pre>git clone https://github.com/dogoncouch/logshell
cd logshell
./setup.sh</pre>

Setup will install in /usr/bin if it has privileges there, ~/bin otherwise. You may need to add ~/bin to your path in ~/.profile:
<pre>echo PATH=$PATH:~/bin >> ~/.profile</pre>

# Usage information:
<pre>Usage: logshell [-c {script|screen}] [-f <logfile>] [-s <shell>] [-h]

Optional arguments:
  -h                          Print this help message
  -c [script|screen]          Command to use (script or screen)
  -f <logfile>                Output file (try default)
  -p <logpath>                Output path (do not use with -f)
  -s <shell>                  Shell to use</pre>
