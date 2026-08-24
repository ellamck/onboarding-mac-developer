# ZSHRC Snippet

I added the following to my .zshrc file at the bottom:

# Custom aliases

alias zshrc='open ~/.zshrc'
alias c='clear'
alias gs='git status'
alias gnb='git checkout -b'
alias gp='git pull'

# Custom functions

# make a new markdown file with a heading

newmd() {
echo "# $1" > "$1.md"
}

# run whole check suite

lint() {
npx eslint .
npx prettier --check .
}
