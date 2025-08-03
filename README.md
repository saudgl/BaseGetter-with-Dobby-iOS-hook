# BaseGetter-with-Dobby-iOS-hook
iOS Hook JailBreak only .> **Note:** This is intended **only** for jailbroken iOS environments.
A tiny utility for jailbroken iOS devices that makes it easy to:
- **Retrieve** the base address of any loaded dynamic library (dylib/framework)
- **Retrieve** the base address of the main executable
- **Hook** functions using [Dobby][]


## Requirements

- A **jailbroken** iOS device or simulator
- [Dobby][] hooking framework integrated into your project
- Xcode (tested with Xcode 12+)
- C++17 or later for building the static libr

## Installation

1. **Add** (`libBaseGetter.a` and the `BaseGetter.h` header) and (`libdobby.a` and `dobby.h`) to your Xcode project.
2. incldue #import "BaseGetter.h" and #import "dobby.h" in your target hook page.

## useage
- to get the base address of framwwork Example only: 
- const char *dylibName = "/anogs";
- void * add8A340 = (void*)BGCalculateAddress(dylibName, 0x8a340);
- 
- then to use it with dobby : 
- DobbyHook((void*)add8A340, (void*)hook_fun, (void**)&orig_fun);
- 
- to get base address for man exec : 
- void * mainAddradf018 = (void*)BGGetMainAddress(0x100adf018);
- 
- look at example file.
- add to your project libBaseGetter
