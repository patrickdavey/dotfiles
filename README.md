## Dotfiles for Patrick Davey

### My personal dotfiles.

Well, the bulk of this really is my vim configuration, but also contains
other dotfiles. I use [gnu-stow](https://www.gnu.org/software/stow/manual/stow.html) for symlinking the various files into place.

### Prerequisites

1. The directory `~/.config` should already exist (it probably will unless you're really starting from scratch)
2. [gnu-stow](https://www.gnu.org/software/stow/manual/stow.html) must be installed on your machine.


### Instructions

Well, my advice is to build up your own dotfiles little by little, but feel free to clone this repo and remove the bits you don't want.  To use gnu-stow itself.

    # Clone this repo
    $ git clone https://github.com/patrickdavey/dotfiles.git
    $ cd dotfiles

    # Run the install script
    $./install.sh

The install script will stow all the directories (except the junk_drawer and the .git).
