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

echo Installing logshell
if [ -w /usr/bin ]; then
    echo Write privileges in /usr/bin, installing there.
    cp logshell.sh /usr/bin/logshell
    if [ -w /etc ]; then
        if [ -r /etc/logshell.conf ]; then
            echo Existing config file found at:
            echo /etc/logshell.conf
        else
            echo Installing config template at:
            echo /etc/logshell.conf
            cp -n logshell.conf /etc/logshell.conf
        fi
    fi
else
    echo No write privileges in /usr/bin:
    echo installing in ~/bin.
    mkdir -p ~/bin
    cp logshell.sh ~/bin/logshell
    if [ -r ~/.config/logshell.conf ]; then
        echo Existing config file found at:
        echo ~/.config/logshell.conf
    else
        echo Installing config template at:
        echo ~/.config/logshell.conf
        mkdir -p ~/.config
        cp -n logshell.conf ~/.config/logshell.conf
    fi
    echo Note: Add ~/bin to PATH variable
    echo "(echo PATH=\$PATH:~/bin >> ~/.profile)"
    echo in ~/.profile.
fi
