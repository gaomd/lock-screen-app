# Lock Screen

The missing Lock Screen app for Spotlight of macOS.

## Introduction

Both LaunchBar and Alfred have lock screen functionality built-in for convenience, it's Spotlight's turn now:

![Lock Screen app in Spotlight](docs/assets/spotlight-view.png)

Or just locking screen up directly from Finder:

![Lock Screen app in Finder](docs/assets/finder-view.png)

## Installation

### No, you don't need this!

Available since macOS 10.13 High Sierra, Apple has built-in a lock screen shortcut: Command-Control-Q.

Also available under Apple menu => Lock Screen.

### For macOS 10.13 High Sierra and later

Download a pre-built .dmg at [releases section](https://github.com/gaomd/lock-screen-app/releases), or build by yourself:

1. [Extract the downloaded master zip](https://github.com/gaomd/lock-screen-app/archive/master.zip)
2. Build the *Lock Screen.app* by double clicking the `build.command` script
3. Copy the *Lock Screen.app* file in the *dist* directory to anywhere you'd like (*Applications* directory preferred)

### For macOS 10.12 Sierra and earlier

Unsupported! Please refer to [pre-macos-hs](https://github.com/gaomd/lock-screen-app/tree/pre-macos-hs) branch for more information.

## Acknowledgments

[gaomd/lock-screen-app](https://github.com/gaomd/lock-screen-app) was originally forked from [windgazer's WALS repository](https://github.com/windgazer/WALS), only kept lock screen parts with improvements.
