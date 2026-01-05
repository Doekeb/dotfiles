if status is-interactive
  if not set -q TMUX
    exec tmux
  end
end
