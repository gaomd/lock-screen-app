Scripts to control Google Play
====

I use these scripts to control google play music while running in Safari. Mostly due to Chrome being my main browser and I don't want to make the script to heavy (running through a 100 tabs just to find the music player…).

Anyways, open your Terminal in the directory in which you've downloaded/cloned these files and run './build' to create apps out of the plain-text .applescript files. If you don't have Growl, the info script will fail to build, don't worry about that, you don't need it.

Next you'll need some application to set up your hotkeys. I personally have been using QuickSilver for years, and with the power that it gives me in chaining searches, I don't see why anybody would not use it ;). Essentially, any launcher that allows you to setup hotkeys for running apps will do the trick.

There's also two .applescript files for use in creating a **'service' in Automator**. Which you can subsequently tie up to a hotkey, for more info on this solution see http://hints.macworld.com/article.php?story=20110622061755509 which is where I got the basics for creating the scripts in this repo in the first place.

For **QuickSilver users**, by combining the power of chaining commands in a single hotkey you can have your hotkey swap the the previous/next song AND show the info on the new song in one fell swoop!! Based on this article http://blog.qsapp.com/post/6414891244/automate-quicksilver all you'll have to do is point QuickSilver to your 'next' app then hit the ','-key and point it to the 'info' app. Tie it up to a hotkey and Bob's your uncle :)