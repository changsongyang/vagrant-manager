* **NOTICE:** Due to some issues with the most recent versions, [2.4.1](https://github.com/lanayotech/vagrant-manager/releases/tag/2.4.1) is recommended until further notice*

---

Looking for the Windows version? Check out [Vagrant Manager for Windows](https://github.com/lanayotech/vagrant-manager-windows)

# Vagrant Manager for OS X

Vagrant Manager is an OS X status bar menu app that lets you manage all of your vagrant machines from one central location.
More information is available at http://vagrantmanager.com/

![demo.gif](http://vagrantmanager.com/demo.gif)

## Downloads
Download Vagrant Manager from the [GitHub Releases Page](https://github.com/lanayotech/vagrant-manager/releases)

## Installation Notes
* Vagrant Manager can automatically detect most machines, undetected machines will require manual configuration via bookmarks.
* Make sure that you have VirtualBox and Vagrant installed, and the `VBoxManage` and `vagrant` commands are in your path so that Vagrant Manager can execute them. If you use Parallels, ensure the `prlctl` command is also in your path.
* Currently, vagrant machines must already be initialized in order for Vagrant Manager to detect them. Make sure you have run vagrant init on any machine you want to appear in Vagrant Manager. Once Vagrant Manager has detected a machine, you can bookmark it so that it will not disappear when you destroy the machine. You can also manually add a bookmark and specify the path to your Vagrantfile.
* Vagrant Manager requires OS X 10.8 Mountain Lion or higher

## Contributing to Vagrant Manager

We love code contributions! If you would like to contribute, here are some notes and guidlines:

* All development happens on the **develop** branch, so it is always the most up-to-date
* The **master** branch only contains tagged releases
* If you are going to be submitting a pull request, please branch from **develop**, and submit your pull request back to the **develop** branch
* [Helpful article about forking](https://help.github.com/articles/fork-a-repo)
* [Helpful article about pull requests](https://help.github.com/articles/using-pull-requests)
