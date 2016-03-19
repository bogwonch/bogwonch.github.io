---
layout: post
title: USB Keyboards and Qubes
date: 2016-03-19 17:05:00 +0000
categories: qubes, usb, keyboard
---

My favourite keyboard is a *particularly* gross unicorn vomit [Planck Keyboard](http://ortholinearkeyboards.com/planck).
Unfortunately Qubes *sys-usb* VM picks it up as a mouse, not a keyboard and stops it from working (and rightly so).

To get Qubes to prompt if a keyboard should be allowed to attach, like with mice, in *dom-0* edit `/etc/qubes-rpc/policy/qubes.InputKeyboard`:

~~~~
sys-usb dom0 ask,user=root
$anyvm $anyvm deny
~~~~

There we go!
Much better.

Obviously this is a *bit* of a security risk.
Someone could modify my keyboard to type naughty commands into the secure bits of my computer.
Whilst I did program my keyboard, I don’t know if anyone has modified it since then.
A risk I have to take I guess if I want to use my unicorn vomit though!

(Incidentally what is to stop someone modifying my laptop to do much the same attack other than ease of access?)
