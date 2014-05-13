Lock Screen
====

> *WARNING* For Mavericks users, it is not recommended to use any of these scripts for now :(
> 
> Due to changes in the way OSX Mavericks runs its screensaver my latest script may lead to strange behavior, requiring you > to to do a hard-reset after getting back to your screen. Since I'm using Bartender my previous Universal Access method
> has gone untested for a while, so proceed with care and if you have feedback on either method, please let me know or
> fork!!

This app allows you to lock your Mac OSX screen. It relies that on two important settings:
+ '**System Preferences**'/'**Universal Access**' check the '**Enable access for assistive devices**' checkbox.
+ '**Keychain Access**'/'**Preferences**' check the '**Show keychain status in menu bar**' checkbox.

This script makes use of the '*access for assistive devices*' to open up the menu bar items and search the menu's for a menu item labeled '*Lock Screen*'. When found the script activates this menu-item, causing your screen to get locked.
