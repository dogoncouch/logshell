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
