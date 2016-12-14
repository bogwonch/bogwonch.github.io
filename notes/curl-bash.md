A collection of sites that ask you to pipe curl'd files into bash or
similar. Bonus points are given for:

-   Not using `https` because everyone likes MITM.
-   No verification of downloaded files.
-   Piping into `sudo bash` because everyone likes running unchecked
    scripts as root.
-   Downloading more scripts inside the scripts!
-   All of the above.

To be perfectly honest I don't blame these sites. It isn't *that*
different from just making you type an arbitrary series of commands. But
it is *terrible* security behaviour.

The solution, by the way, is to use [Qubes](https://www.qubes-os.org).

`pre-commit.com`
================

> Installation Before you can run hooks, you need to have the pre-commit
> package manager installed.
>
> Using pip: 
> 
> `pip install pre-commit`
>
> Non Administrative Installation:
>
> `curl <http://pre-commit.com/install-local.py> | python`
>
> System Level Install:
>
> `curl <https://bootstrap.pypa.io/get-pip.py> | sudo python - pre-commit`
>
> In a Python Project, add the following to your requirements.txt (or
> requirements-dev.txt):
>
>     `pre-commit`
>
> Using homebrew
>
>     `brew install pre-commit`

Lots of fun here!

-   A curl into python from a non-HTTPS link.
-   A curl from an HTTPS but completely different site into a root python.
-   Linked script also downloads a file from `pypi.python.org`.
-   Linked script also deletes whatever is at `~/bin/pre-commit`.

`brew.sh`
=========

> Install Homebrew
>
> `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
>
> Paste that at a Terminal prompt.
>
> The script explains what it will do and then pauses before it does it. There are more installation options here (needed on 10.5).

Not the worst by far, but come on.
Just because a script _says_ what it is doing doesn't mean you should trust it.

`openssuse.org`
===============

I wanted to install a gtk-theme onto a Debian box.
They directed me to an Open Suse repo...


> Add repository and install manually
> 
> For Debian 8.0 run the following as root:
> 
> `echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/Debian_8.0/ /' > /etc/apt/sources.list.d/arc-theme.list `
> `apt-get update`
> `apt-get install arc-theme`
> 
> You can add the repository key to apt. Keep in mind that the owner of the key may distribute updates, packages and repositories that your system will trust (more information). To add the key, run:
> 
> `wget http://download.opensuse.org/repositories/home:Horst3180/Debian_8.0/Release.key`
> `apt-key add - < Release.key`
> `apt-get update`

Lets ignore the fact the repo is running on HTTP.
All packages should be signed by the repository key.
This shouldn't be an issue, right?

They note that the *fucking* repository key may distribute updates your system will trust.
Yet the key is downloaded over HTTP.
What's more you actually can't download the key over HTTPS.

So you want me to install software, signed by no key.
Or by a key I can't even trust actually came from the bloody Open Suse website?

