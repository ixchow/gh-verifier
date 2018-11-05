This is the verifier code used by the backend for [http://golf.horse](http://golf.horse).
```
Usage:
./verifier <wordlist> <program.js> [v8 options]
```

If you would like a verifier that doesn't require building v8 from source, try [gh-verifier-lite](https://github.com/ixchow/gh-verifier-lite) -- it's not as effectively sandboxed, but if you're not actively trying to cheat you probably won't notice.

This verifier code builds against the v8 monolithic library, which you can create more or less like this (assuming you have the v8 source in $HOME/v8/v8 and depot_tools in $HOME/depot_tools):

```
#if you don't have depot_tools yet:
# git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
# export PATH=$PATH:/path/to/depot_tools
# ... more here from the docs that I haven't gotten to yet

export PATH=$PATH:$HOME/depot_tools
cd v8/v8

#Use https://omahaproxy.appspot.com/ to figure out latest stable chrome version, grab related branch:
git checkout -b remotes/branch-heads/7.0

#Use this to start a build
tools/dev/gm.py x64.release

#But then ^C it and edit out/x64.release/args.gn to add:
use_custom_libcxx = false
v8_use_external_startup_data = false
v8_monolithic = true

#then do:
ninja -C out/x64.release v8_monolith
```

Now you should have an ```out/x64.release/obj/libv8_monolith.a```; update the Makefile to point ```V8DIR``` to the right spot and you should be good to build.

