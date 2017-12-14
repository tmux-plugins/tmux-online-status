# Tmux online status

Tmux plugin that enables displaying online status for your workstation.

Introduces a new `#{online_status}` format.

This plugin is useful if:
- you spend most of your time in Tmux and don't want to "switch" away from
  the terminal to check whether you're connected.
- you have a flaky internet connection and you don't want to be surprised
  when a simple `curl` or `wget` fails because the connection just broke.

Tested and working on Linux, OSX, FreeBSD, and Cygwin.

### Usage

Add `#{online_status}` format string to your existing `status-right` tmux
option.

Here's the example in `.tmux.conf`:

    set -g status-right "Online: #{online_status} | %a %h-%d %H:%M "

**OS X**<br/>
On OS X the above will look like this when online<br/>
![online indicator](/screenshots/online_indicator.png)<br/>
or this when offline<br/>
![offline indicator](/screenshots/offline_indicator.png)<br/>

**Linux**<br/>
Online status on Linux<br/>
![online indicator](/screenshots/online_indicator_linux.png)<br/>
offline status<br/>
![offline indicator](/screenshots/offline_indicator_linux.png)<br/>

#### Configure icons
If the icons don't display well on your machine you can change them in
`.tmux.conf`:

    set -g @online_icon "ok"
    set -g @offline_icon "offline!"

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tmux-plugins/tmux-online-status'

Hit `prefix + I` to fetch the plugin and source it.

`#{online_status}` interpolation should now work.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tmux-plugins/tmux-online-status ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/online_status.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

`#{online_status}` interpolation should now work.

### Limitations

Online status icon most likely won't be instant. The duration depends on the
`status-interval` Tmux option. So, it might take anywhere between 5 and 60
seconds for online status icon to change.

Set `status-interval` to a low number to make this faster, example:

    # in .tmux.conf
    set -g status-interval 5

### Other plugins

You might also find these useful:

- [battery](https://github.com/tmux-plugins/tmux-battery) - battery status in
  Tmux `status-right`
- [logging](https://github.com/tmux-plugins/tmux-logging) - easy logging and
  screen capturing

### License

[MIT](LICENSE.md)
