---
description: >-
  Looks the best is to install virtual machine on mbd computer to enable
  different users to experiment with the system
---

# Virtual box (oracle)

{% embed url="https://itsfoss.com/install-virtualbox-ubuntu/#installing-virtualbox-on-ubuntu-and-debian-based-linux-distributions" %}
make a safe environments for users to experiment without breaking down the main machine
{% endembed %}



{% embed url="https://medium.com/@gajbhiyedeepanshu/building-custom-vagrant-box-e6a846b6baca" %}
creation of virtual boxes can then be automated by vagrant
{% endembed %}

## # Notes on learning virtual box from Oracle

## Installing xubuntu 23.04

* Get the newest version of oracle virtual box
* Set the iso in the very beginning of the installation
* Go with unattended installation
* The first run cancelled, was doing some squashfs error,but worked on the second start
* put user ... with ... as a password do not use admin, is reserved

## Navigating the virtual box environment

* right control is reserved key for different operations
* \+ F switches out to the virtual machine
* \+ C scales the view to the window

## Setting a shared folder and functional clipboard

[link-to-video](https://www.youtube.com/watch?v=N4C5CeYfntE)\
This video shows how to install additions on host and also on guest\
also shows that you need to add the user to the group for the sharing of files\
needed to add vld to the sudo group from a root

afterwards the shared folder works, but drag and drop does not.\
[link to drag and drop troubleshooting](https://www.technewstoday.com/virtualbox-drag-and-drop-not-working/)

## Getting access to a usb

## Streaming sound out?

## Making snapshots of the virtual machine

Now I do have a clean install of xubunutu

So I want to save this state of the machine and then save the version where I installed all the other installed stuff.

## List of installed stuff

* wget (apt)
* curl (apt)
* pandoc (apt)
* R (looks there are some issues, but also a workaround using [r2u](https://eddelbuettel.github.io/r2u/#docker)
* R studio (from deb package [link-here](https://itslinuxfoss.com/install-r-rstudio-ubuntu-22-04/)
* imagemagick (apt)
* virtualenv [link-to-installation](https://virtualenv.pypa.io/en/stable/installation.html)
* csvkit (pip or [link-here](https://csvkit.readthedocs.io/en/latest/tutorial/1\_getting\_started.html#installing-csvkit) )
* conda ( [link to tutorial](https://www.hostinger.com/tutorials/how-to-install-anaconda-on-ubuntu/)
* yt-dlp (apt)
* golang-go (apt)
* gum (more complicated [link-from-github](https://github.com/charmbracelet/gum)
* open ssh-client ssh-server
* xrdp (apt)
* brave (snap)
* flatpack/flatpak
* docker (apt)
* nvim
* obs-studio (apt)
* fiji (need to download and unpack to be useful [link here](https://imagej.net/software/fiji/downloads) )
* ffmpeg (apt)
* net-tools (apt)

## Sharing the virtual machine with other people&#x20;

The finished virtual box can be shared with other people

Eventually, this is best circumvented using vagrant to create the same machine for each user by a script
