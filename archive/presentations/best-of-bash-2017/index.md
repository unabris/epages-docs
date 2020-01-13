---
pagetitle:  Best of Bash 2017
author: Jens Fischer <j.fischer@epages.com>
date-meta:  01.12.2017
---

# Best of Bash 2017

Twitter Follow Friday: [\@climagic](https://twitter.com/climagic)

<style>
.twitter-tweet {
  margin: auto;
}
</style>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<!--
base conversion
https://twitter.com/adamhotep/status/910539007066624002

2 commands, 1 grep.
https://twitter.com/climagic/status/867743418931400704

infinite ampersands, background
https://twitter.com/climagic/status/906258349423038464

39 character infinite ASCII maze generator
https://twitter.com/climagic/status/906216823057735680

protect yourself *specifically* from :(){ :|:& };:
https://twitter.com/climagic/status/892771955455164417

Swirly plasma background
https://twitter.com/climagic/status/820435115499196416

Bad Horse
https://twitter.com/RikerGoogling/status/809602596683952128
-->

---

# Decode a hex encoded string

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">echo %42%65%20%63%61%72%65%66%75%6c%20%77%68%61%74%2f%68%6f%77%20%79%6f%75%20%64%65%63%6f%64%65%0a | xxd -p -r # Decode a hex encoded string</p>&mdash; Command Line Magic (@climagic) <a href="https://twitter.com/climagic/status/912323073063505922?ref_src=twsrc%5Etfw">September 25, 2017</a></blockquote>

---

# How to quit vi?

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">man vi | grep -i quit # Maybe this is the problem. The vi man page doesn&#39;t even mention how to quit.</p>&mdash; Command Line Magic (@climagic) <a href="https://twitter.com/climagic/status/895714183228084224?ref_src=twsrc%5Etfw">August 10, 2017</a></blockquote>

---

# It's all unicorns and rainbows

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">yes &quot;$(seq 231 -1 16)&quot; | while read i; do printf &quot;\x1b[48;5;${i}m\n&quot;; sleep .02; done # A &quot;rainbow&quot; in your shell.</p>&mdash; Command Line Magic (@climagic) <a href="https://twitter.com/climagic/status/880851319166312448?ref_src=twsrc%5Etfw">June 30, 2017</a></blockquote>

---

# What's the weather?

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">curl <a href="https://t.co/auiEmqpD5i">https://t.co/auiEmqpD5i</a> # Check the weather for the next few days in Prague. ;-)</p>&mdash; Command Line Magic (@climagic) <a href="https://twitter.com/climagic/status/882148015309545472?ref_src=twsrc%5Etfw">July 4, 2017</a></blockquote>

`curl http://wttr.in/Hamburg`

---

# Google Maps for Nerds

<blockquote class="twitter-tweet" data-cards="hidden" data-lang="en"><p lang="en" dir="ltr">telnet mapscii.me # For maps in your terminal from OpenStreetMap. Yes really. <a href="https://t.co/FckeNVD5Nm">pic.twitter.com/FckeNVD5Nm</a></p>&mdash; Command Line Magic (@climagic) <a href="https://twitter.com/climagic/status/875745795936587777?ref_src=twsrc%5Etfw">June 16, 2017</a></blockquote>

---

# JavaScript x86 emulator

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">Incredible x86 emulator written in Javascript that runs Linux: <a href="https://t.co/WqzaqZ3DXh">https://t.co/WqzaqZ3DXh</a>  (Oldie but goodie)</p>&mdash; Command Line Magic (@climagic) <a href="https://twitter.com/climagic/status/865661181117177857?ref_src=twsrc%5Etfw">May 19, 2017</a></blockquote>

[x86 Linux 4.12.0 (Buildroot) console](https://bellard.org/jslinux/vm.html?url=https://bellard.org/jslinux/buildroot-x86.cfg)

---

# Star Wars in ASCII

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">telnet towel.blinkenlights\.nl # StarWars in ASCII. Also, towel! <a href="https://twitter.com/hashtag/StarWars40th?src=hash&amp;ref_src=twsrc%5Etfw">#StarWars40th</a> <a href="https://twitter.com/hashtag/TowelDay?src=hash&amp;ref_src=twsrc%5Etfw">#TowelDay</a> (Note the IPv4 and IPv6 addresses use of 42 too)</p>&mdash; Command Line Magic (@climagic) <a href="https://twitter.com/climagic/status/867742339355332610?ref_src=twsrc%5Etfw">May 25, 2017</a></blockquote>
