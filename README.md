# BaseGetter-with-Dobby-iOS-hook
iOS Hook 
to get the base address of framwwork Example only: 
const char *dylibName = "/anogs";
void * add8A340 = (void*)BGCalculateAddress(dylibName, 0x8a340);

then to use it with dobby : 
DobbyHook((void*)add8A340, (void*)hook_fun, (void**)&orig_fun);

look at example file.
add to your project libBaseGetter
