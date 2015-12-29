# pomodoro

Tools and [tmux](https://tmux.github.io/) integration for the [Pomodoro Technique](http://pomodorotechnique.com/).  Allows you to put a 25-minute timer in the corner of your tmux sessions.

Based loosely on [tmux-pomodoro](https://github.com/justincampbell/tmux-pomodoro), and written in bash for portability.

Here is a lovely screenshot:

![Powerline-ish status-right screenshot](https://cloud.githubusercontent.com/assets/14341469/12039500/df27efd6-ae15-11e5-858c-108d5f4b7c37.png)

## Caveats

`pomodoro` is a very simple and early-stage bash script, written hastily in an ironic act of procrastination.  It could probably use a lot of improvement.

A terminal that supports Unicode is recommended.

## Installation

* Clone this repository or download the ZIP and unpack it
* Place the `pomodoro` script somewhere in your PATH (for example, `/usr/local/bin/`)

## Basic Configuration

Add the status icon to your .tmux.conf.  This example works with tmux configurations that are shared between different hosts that may or may not have pomodoro installed:

```tmux
set -g status-right '`test -e /usr/local/bin/pomodoro && pomodoro status`'
```

## Usage

* `pomodoro start` - Start a timer
* `pomodoro clear` - Reset the timer
* `pomodoro status` - Display the current timer, if any


## Optional/Advanced Configuration

### Hotkeys in `.tmux.conf`
* (prefix) ctrl-p to start
* (prefix) meta-p to clear
```tmux
bind-key -T prefix C-p run-shell 'test -e /usr/local/bin/pomodoro && pomodoro start'
bind-key -T prefix M-p run-shell 'test -e /usr/local/bin/pomodoro && pomodoro clear'
```

### Disable Unicode
* Add to .pomodororc:
```bash
POMODORO_BANG="!"
POMODORO_SYMBOL="P"
POMODORO_NBSP=" "
```

### Set the timer length (minutes)
```bash
POMODORO_MINUTES=30
```

### Use graphical meter instead of minute count
```bash
POMODORO_GRAPHICAL=1
```

### Status blocks

* A nice color status block:
```tmux
set -g status-right '#[fg=colour07,bg=colour05] #(printf "%%-3s" `test -e /usr/local/bin/pomodoro && pomodoro status`)'
```

* Status block including completed timer count:
```tmux
set -g status-right '#[fg=colour07,bg=colour05] #(printf "%%-3s" `test -e /usr/local/bin/pomodoro && pomodoro -c status`)'
```

* Status block with graphical display:
```tmux
set -g status-right '#[fg=colour07,bg=colour05] #(printf "%%-3s" `test -e /usr/local/bin/pomodoro && pomodoro -g status`)'
```

* Full disclosure: the status-right that I personally use, with a clock and host load average.  Requires a 256-color terminal and a [powerline](https://github.com/powerline/fonts) or [nerd](https://github.com/ryanoasis/nerd-fonts) font:
```tmux
set -g status-right '#[fg=colour54] #[fg=colour205,bg=colour54] #(printf "%%-3s" `test -e /usr/local/bin/pomodoro && pomodoro status -c`) #[fg=colour57] #[fg=colour140,bg=colour57] #(uptime | sed -e "s/.*: //" -e "s/,//g") #[fg=colour135]#[fg=colour15,bg=colour135] %m/%d %H:%M '
```

### SSH read/write synchronization

These settings will allow you to synchronize your timers across multiple hosts.  In order for this to work, you will need to configure SSH to allow passwordless authentication for the pomodoro commands (**This is potentially
dangerous** and not yet documented here)

To synchronize your timers between multiple hosts, you can add `POMODORO_SSH` to `.pomodororc` in your home directory:
```bash
POMODORO_SSH=server.example.com
```

If you are synchronizing your .pomodororc with the target host and want to make sure that host doesn't try to sync with itself (which would be a big problem), you can tell it not to attempt synchronizing if its hostname matches
the `POMODORO_NOSYNC_NAME` value:
```bash
POMODORO_NOSYNC_NAME=examplehost
```

### HTTP read synchronization

You can configure pomodoro to read its synchronized status via a URL, which is somewhat more lightweight than using SSH so frequently.  To make this work, you need to do the following:

* Create a symbolic link on the server to a location accessible to the web server:
```bash
ln -s /tmp/pom_$USER $HOME/public_html/pom
```
* Ensure your web server is configured to follow symbolic links in that location ([hint](https://httpd.apache.org/docs/2.4/mod/core.html#options))
* Put a similar line to this in your .pomodororc:
```bash
POMODORO_STATUS_URL=http://host.example.com/~user/pom
```
* Any client connecting to this URL will need to have [curl](http://curl.haxx.se/) installed.  Ones without it will silently fall-back to trying SSH.


## TODO

In future revisions of this, I would like to see:

* A simple installer
* A lightweight REST API that can replace SSH synchronization, plus [Docker](https://github.com/docker/docker) containers for a simple low-mess API installation

