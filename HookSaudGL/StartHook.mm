//
//  StartHook.cpp
//  DobbyHookGL
//
//  Created by SaudGL on 03/08/2025.
//  @Bubg_dev
#import <Foundation/Foundation.h>
#import "StartHook.hpp"
#import "dobby.h"
#import "BaseGetter.h"
#import <unistd.h>
#import "Hook.h"
//   ****** DO NOT USE CURRENT HOOK ITS JUST EXAMPLE ******

// frist get your target function from IDA or Ghidra or any disassembler from your target Framewrok like jsut example
// be carefull with Ghidra may not match the function so best use IDA
//let say our target hook is 0x8a340 in anogs its will be like:
// لنفترض ان هدفنا هو هوك انجوس في لعبه ما نحتاج اولا نموذج للداله وداله مزيفه والنموذج نحصل عليه من  برنامج  ida
const char *dylibName = "/anogs";
void * add8A340 = (void*)BGCalculateAddress(dylibName, 0x8a340);
__int64_t __fastcall (*orig_fun8a340)(__int64_t a1, const char *a2, const char *a3);//ignore warning
__int64_t __fastcall hook_fun8a340(__int64_t a1, const char *a2, const char *a3)//ignore warning
{
    // here do wahtever you like ...
    // you can just do return;
    // or print args a1 , a2 ,a3 like :
    NSLog(@"[DobbyHookGL] The hooked values is : a1 = %llx ,a2 = %s , a3= %s",a1,a2,a3);
    sleep(60000);
    // هنا يكون الهوك يمكنك طباعه القيم القادمه ثم بعدها ترجع الداله الاساسية كما كانت كان لم شي يكن او تقوم بارجعاكاملا
    return orig_fun8a340(a1,a2,a3);
}
//-------------------------------------
// main exec example like ShadowTrc...
//-------------------------------------
void * mainAddradf018 = (void*)BGGetMainAddress(0x100adf018);
uint __fastcall(*orig_1029d4744)(int param_1);
uint __fastcall hook_1029d4744(int param_1){
    // do what ever here .. you can return; or return orignal ...
    return orig_1029d4744(param_1);
}

//-------------------------------------
// start hooking ..
//-------------------------------------
__attribute__((constructor ()))
static void ___main(void) {
    //put timer if you need
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //start hook your address
        NSLog(@"[DobbyHookGL]  hook strated .. ");
        DobbyHook((void*)add8A340, (void*)hook_fun8a340, (void**)&orig_fun8a340);// hide jb for temp
        DobbyHook(mainAddradf018, (void*)hook_1029d4744, (void**)orig_1029d4744);//main exec ShadowTr.. example
    });
    
    
    
}



