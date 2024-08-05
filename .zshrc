# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# commands for terminals other than Warp
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
    source ~/.zsh/ohmyzsh/lib/completion.zsh
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
else
    [[ ! -f ~/.p10k_warp.zsh ]] || source ~/.p10k_warp.zsh
fi


# MANUAL SOURCES
source <(eksctl completion zsh)
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
source ~/.zsh/ohmyzsh/plugins/kubectl/kubectl.plugin.zsh
source ~/.zsh/ohmyzsh/plugins/git/git.plugin.zsh
source ~/.zsh/ohmyzsh/plugins/common-aliases/common-aliases.plugin.zsh

# MANUAL ENVS EXPORTS
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ZSH SETTINGS
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

setopt auto_cd

# MANUAL ALIASES
alias chrome='open -a /Applications/Google\ Chrome.app'
alias kx='kubectx'
alias kxu='kubectx -u'
alias ks='kubens'
alias tf='terraform'

# MANUAL SCRIPTS
function k8s_wireshark() {
    if [ $# -eq 0 ]; then
        echo "Missing arguments."
        return 1
    fi

    kubectl exec "$@" -- tcpdump -i any -w - | Wireshark -k -i -
}

