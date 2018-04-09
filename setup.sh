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

if [ ${UID} = 0 ];then
    USRBASE=/usr/local
    echo Installing logshell globally
    echo Base dir: /usr/local
else
    USRBASE=~/.local/
    echo Installing logshell locally
    echo Base dir: ~/.local
fi

mkdir -p "${USRBASE}/bin"
cp logshell.sh "${USRBASE}/bin/logshell"

echo Installing documentation
mkdir -p "${USRBASE}/share/man/man1"
cp doc/logshell.1 "${USRBASE}/share/man/man1"
mkdir -p "${USRBASE}/share/doc/logshell"
cp README.md LICENSE CHANGELOG.md "${USRBASE}/share/doc/logshell"
mkdir -p "${USRBASE}/share/logshell"
cp logshell.conf "${USRBASE}/share/logshell/logshell.conf"
