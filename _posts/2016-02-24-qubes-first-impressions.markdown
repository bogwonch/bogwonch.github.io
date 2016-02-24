---
layout: post
title: Qubes First Impressions and Niggles
date: 2016-02-24 21:00:00 +0000
categories: qubes
---

I've been using [Qubes](https://www.qubes-os.org/) for the last week on my new
laptop and since version 3.1-rc3 got released today I thought I'd write up some
first impressions of it.  Overall I'm a fan.  You divide up your computing into
different domains (or *apps*) and create virtual machines based off a couple of
*template* virtual machines.  Any changes outside of the home folder in the app
VMs get discarded when the machine is rebooted, so if you want to permenantly
install new software you have to do it in the template VM and it'll be shared
between all the apps based off of it.  The network stacks, firewalls, and all
other jiggery pokery, can (or cannot) lie in separate VMs so you can do nice
tricks like automatically routing all traffic through Tor and so on.

Go away and read the design docs and some of *Rootskova*'s papers if you're
interested.

Installation
============

 *  You can't install with UEFI.  My laptop was initially setup to only use
    UEFI.  Half an hour of wondering what the heck before I figured it out.
    From the release notes of 3.1-rc3 it looks like it'll be supported from
    now on.

 *  Installation went fine (though it got confused when I hit _back_).  Wasn't
    really sure how to partition the disk.  My laptop has a big harddisk, and a
    little SSD.  In the end I used the entire of the harddisk and ignored the
    SSD.  Having used it now I find 99% of the space is used by `/var/qubes`
    where the VMs and their filesystems live.  When I upgrade I'll put `/` on
    the SSD and `/var` on the HDD.

Niggles
=======

 *  The documentation is a mess.  In serious need of some editing, as well as
    content.  A wiki-like structure would be more helpful too.  I'm sure it
    will come with time.  This is a young operating system.

 *  Getting your head round the app and template VM separation takes a bit of
    time.  A tutorial would be helpful.

 *  Despite what the docs say you *quite often* need to copy stuff into *dom0*.
    Want a nice wallpaper or a different font? Copy to *dom0*.  Want to install
    Windows in a VM?  You *could* try and use the boot the VM from the disk
    inside a VM but I couldn't get it to work.  Copy to *dom0*.  There isn't a
    neat command to do this because they want to discourage doing anything in
    dom0, which I get, but its a pain.  I'll probably write one myself.  Going
    down the `sudo` route and displaying a warning the first time you do it is
    probably a better strategy.

 *  Customizing anything is horrible.  
     *  The default themes for KDE and XFCE are god-awful.
     *  Icons are a bizarre mishmash of the KDE from *dom0*, and the default
	icons in the Gnome based *Fedora* VMs used for nearly everything else
	at the start.
     *  The cursor seems to change size randomly sometimes.
     *  Customizing the app launcher menu is tedious, with new apps loading a
	default set of apps that I don't use, colored icons missing, and whilst
	the package manager is supposed to be able to detect new apps in your
	VM and add them (or add them to the adding menu) it doesn't work.  I
	normally end up using a terminal on dom0.
     *  Ideally it'd be nice to be able to have some way of getting the *label*
	of the VM from within the VM.  That way you could set themes (i.e. use
	blue colored highlights in blue labeled VMs) without having to tweak
	from within the VM manually for each one.

 *  Seven colors for labels are not enough.  I split it so black is my
    template, yellow is non-work stuff, blue is work, purple is weird, red is
    untrusted, orange is things with keys but I'd like to be able to
    distinguish between work-PhD, and work-consultency just by the border; or
    at least get a hint.  Also... we __need__ the *pink* label.

 *  The VM manager hides things away behind icons.  It is confusing to use.
    I'd far rather have something *simpler* (create a VM, set its network and
    memory, see whats currently running) than the current version.

 *  That launcher again, ideally what I'd like is an *Alfred* like launcher
    running in dom0.  When I hit the magic command it pops up, and I can type
    the name of the VM I want to run, and then that should launch the launcher
    running within it where I can pick what damn app I want to run.  I should
    probably implement this.

 *  When creating a Windows HVM the docs fail to mention that you'll need to up
    the default amount of RAM for the machine as Windows won't install with the
    paltry couple-of-hundred megs Qubes gives by default.  Took me a while and
    some Googling to figure that one out.  Having some sensible defaults for
    some HVMs like VirtualBox does would be a pretty good idea.

 *  I eventually gave up with the Fedora default template and switched to an
    Arch one (mostly because I know Arch better).  It is semi-official, but I
    wish they still gave you more control over what and how things were
    installed.  No I *really* don't want you to install *Thunderbird* by
    default, or the default terminal app, or web-browser.  Just give me the
    minimum-viable system and some CLI tools to access the functionality they
    provide.  If I wanted things preconfigured I'd have used the Fedora
    default.

 *  It isn't the nippiest thing in the world.  Things seem to hang randomly
    every so often. Could be my laptop, but it's a brand new T550 Thinkpad with
    everything maxed out.  Last years laptop but still disappointing.  Haven't
    tried any other OSs on here so it could just be overly high expectations,
    or my innate dislike of Window managers and compositors talking.

Overall
=======

Lotta gripes, but they're mostly cosmetic.  The biggest one for me is the
documentation which isn't good enough.  I love the control it gives me and the
way it lets me implement the partitioning of my work/life in a way that *feels*
good.  It's young.  It is *definitely* not production ready, but it is getting
there.  I think I'll keep it and upgrade the system to v3.1-rc3, rather than
putting another OS on it.

The two biggest things that'd help it now is to work on the documentation, and
to have someone work on the usability aspects.  Both things *I* can and
probably should do.  Perhaps I'll get up off my fat-arse and submit some
pull-requests.

Overall though, Qubes *feels* good.  It *feels* fun, exciting, and leaves you
imagining what you *could* do.  Like that first time you installed Linux and
you got to play with those cool window effects, or when you first realised you
could change all the icons on your System 7 Mac, or when you copied out that
*Animal Crossing* pattern of AiAi from *Super Monkey Ball* from that Edge
magazine article.  These are, aside from personal things to me, all very
childish things, but its that childish glee at the system that gets me all
excited about it.  It doesn't feel polished, but it feels good, and it feels
exciting and new.  It's not like a new release of MacOS or iOS with slightly
different gradients and slight refinements.  It's like the first iPad.  Bold, a
slap in the face for conventional thinking, and *undoubtably* the shape of
things to come.  Exciting times!
