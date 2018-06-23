---
title: "Some Git Pitfalls for Junior Developers"
date: 2017-12-28T15:49:13Z
draft: false
---

Getting started with git is hard. Especially if you alone and don't have an experienced developer around. In this post I won't help you with basics of git, but share some pitfalls that I fell.

## Git is not a backup tool

I was totally wrong about the way I comprehend git a year ago. I was using git to solely to push my project's latest state to GitHub servers. **Git is not a backup tool**. Git is about tracking the differences, managing evolution of source code and allowing masses to do collaborative work on a project.

As an unemployed junior developer, you probably work alone on your projects. So that means you don't need a tool to make it easy to collaborate, but you will someday and that day is close enough to get started to learn using git properly. For example on Linux kernel last month (November 8 - December 8) "707 authors have pushed 2,334 commits to master".

Also by pushing big chunks of insertions and deletions to a remote server you lose the advantage of managing the evolution of your source code. Which change introduced the bug that I'm facing? You can answer this question if you track your differences.

## Atomic commits are important

To track differences, your commits should be atomic. But what makes a commit atomic? Well... I have mixed feelings about that, so I usually trust my gut feeling.

For example, let's say you added a field to your Django model. There is a change in your models.py and you have a migration file. You stage and commit them. OK, this is an atomic commit.

Let's say you developed a feature. On the registration page, you ask users their favorite editor. There is a change in models.py, forms.py, views.py and registration_form.html. Additionally, you have an untracked migration file. You stage and commit them. Is this an atomic commit? It's common practice for large projects to develop this feature in a branch with a commit for each modified file, squash all and merge. I don't like it but generally follow this myself too.

The rule of thumb is every commit should be working as itself. If I checkout a specific commit, I should see the feature as complete.

## Learn how to write good commit messages

Writing good commit messages is essential for managing the evolution of the code. Why? Because your commits are the snapshots of your project. You will want to see or return to one of these snapshots soon or later as your project grows. And you will want a clear definition of the snapshot, so you can choose which one you want to return.

Maybe one of your future teammates has to find the commit that introduced the bug she’s dealing with. Or maybe the maintainer of this super hot open source project looks at your pull request and trying to make sense of it. Providing a clear definition of an atomic commit is super helpful for them.

Official git documentation points [Tim Pope's model](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html) for writing good commit messages.  I'm trying to follow it without being so strict.

Git is an esoteric tool. But also a powerful one. You don't need to use every function it has initially. Just [learn the basics](https://marklodato.github.io/visual-git-guide/index-en.html) and stick with them. Then learn the rest as you need them.
