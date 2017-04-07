# kustom-window-title

If you use [KDE](https://www.kde.org/), you can use this script to set custom window titles for any windows. The custom titles you set will persist even when the application controlling the window tries to update its title.

## Installation

1. Install dependencies: 
    * [fish shell](https://fishshell.com/)
1. Clone this repository to a local location
1. Set up keyboard shortcut
    1. Right click on the "Kickoff Application Launcher" and choose "Edit Applications..."
    1. Select the "Utilities" item
    1. Click "New Item"
    1. For item name, enter `kustom-window-title` and click "Ok"
    1. In the "Command" field, browse to select the file `kustom-window-title.sh` within this repository that you cloned. 
    1. In the "Advanced" tab, click to set a shortcut key of your choosing. 
    1. Click "Save" and exit the KDE Menu Editor

## Usage

1. Active the script with the shortcut key you set up during installation.
1. A dialog will pop up prompting you to set a custom window title.
1. To remove your custom title and revert the window back to its original state, activate the script again but press `Esc` instead of entering a title. Then, do something to the application controlling the window to get it to update it's title (e.g. open a new tab, etc).

## Credits

Some of this code was originally written by [Owen_R](http://unix.stackexchange.com/users/119208/owen-r) in an excellent answer to this [Stack Exchange question](http://unix.stackexchange.com/a/209338/11544).