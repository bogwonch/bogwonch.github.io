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


