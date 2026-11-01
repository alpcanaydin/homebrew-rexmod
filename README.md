# Homebrew tap for rexmod

[rexmod](https://github.com/alpcanaydin/rexmod) turns [Rex](https://rex.superlogical.com) into a harness for your coding agent: a Changes panel, an editor pane and review comments that go back to the agent (Claude Code, Codex, OpenCode, Pi).

```sh
brew install alpcanaydin/rexmod/rexmod
rexmod-setup
```

Then quit Rex (⌘Q) and open it again. After `brew upgrade rexmod`, run `rexmod-setup` again.

The formula in `Formula/rexmod.rb` follows rexmod's releases on its own: a daily workflow here bumps it when a new release is out.
