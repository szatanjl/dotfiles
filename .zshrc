# ENV {{{
# LS_COLORS {{{
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36'
# }}}
# DATADIR {{{
if [ -n "${XDG_DATA_HOME-}" ] || [ -n "${HOME-}" ]; then
	DATADIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
	mkdir -p -- "$DATADIR"
fi
# }}}
# }}}
# CHANGING DIRECTORIES {{{
setopt auto_cd auto_pushd cd_silent pushd_ignore_dups pushd_minus
# }}}
# COMPLETION {{{
setopt always_last_prompt auto_list auto_menu no_list_ambiguous
setopt list_packed no_list_types complete_in_word glob_complete

autoload -Uz compinit && compinit -D
zstyle ':completion:*:commands' rehash 1             # rehash before completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case insensitive
zstyle ':completion:*' menu select                   # select with arrows
zstyle ':completion:*:default' list-colors "${LS_COLORS-}"
# }}}
# EXPANSION {{{
setopt bang_hist no_hist_verify hist_lex_words
setopt equals no_ignore_braces rc_expand_param
setopt magic_equal_subst glob_subst unset
# }}}
# GLOBBING {{{
setopt glob extended_glob bare_glob_qual glob_star_short
setopt case_glob glob_dots no_null_glob nomatch
# }}}
# HISTORY {{{
setopt inc_append_history hist_ignore_all_dups hist_ignore_space
HISTFILE="${DATADIR:+$DATADIR/history}"
HISTSIZE=10000
SAVEHIST=10000
# }}}
# JOB CONTROL {{{
setopt monitor auto_continue hup check_jobs check_running_jobs no_notify
# }}}
# PROMPT {{{
setopt prompt_cr prompt_percent prompt_subst
PROMPT_EOL_MARK=''
PS1='
%B%F{green}%n@%M %F{blue}%~ %F{magenta}$(git_status) %F{red}%(?..^%?)%f%b
%(!.#.$) '
PS2='> '

git_status() {
	local branch
	if branch="$(git branch --show-current)"; then
		if [ -z "$branch" ]; then
			branch="detached:$(git rev-parse --short HEAD)"
		fi
		printf '(%s' "$branch"
		git status --porcelain --branch | awk -F '[][, ]' '
			/^.?[AC]/ { add++ }
			/^.?D/    { del++ }
			/^.?[MR]/ { mod++ }
			/^.?U/    { con++ }
			/^.?\?/   { unt++ }
			/^##/ {
				if (NF > 2 && $(NF-2) == "behind")
					behind = $(NF-1)
				if (NF > 2 && $(NF-2) == "ahead")
					ahead = $(NF-1)
				if (NF > 5 && $(NF-5) == "ahead")
					ahead = $(NF-4)
			}
			END {
				if (add > 0) printf(" +%u", add)
				if (del > 0) printf(" -%u", del)
				if (mod > 0) printf(" ~%u", mod)
				if (con > 0) printf(" !%u", con)
				if (unt > 0) printf(" ?%u", unt)
				if (ahead > 0) printf(" ^%u", ahead)
				if (behind > 0) printf(" $%u", behind)
			}'
		printf ')'
	fi 2> /dev/null
}
# }}}
# OTHER {{{
setopt no_flow_control no_ignore_eof interactive_comments rm_star_silent
MAILCHECK=0
# }}}
# KEYBINDS {{{
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
expand() {
	zle _expand_alias
	zle expand-word
}
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N expand

WORDCHARS='~!@#$%^&*_-+.?'

bindkey -d

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^H' emacs-backward-word
bindkey '^L' emacs-forward-word

bindkey '^K' up-line-or-beginning-search
bindkey '^J' down-line-or-beginning-search  # this hangs mc after pressing enter
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward

bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line
bindkey "${terminfo[kdch1]}" delete-char

bindkey '^ ' expand
bindkey '^I' expand-or-complete
bindkey "${terminfo[kcbt]}" reverse-menu-complete
# }}}
# BOOKMARKS {{{
BMFILE="${DATADIR:+$DATADIR/bookmarks}"

bm() {
	local bmark
	if [ -z "${BMFILE-}" ]; then
		return 1
	fi
	if [ -z "${1-}" ]; then
		hash -d
	elif [ "${1-}" != '-' ]; then
		unhash -d -- "$1" > /dev/null 2>&1
		{
			if [ -f "$BMFILE" ]; then
				sed -e "/^$1=/d" -- "$BMFILE"
			fi
			if [ "${2-}" != '-' ]; then
				bmark="$(cd -- "${2-.}" && pwd -L)"
				hash -d -- "$1=$bmark" > /dev/null 2>&1
				printf '%s=%s\n' "$1" "$bmark"
			fi
		} > "$BMFILE.tmp"
		mv -f -- "$BMFILE.tmp" "$BMFILE"
	else
		hash -dr > /dev/null 2>&1
		if [ -f "$BMFILE" ]; then
			while read -r bmark; do
				hash -d -- "$bmark" > /dev/null 2>&1
			done < "$BMFILE"
		fi
	fi
}
bm -
# }}}
# ALIASES {{{
setopt aliases
# cd {{{
alias -- -='cd -'
alias -- -2='cd -2'
# }}}
# ls {{{
alias ls='ls --color=auto'
alias l='ls -A'
alias ll='ls -Al'
# }}}
# du {{{
ds() { du -sh "$@" | sort -rh; }
# }}}
# fs {{{
alias cp='cp -RPf --'
alias lh='ln -fL --'
alias ln='ln -fs --'
alias mkdir='mkdir -p --'
alias mv='mv -f --'
alias rm='rm -Rf --'
alias rmdir='rmdir --'
# }}}
# archive {{{
alias x='unpack'
alias z='pack'

compdef _files unpack
compdef _files pack
# }}}
# find {{{
alias f='find . -name'
alias fd='find -L . -type d -name'
alias ff='find -L . -type f -name'
# }}}
# grep {{{
alias grep='grep --color=auto'
alias s='grep -n -RI'
alias sc='s --include="*.c"'
alias sh='s --include="*.h"'
# }}}
# jobs {{{
j() { jobs -l | grep -- "$1"; }
p() { ps -Af | { head -n 1; grep -- "$1"; }; }
alias k='kill -s TERM --'
alias kk='kill -s KILL --'
# }}}
# history {{{
h() { fc -l 0 | grep -- "$1"; }
d() { dirs -lv | grep -- "$1"; }
# }}}
# view {{{
alias v='head -n 1000 --'
# }}}
# sudo {{{
alias sudo='sudo '  # pass aliases over sudo
# }}}
# git {{{
alias gch='git checkout'

alias gst='git status'
alias gsh='git show --name-status --pretty=fuller --decorate=no'

alias gl='git log --oneline --decorate=no'
alias gl1='gl -n 10'
alias gl2='gl -n 20'
alias gl3='gl -n 30'
alias gl4='gl -n 40'
alias gl5='gl -n 50'

alias glg='git log --oneline --decorate=no --graph'
alias glg1='glg -n 10'
alias glg2='glg -n 20'
alias glg3='glg -n 30'
alias glg4='glg -n 40'
alias glg5='glg -n 50'

alias ga='git add'
alias gap='git add --patch'
alias gau='git add --update'

alias grs='git reset'
alias grh='git reset --hard'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcn='git commit --all --amend --no-edit'

alias gsu='git submodule update'

alias gpr='git pull --rebase'
alias gpu='git push'
alias gpf='git push --force'

# TODO: change to difftool
alias gd='git diff'
alias gdc='git diff --cached'
# gds() { git diff $1~ $1 }
# compdef _git gds=git-show
alias gds='git show'

alias gm='git mergetool --no-prompt'
alias gma='git merge --abort'

alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

alias gr='git rebase'
alias gri='git rebase --interactive --autostash'
alias gra='git rebase --abort'
alias grc='git rebase --continue'

alias ggc='git -c gc.reflogExpire=0 -c gc.reflogExpireUnreachable=0 \
               -c gc.rerereresolved=0 -c gc.rerereunresolved=0 \
               gc --prune=now'

# blame bisect clean clone cherry-pick describe stash tag submodule
# TODO git log --follow -L<n,m:file> -- <file>
# }}}
# ledger {{{
alias ledg='cat ~/docs/documents/ledger/20*/* | ledger --pedantic -f ~/docs/documents/ledger/accounts -f - balance'
alias lb='ledg -B'
alias la='ledg -B "^assets" "^debts"'
alias lf='ledg -B "^income" "^expenses"'
alias lp='ledg -BX PLN "^assets" "^debts"'
alias lc='ledg -VX PLN "^assets" "^debts"'
# }}}
# }}}
