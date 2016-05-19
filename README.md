## Dotfiles for Patrick Davey

### My personal dotfiles.

Well, the bulk of this really is my vim configuration, but also contains
other dotfiles. I use [gnu-stow](https://www.gnu.org/software/stow/manual/stow.html) for symlinking the various files into place.

### Instructions

Well, my advice is to build up your own dotfiles little by little, but feel free to clone this repo and remove the bits you don't want.  To use gnu-stow itself.

1. Clone this repo
2. `$cd dotfiles`
3. $./install.sh

The install script will stow all the directories (except the junk_drawer and the .git).
