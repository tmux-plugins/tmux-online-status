# Tmux online status

Tmux plugin that displays online status of your workstation.

### Installation with [Tmux Plugin Manager](https://github.com/bruno-/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @tpm_plugins "              \
      bruno-/tpm                       \
      bruno-/tmux_online_status        \
    "

Hit `prefix + I` to fetch the plugin and source it.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/bruno-/tmux_online_status ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/online_status.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

### Limitations

Online status icon most likely won't be instant. The duration depends on the
`status-interval` Tmux option. So, it might take anywhere between 5 and 60
seconds for online status icon to change.

### License

[MIT](LICENSE.md)
