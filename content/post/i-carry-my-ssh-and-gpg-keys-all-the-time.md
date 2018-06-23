---
title: "I Carry My SSH and GPG Keys All the Time"
date: 2017-11-12T15:49:24Z
draft: false
---

[Yubikeys](http://www.yubico.com/products/yubikey-hardware/) are great. Many use them just for 2 factor authentication. But Yubikeys are capable to hold your GPG keys also. And you can use your GPG keys for SSH authentication. So here is the story of how I carry my SSH keys in my pocket all the time in (almost) pain-free and relatively secure way.

You have two options for creating GPG keys: creating directly on Yubikey or creating on your computer and import to Yubikey. I went with first way at the beginning and then the [Infineon RSA key generation issue](http://www.yubico.com/support/security-advisories/ysa-2017-01/) discovered. The keys generated on Yubikey 4 below 4.3.5 were vulnerable. I had no option other than revoking my private key and go with second way.

This post is not intended to be a tutorial about key generation or importing keys to Yubikey. I followed [this tutorial](https://github.com/drduh/YubiKey-Guide).

To use your GPG keys to ssh computers, you have to use gpg-agent for ssh. It's easy and not much error-prone most of the time but you have to kill and restart gpg-agent occasionally. The biggest requirement is telling ssh to use gpg-agent by changing `$SSH_AUTH_SOCK` environment variable to gpg-agent's socket. I have [this](https://github.com/egegunes/dotfiles/blob/master/.bashrc#L30) in my bashrc which I took from [Jess Frazelle](https://github.com/jessfraz/dotfiles).

So what is so great about having your ssh keys all the time? I don't need to worry about carrying my laptop with me to access my servers or I don't need to compromise the security of my keys by syncing them between hosts by something like Dropbox. If a problem occurs one of our production systems I simply insert my work Yubikey to my home computer and _I'm in_. If a problem occurs when I'm not able to use any of my computers, I also carry a live Fedora usb with me all the time and there are computers literally everywhere. If I can't find a computer, well _c'est la vie_.
