# awesome
Config for the awesome window manager!

![2021-08-24-181921_1920x1080_scrot](https://user-images.githubusercontent.com/39461169/131265996-ecae094b-9470-45c2-b810-854536d20059.png)

## Quickstart
1. Since I use sxhkd for my hotkeys you'll need to install sxhkd. Heres an example on how to configure sxhkd for awesome:
```
# quit/restart
super + alt + {q,r}
    echo "awesome.{quit,restart}()" | awesome-client

# close and kill
super + {_, shift + } q
    echo "client.focus:kill()" | awesome-client

# set the client state
super + {s,d,f,shift + f}
    echo "change_client_state('{stacking,default,maximized,fullscreen}')" | awesome-client

# reset the client color
super + c
    echo "require('util.client_colors').update()" | awesome-client

# focus/swap clients
super + {_,shift + }{j,k,h,l}
    echo "require('awful').client.{focus,swap}.bydirection('{down,up,left,right}')" | awesome-client

# focus the next/previous tag
super + {p,n}
    echo "require('awful').tag.view{prev,next}()" | awesome-client

# focus or send to the given desktop
super + {1-9,0}{_, + ctrl, + shift}
    echo "awful = require('awful') tag = awful.screen.focused().tags[{1-9,10}] {tag:view_only(),awful.tag.viewtoggle(tag),client.focus:move_to_tag(tag)}" | awesome-client

# resize master
super + ctrl + {h,l}
    echo "require('awful').tag.incmwfact({-,_}0.05)" | awesome-client

# previous client
super + Tab
    echo "awful.client.focus.history.previous()" | awesome-client

# next layout
super + o
    echo "awful.layout.inc(1)" | awesome-client

# focus the next/previous screen
super + ctrl + {j,k}
    echo "awful.screen.focus_relative({_,-}1)" | awesome-client
```
2. Clone the repository in your .config folder (rename or remove the existing folder)
```
git clone https://github.com/dmun/awesome ~/.config/awesome
```

## Notes
If you're using the example sxhkd keymappings, use super + c to recolor the focused clients borders to make it pretty!
This repository is nowhere near done or anything, so don't expect it to always be the same.

## References
These are some repositories that have helped me out.

[tommy-turtle's wallpapers](https://www.reddit.com/gallery/oum2ie)

[elenapan's dotfiles](https://github.com/elenapan/dotfiles)

[mut-ex' nice (window decorations)](https://github.com/mut-ex/awesome-wm-nice)
