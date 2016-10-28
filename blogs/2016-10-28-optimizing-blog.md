% Optimizing HTML

I am not a web developer.
That said, I *do* like to try and make things go fast.
I *do* try and do things right.
This blog, and everything in it, is tiny.
It *should* go like a rocket.

I already try and make everything very quick.
Images are massively compressed and are of yucky quality, but they're also very small.
If you really needed to see the full size ones you could explore the [Makefile](/Makefile).
But then I stumbled across [Google's PageSpeed tools](https://developers.google.com/speed/pagespeed/).
Okay... so let's see what I can do.

## CSS
  
The CSS is fairly small: a measly _1kB_.
Initially I tried messing about with [HTML5 Imports](https://www.html5rocks.com/en/tutorials/webcomponents/imports/), but Safari on the iPhone doesn't support them.
Also tried messing about with JavaScript, but I'm quite proud of the fact I don't use any on the main site.

I can't set some neat caching header ([Github](https://github.com) hosts this).
In the end I minimized it and embedded it, by tweaking the Pandoc template I use to generate everything.

## HTML

While we're at it why not minimize the HTML?
If you need to read the code you can read the org-mode/markdown I generated it from.

Minimize all the things.

## Images

The images are already pretty small but PageSpeed was complaining about having to go and load them.
But then I read an [an article about embedding images](http://www.techerator.com/2011/12/how-to-embed-images-directly-into-your-html/).
Great okay then.
I wrote a [little tool to inline images into HTML](https://github.com/bogwonch/html-img-inliner), and voilà.
I am slightly distrusting of this in general: this should really be done by caching, but it is kinda neat anyway.
Since Github's server uses compression I'll even forgive all the inlined Base64'd data.

Actually this has one more nice effect.
Since **everything** is inlined now, I can preview pages just by opening the HTML in a browser.
No external dependencies means no starting a server on my computer or pushing to Github willy nilly.
This should help reduce endless trying to fix the CSS commits.

## Results

After all that most pages are pretty fast.
Also tweaked some other things too to get past the usability section (bigger line-height to separate buttons, a viewport, scrolling code).
PageSpeed complains less now.

![PageSpeed results are less complaining.](imgs/pagespeed.s.jpeg)

...unless you load a page with an image when it tells me that most of the content is after the image and it has to load it then reflow everything.
I'm happy though:
I wrote a cute tool, and everything is a bit better.

