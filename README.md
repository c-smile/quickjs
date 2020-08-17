

# QuickJS Javascript Engine 

Version: 2020-07-05

Authors: Fabrice Bellard and Charlie Gordon

Ported from https://bellard.org/quickjs/ 

By Andrew Fedioniouk (a.k.a. c-smile)

This version is Microsoft Visual C++ compatible/compileable.

# Build using Microsoft Visual Studio (2017 or 2019)

Prerequisite: **premake5** - [download](https://premake.github.io/download.html) and install it.

Then go to /win folder and run premake-vs2017.bat or premake-vs2019.bat . 

It will generate .build/vs2017/quickjs-msvc.sln and open it in Microsoft Visual Studio.

Press F5 to compile it and run qjs - interactive JS command line application.

