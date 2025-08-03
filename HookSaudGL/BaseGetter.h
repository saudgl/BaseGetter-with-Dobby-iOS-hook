//
//  BaseGetter.h
//  BaseGetter
//
//  Created by SaudGL on 03/08/2025.
//

// BaseGetter.h
#ifndef BaseGetter_h
#define BaseGetter_h

#import <stdbool.h>
#import <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/// Returns the ASLR slide for a given image (e.g. "MyLib.dylib"),
/// or -1 if the image isn’t loaded or on error.
intptr_t BGGetImageSlide(const char *imageName);

/// Returns true if the main executable was built PIE (i.e. ASLR enabled).
bool BGHasASLR(void);

/// Given a library name and an offset within it, returns the
/// absolute address (slide + offset), or 0 on error.
/// example :  void * AnogsAddress = (void*)BGCalculateAddress("/anogs", 0x8a3323);
uintptr_t BGCalculateAddress(const char *libName, uintptr_t offset);

/// Returns the address of a symbol in a dylib (via dlopen/dlsym),
/// or 0 on error.
uintptr_t BGGetSymbolAddress(const char *libName, const char *symbolName);

/// Returns the slide of the main executable (image index 0), or 0 on error.
/// example: intptr_t BaseAddress =  BGGetMainExecutableSlide();
intptr_t BGGetMainExecutableSlide(void);

/// Given an offset in the main executable, returns (slide + offset),
/// or 0 on error.
/// example: intptr_t BassAddrWithOffset =  BGGetMainAddress(0x100adf018);// 0x100adf018 is target offset to get its full address
uintptr_t BGGetMainAddress(uintptr_t offset);

/// Returns the last‐queried slide (from BGCalculateAddress),
/// or 0 if none yet.
intptr_t BGGetCurrentSlide(void);

/// Simple heuristic to check whether a pointer lies in a plausible
/// user‐land range. Returns true if valid.
bool BGIsValidAddress(const void *addr);

#ifdef __cplusplus
}
#endif

#endif /* BaseGetter_h */

