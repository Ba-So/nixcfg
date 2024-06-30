# Baso's NixOs Setup

This is an attempt at making NixOS more approachable for the likes of me.
The idea is to combine the awesomness of Lukes approach to Arch-Linux with
the endless configurability of NixOS.
  
This setup is inspired by the larbs setup by Luke,
based around dwm and keyboard-centeredness.
  
My hope is someone out there finds this, and uses it to dive deep into the world of linux.

## Boring history

Some time ago my journey into the linux world was launched properly by Luke, 
who attempted to make the scary world of the command-line and
endless configurability of linux accessible. I can't count how often I've destroyed
my Setup, or how often I wanted to do a simple thing like printing, only to find out
that for some reason the upstream driver has been broken with the most recent update.
This, combined with my own mistakes (try `sudo rm -rf /` m-) ),
rendered my linux setup unusable on a regular basis.  
  
Imagine my elation when I heard about NixOS from from Tristram at "No Boilerplate".
A system I can configure deterministically, based on a configuration file?
A system where I can roll back to a working state after messing up?
Sign me in.
  
Boy was I in for a ride. I work best when I have examples.
Contrived technical documentation is my enemy and the NixOS documentation is aweful.

## Inspirations
- [larbs](https://larbs.xyz/)
- [no boilerplate](https://www.youtube.com/watch?v=CwfKlX3rA6E)
- [phenax](https://github.com/phenax/nixos-dotfiles/tree/main)
  - this is where I pieced this repository together from.
  - I just attempt to add the documentation alongside it.

### Note on LARBS
(feeling opinionated, might remove later)
  
I really feel unsure about Lukes political views, especially the wording and iconography he uses.
My interpretation of his work on LARBS is that he wanted to make linux and it's endless configurability more aproachable.
Anything that distracts from this idea, hurts it. It is difficult to make something that is percieved as elitist and nerdy approachable,
while cladding it in a thick layer of edgyness.   
  
But I strongly adhere to [politics is the mindkiller](https://www.lesswrong.com/posts/9weLK2AJ9JEt2Tt8f/politics-is-the-mind-killer) his original idea is great and deserves praise.

## Principles
  
**Keep it Simple & Stupid**  
I start this repostiory with the eventual reader, you and myself, in mind. Keeping things simple is crucial.
  
**Consistency**  
I'll basically steal stuff from left and right, until I fully understand what I'm doing and why I'm doing it.
This will likely result in a mish-mash of styles, which again will hurt mine and your understandig. Working on
refactoring stuff in order to make things consistent should be an ongoing task.
  
**Modularity**  
NixOS gives us the power of include, let us use it to collect configurations that belong it dedicated files.
This will make it easy to find out where to change/fix a specific unwanted behavior.
