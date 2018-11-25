---
title: "RedHat Forum Istanbul 2018"
date: 2018-11-08T20:48:50Z
draft: false
---

I attended to Red Hat Forum Istanbul like [last
year](https://www.artistanbul.io/blog/2017/11/10/artistanbul-red-hat-forum-2017deydi/).
It was both fun and professional as always.

![Red Hat Forum 2018](/images/redhatforum2018.jpg)

Although most of the talks (excluding sponsor talks) were about containers and
Openshift (Kubernetes), the main topic of the coffee breaks was [IBM's
acquisition of the Red
Hat](https://www.redhat.com/en/about/press-releases/ibm-acquire-red-hat-completely-changing-cloud-landscape-and-becoming-worlds-1-hybrid-cloud-provider).
Obviously, Red Hat Turkey team was prepared for that. All of them successfully
replied to all of the questions with carefully memorized phrases.

The rockstar of the event was [Burr](https://github.com/burrsutter). He did
three demos. First of them was about a multi-cloud Openshift cluster. He
created a four node Openshift cluster, one node on AWS, one node on Azure, one
node on GCP and last one was on his computer. It was a demo of [Red Hat
AMQ](https://www.redhat.com/en/technologies/jboss-middleware/amq) rather than
Openshift.

The second demo was about [Istio](https://istio.io/) and it was like a voodoo
magic to me. First, he showed the canary deployment pattern. Then he deployed
a new version of an app to only beta users. Then to users who use OSX. Then to
users from Canada! Also, he showed circuit breaking and distributed tracing.

The third demo was about [Knative](https://cloud.google.com/knative/). He did
not have too much time, so it was a bit limited but very nice!

Besides the talks and demos, there was a game. It was a clone of Candy Crush,
but rather than candies you were trying to match things like Red Hat
subscriptions in 60 seconds... It was a silly game, that you have to play with
an Ipad on Red Hat boot. But there was a prize, a Nintendo Switch.  We played a
few times with [Okan](https://github.com/peyloride) and get the URL to play on
our computers. Then we noticed something if we open developer tools during the
game countdown were stopping.  We tried to exploit this to decide the best
moves and make high scores. Then we noticed something bigger: the final score
was sent by a POST request and there was no authentication. Jackpot!

After sending a few requests, we showed our finding to one of the Red Hat
employees. He found that so amusing that he wanted to take a photo together.

![That photo](/images/redhatforum2018-1.jpg)

But we were not the only clever ones in the event. Three more people exploited
this vulnerability. In fact, we got a serious competition with one of them. He
or she even wrote a scraper to pass me by 100 points whenever I make a new
request. Eventually, our scores hit the
[MAXINT](http://www.wikizeroo.net/index.php?q=aHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvMiwxNDcsNDgzLDY0Nw).
They gave the prize to the fifth person in the scoreboard.

See you next year!
