
-----------------------------------------------------------------------------------------------------------------------

workspace "quickjs-msvc"
	-- Premake output folder
	location(path.join(".build", _ACTION))

	platforms { "x86", "x64", "arm32", "arm64"  } 

	-- Configuration settings
	configurations { "Debug", "Release" }

	filter "platforms:x86"
  	architecture "x86"
	filter "platforms:x64"
  	architecture "x86_64"  
	filter "platforms:arm32"
  	architecture "ARM"  
	filter "platforms:arm64"
  	architecture "ARM64"  

	filter "system:windows"
  	removeplatforms { "arm32" }  

	-- Debug configuration
	filter { "configurations:Debug" }
		defines { "DEBUG" }
		symbols "On"
		optimize "Off"

	-- Release configuration
	filter { "configurations:Release" }
		defines { "NDEBUG" }
		optimize "Speed"
		inlining "Auto"

	filter { "language:not C#" }
		defines { "_CRT_SECURE_NO_WARNINGS" }
		characterset ("MBCS")
		buildoptions { "/std:c++latest" }
		systemversion "latest"

	filter { }
		targetdir ".bin/%{cfg.longname}/"
		--defines { "WIN32", "_AMD64_", "__x86_64__" }
		exceptionhandling "Off"
		rtti "Off"
		--vectorextensions "AVX2"

  defines { "CONFIG_VERSION=\"2020-07-05\""}

-----------------------------------------------------------------------------------------------------------------------

project "quickjs"
	language "C"
	kind "StaticLib"
	files {
    "cutils.h",
		"cutils.c",
		"libregexp.c",
		"libunicode.c",
		"quickjs.c",
		"quickjs-libc.c",
		"libregexp.h",
		"libregexp-opcode.h",
		"libunicode.h",
		"libunicode-table.h",
		"list.h",
		"quickjs.h",
		"quickjs-atom.h",
		"quickjs-libc.h",
		"quickjs-opcode.h"
	}

-----------------------------------------------------------------------------------------------------------------------

project "qjsc"
	language "C"
	kind "ConsoleApp"
	links { "quickjs" }
	files {
		"qjsc.c"
	}

-----------------------------------------------------------------------------------------------------------------------

project "qjs"
	language "C"
	kind "ConsoleApp"
	links { "quickjs" }
	dependson { "qjsc" }
	files {
		"qjs.c",
		"repl.js",
		"repl.c"
	}

-- Compile repl.js and save bytecode into repl.c
prebuildcommands { "\"%{cfg.buildtarget.directory}/qjsc.exe\" -c -o \"../../repl.c\" -m \"../../repl.js\"" }
