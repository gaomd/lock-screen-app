#import <objc/runtime.h>
#import <Foundation/Foundation.h>

//Code found on http://apple.stackexchange.com/questions/80058/lock-screen-command-one-liner
int main () {
    NSBundle *bundle = [NSBundle bundleWithPath:@"/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu"];

    Class principalClass = [bundle principalClass];

    id instance = [[principalClass alloc] init];

    [instance _lockScreenMenuHit:NULL];

    return 0;
}