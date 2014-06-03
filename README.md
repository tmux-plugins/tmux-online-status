# Tmux online status

Tmux plugin that enables displaying online status for your workstation.

Introduces a new `#{online_status}` format.

This plugin is useful if:
- you spend most of your time in Tmux and don't want to "switch" away from
  the terminal to check whether you're connected.
- you have a flaky internet connection and you don't want to be surprised
  when a simple `curl` or `wget` fails because the connection just broke.

### Usage

Add `#{online_status}` format string to your existing `status-right` tmux
option.

Here's the example:

    # in .tmux.conf
    set -g status-right "Online: #{online_status} | %a %h-%d %H:%M "

The above will result in this:<br/>
![online indicator](/screenshots/online_indicator.png)<br/>
or this<br/>
![offline indicator](/screenshots/offline_indicator.png)<br/>

The icon will of course change as you connect/disconnect from the internet.

### Installation with [Tmux Plugin Manager](https://github.com/bruno-/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "              \
      bruno-/tpm                       \
      bruno-/tmux_online_status        \
    "

Hit `prefix + I` to fetch the plugin and source it.

`#{online_status}` interpolation should now work.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/bruno-/tmux_online_status ~/clone/path

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

- [pain control](https://github.com/bruno-/tmux_pain_control) - useful
  standard bindings for controlling Tmux panes
- [goto session](https://github.com/bruno-/tmux_goto_session) - faster session
  switching
- [battery osx](https://github.com/bruno-/tmux_battery_osx) - battery status
  for OSX in Tmux `status-right`
- [logging](https://github.com/bruno-/tmux_logging) - easy logging and
  screen capturing

### License

[MIT](LICENSE.md)
