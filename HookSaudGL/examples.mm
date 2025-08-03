//
// examples.mm
// DobbyHookGL
// Created by SaudGL on 03/08/2025.
// This just general examples ..
// Demonstrates usage of the BaseGetter static library APIs.
// Compile with: clang++ -std=c++17 -ObjC++ examples.mm -L/path/to/lib -lBaseGetter -o examples

#import <Foundation/Foundation.h>
#import "BaseGetter.h"
//******************************************************
//************ libBaseGetter.a EXAMPLES ****************
//******************************************************
void exampes(){
    // ------------------------------------------------------------
    // Example 1: Query a dylib’s ASLR slide
    // ------------------------------------------------------------
    // Returns slide (>= 0) on success, or -1 on error.
    const char *dylibName = "MyLibrary.dylib";
    intptr_t slide = BGGetImageSlide(dylibName);
    if (slide < 0) {
        NSLog(@"[Example] Failed to locate image '%s'", dylibName);
    } else {
        NSLog(@"[Example] Slide for %s = 0x%llx", dylibName, (long long)slide);
    }
    
    // ------------------------------------------------------------
    // Example 2: Check if ASLR/PIE is enabled in the main executable
    // ------------------------------------------------------------
    // Returns true if the main binary was built with PIE.
    if (BGHasASLR()) {
        NSLog(@"[Example] ASLR/PIE is enabled");
    } else {
        NSLog(@"[Example] ASLR/PIE is disabled");
    }
    
    // ------------------------------------------------------------
    // Example 3: Calculate an absolute address inside a dylib
    // ------------------------------------------------------------
    // Given a known offset (e.g. 0x1234) within the library,
    // compute slide + offset, or 0 on error.
    uintptr_t offset = 0x1234;
    uintptr_t absAddr = BGCalculateAddress(dylibName, offset);
    if (absAddr == 0) {
        NSLog(@"[Example] Could not calculate address for %s + 0x%zx", dylibName, offset);
    } else {
        NSLog(@"[Example] Absolute address = %p", (void*)absAddr);
    }
    // Retrieve the slide used for this calculation
    intptr_t lastSlide = BGGetCurrentSlide();
    NSLog(@"[Example] Last slide recorded = 0x%llx", (long long)lastSlide);
    
    // ------------------------------------------------------------
    // Example 4: Look up a symbol’s address by name
    // ------------------------------------------------------------
    // Returns 0 on error.
    const char *libcPath   = "/usr/lib/libc.dylib";
    const char *symbolName = "malloc";
    uintptr_t symAddr = BGGetSymbolAddress(libcPath, symbolName);
    if (symAddr == 0) {
        NSLog(@"[Example] Symbol %s not found in %s", symbolName, libcPath);
    } else {
        NSLog(@"[Example] %s in %s = %p", symbolName, libcPath, (void*)symAddr);
    }
    
    // ------------------------------------------------------------
    // Example 5: Work with the main executable’s slide & addresses
    // ------------------------------------------------------------
    // Get the main binary’s ASLR slide (image index 0)
    intptr_t mainSlide = BGGetMainExecutableSlide();
    if (mainSlide == 0) {
        NSLog(@"[Example] Error retrieving main executable slide");
    } else {
        NSLog(@"[Example] Main executable slide = 0x%llx", (long long)mainSlide);
        // Compute an address in the main executable at offset 0x1000
        uintptr_t mainAddr = BGGetMainAddress(0x1000);
        NSLog(@"[Example] Main address at +0x1000 = %p", (void*)mainAddr);
    }
    
    // ------------------------------------------------------------
    // Example 6: Validate a pointer
    // ------------------------------------------------------------
    // Heuristic check to see if a pointer lies in a plausible user‐land range.
    void *testPtr = (void*)0x200000000;
    if (BGIsValidAddress(testPtr)) {
        NSLog(@"[Example] Pointer %p is in a valid range", testPtr);
    } else {
        NSLog(@"[Example] Pointer %p is invalid or out of range", testPtr);
    }
}
