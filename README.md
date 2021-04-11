# pomodoro

Tools and [tmux](https://tmux.github.io/) integration for the [Pomodoro Technique](http://pomodorotechnique.com/).  Allows you to put a 25-minute timer in the corner of your tmux sessions.

Based loosely on [tmux-pomodoro](https://github.com/justincampbell/tmux-pomodoro), and written in bash for portability.

Here is a lovely screenshot:

![Powerline-ish status-right screenshot](https://cloud.githubusercontent.com/assets/14341469/12039500/df27efd6-ae15-11e5-858c-108d5f4b7c37.png)

## Caveats

`pomodoro` is a very simple and early-stage bash script, written hastily in an ironic act of procrastination.  It could probably use a lot of improvement.

A terminal that supports Unicode is recommended.

## Installation

Using [tpm](https://github.com/tmux-plugins/tpm) to install this plugin, put the following in .tmux.conf

```tmux
set-option -g @plugin 'poorsquinky/pomodoro'
```

## Basic Configuration

Add the status icon to your .tmux.conf.  This example works with tmux configurations that are shared between different hosts that may or may not have pomodoro installed:

```tmux
set -g status-right '#{pomodoro_status}'
```

## Usage

* (prefix) a - Start a timer
* (prefix) A - Reset the timer


## Optional/Advanced Configuration

### Hotkeys in `.tmux.conf`

Change bind-key to other keys

* (prefix) t to start
* (prefix) T to clear
```tmux
set-option -g @pomodoro_start_key 't'
set-option -g @pomodoro_clear_key 'T'
```

### Disable Unicode
```tmux
set-option -g @pomodoro_bang '!'
set-option -g @pomodoro_symbol 'P'
set-option -g @pomodoro_nbsp ' '
```

### Set the timer length (minutes)
```tmux
set-option -g @pomodoro_minutes 30
```

### Use graphical meter instead of minute count
```tmux
set-option -g @pomodoro_graphical 1
```

### Status blocks

* A nice color status block:
```tmux
set -g status-right '#[fg=colour07,bg=colour05] #{pomodoro_status}'
```

### Home directory config

If you don't like putting the config file in tmux.conf, you could put the corresponding config in `.pomodororc` in your home direction and uncomment whatever you need.

```sh
cp scripts/pomodororc.example ~/
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

* A lightweight REST API that can replace SSH synchronization, plus [Docker](https://github.com/docker/docker) containers for a simple low-mess API installation

