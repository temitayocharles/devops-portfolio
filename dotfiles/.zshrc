# ================================
# SAFE, CLEAN & FAST .zshrc
# ================================

# ---- Powerlevel10k Instant Prompt ----
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- Oh My Zsh Base Config ----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# ---- Custom Aliases ----

## Navigation
alias wf='cd ~/Documents/WEBFORX'
alias pz='cd ~/Documents/PERSONAL'

## Git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gcm='git commit -m'
alias gco='git checkout'
alias gb='git branch'
alias gp='git push'
alias gpl='git pull'
alias gcl='git clone'
alias gca='git commit -am'
alias gcp='git add . && git commit -m'
alias gpush='git push origin $(git branch --show-current)'

## Terraform
alias ti='terraform init'
alias tv='terraform validate'
alias tp='terraform plan'
alias ta='terraform apply'
alias td='terraform destroy'
alias tf='terraform'
alias ts='terraform show'
alias tcd='terraform console'

## Kubernetes
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgd='kubectl get deployments'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kctx='kubectl config current-context'
alias kns='kubectl config set-context --current --namespace'
alias kgn='kubectl get nodes'

## Docker
alias d='docker'
# Custom formatted 'docker ps'
docker-psf() {
    docker ps --format "$DOCKER_PS_FORMAT" "$@"
}
alias dps='docker-psf'
alias dpa='docker ps -a'
alias di='docker images'
alias db='docker build -t'
alias drun='docker run -it --rm'
alias dstop='docker stop'
alias drm='docker rm'
alias dcd='docker-compose down'
alias dcu='docker-compose up -d'
alias dlog='docker logs -f'

# Docker ps format
export DOCKER_PS_FORMAT="ID\t{{.ID}}\nNAME\t{{.Names}}\nIMAGE\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}"

## VS Code
alias c='code .'

## File Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lah'
alias ltr='ls -ltrh'
alias ls='ls -G -F -C'

## System Utilities
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias myip='curl ifconfig.me'
alias ports='lsof -i -P -n | grep LISTEN'
alias brewup='brew update && brew upgrade'

## VS Code CLI
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"

## Locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

## Default Editor
export EDITOR='code -w'

## Autosuggestions Style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

## History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

## Zsh Behavior
setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_CD
setopt CORRECT

## Hide login message
touch ~/.hushlogin

## Docker CLI completion
fpath=(/Users/charlie/.docker/completions $fpath)
autoload -Uz compinit
compinit

## AWS Profile Aliases (deprecated, use cloud-manager)
alias aws-personal='export AWS_PROFILE=personal && echo "Switched to AWS_PROFILE=personal"'
alias aws-sandbox='export AWS_PROFILE=webforx-sandbox && echo "Switched to AWS_PROFILE=webforx-sandbox"'
alias aws-profile='echo "Current AWS_PROFILE=$AWS_PROFILE"'

# Default AWS profile
export AWS_PROFILE=superuser-charlie

# OCI SSH shortcut
alias oci='ssh -i ~/.ssh/oracle_key ubuntu@129.80.37.110'

# Powerlevel10k Theme Config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ---- Embedded Cloud Profile Manager ----

# File to persist profile state
CLOUD_STATE_FILE="$HOME/.cloud_profile_state"

restore_profiles() {
  if [[ -f "$CLOUD_STATE_FILE" ]]; then
    source "$CLOUD_STATE_FILE"
    echo "[INFO] Restored profiles: AWS=$AWS_PROFILE, OCI=$OCI_PROFILE"
  else
    echo "[INFO] No previous cloud profile state found."
  fi
}

save_profiles() {
  echo "export AWS_PROFILE=$AWS_PROFILE" > "$CLOUD_STATE_FILE"
  echo "export OCI_PROFILE=$OCI_PROFILE" >> "$CLOUD_STATE_FILE"
  echo "export OCI_AUTH=$OCI_AUTH" >> "$CLOUD_STATE_FILE"
}

show_status() {
  echo "--------------------------"
  echo "AWS Profile: ${AWS_PROFILE:-<unset>}"
  echo "OCI Profile: ${OCI_PROFILE:-<unset>} (auth: ${OCI_AUTH:-none})"
  echo "--------------------------"
  echo "[INFO] Verifying AWS identity..."
  if ! aws sts get-caller-identity --output json; then
    echo "[ERROR] AWS auth failed."
  fi
  echo "[INFO] Verifying OCI session..."
  if ! oci iam region list --profile "${OCI_PROFILE:-DEFAULT}" --auth "${OCI_AUTH:-api_key}" >/dev/null 2>&1; then
    echo "[INFO] OCI session expired. Re-authenticating..."
    oci session authenticate --profile "${OCI_PROFILE:-orisaseemife}"
  else
    echo "[INFO] OCI session is valid."
  fi
}

switch_aws_sso() {
  export AWS_PROFILE="webforx-sandbox"
  echo "[INFO] Switched to AWS SSO profile: $AWS_PROFILE"
  if ! aws sts get-caller-identity >/dev/null 2>&1; then
    echo "[INFO] SSO token expired. Logging in..."
    aws sso login --profile "$AWS_PROFILE"
  fi
  echo "[INFO] ✅ Current AWS identity:"
  aws sts get-caller-identity
  save_profiles
}

switch_aws_personal() {
  export AWS_PROFILE="personal"
  echo "[INFO] Switched to AWS personal profile."
  if ! aws sts get-caller-identity >/dev/null 2>&1; then
    echo "[ERROR] Failed to authenticate AWS personal profile."
  else
    echo "[INFO] ✅ Current AWS identity:"
    aws sts get-caller-identity
  fi
  save_profiles
}

switch_aws_staging() {
  export AWS_PROFILE="webforx-staging"
  echo "[INFO] Switched to AWS SSO profile: $AWS_PROFILE"
  if ! aws sts get-caller-identity >/dev/null 2>&1; then
    echo "[INFO] SSO token expired. Logging in..."
    aws sso login --profile "$AWS_PROFILE"
  fi
  echo "[INFO] ✅ Current AWS identity:"
  aws sts get-caller-identity
  save_profiles
}

switch_oci_session() {
  export OCI_PROFILE="orisaseemife"
  export OCI_AUTH="security_token"
  echo "[INFO] Switched to OCI session profile: $OCI_PROFILE"
  if ! oci iam region list --profile "$OCI_PROFILE" --auth "$OCI_AUTH" >/dev/null 2>&1; then
    echo "[INFO] Session expired. Authenticating..."
    oci session authenticate --profile "$OCI_PROFILE"
  fi
  echo "[INFO] ✅ Current OCI regions:"
  oci iam region list --profile "$OCI_PROFILE" --auth "$OCI_AUTH" --output table
  save_profiles
}
switch_aws_superuser() {
  export AWS_PROFILE="superuser-charlie"
  echo "[INFO] Switched to AWS profile: $AWS_PROFILE"
  if ! aws sts get-caller-identity >/dev/null 2>&1; then
    echo "[ERROR] Failed to authenticate superuser profile."
  else
    echo "[INFO] ✅ Current AWS identity:"
    aws sts get-caller-identity
  fi
  save_profiles
}


list_instances() {
  if [[ -n "${AWS_PROFILE:-}" ]]; then
    echo "[INFO] Listing AWS EC2 instances..."
    aws ec2 describe-instances --region us-east-1 \
      --query 'Reservations[].Instances[].InstanceId' --output table
  elif [[ -n "${OCI_PROFILE:-}" ]]; then
    echo "[INFO] Listing OCI compute instances..."
    local compartment_id
    compartment_id=$(oci iam compartment list \
      --query "data[?\"name\"=='root'].id | [0]" \
      --raw-output --profile "$OCI_PROFILE")
    oci compute instance list \
      --compartment-id "$compartment_id" \
      --profile "$OCI_PROFILE" --auth "$OCI_AUTH" \
      --query "data[*].\"display-name\"" --output table
  else
    echo "[ERROR] No active cloud profile selected."
  fi
}

show_current_profiles_only() {
  echo ""
  echo "🧭 ACTIVE PROFILES:"
  echo "   AWS_PROFILE=${AWS_PROFILE:-<unset>}"
  echo "   OCI_PROFILE=${OCI_PROFILE:-<unset>} (auth=${OCI_AUTH:-<unset>})"
}

main_menu() {
  echo ""
  echo "1) AWS: webforx-sandbox (SSO)"
  echo "2) AWS: personal (static)"
  echo "3) AWS: webforx-staging (SSO)"
  echo "4) OCI: orisaseemife (session)"
  echo "5) Show current status"
  echo "6) Show current AWS & OCI profiles only"
  echo "7) List instances"
  echo "8) AWS: superuser-charlie"
  echo "9) Exit"
  
  echo "========================================="
  read "choice?Enter choice [1-9]: "
  case "$choice" in
    1) switch_aws_sso ;;
    2) switch_aws_personal ;;
    3) switch_aws_staging ;;
    4) switch_oci_session ;;
    9) switch_aws_superuser ;;
    5) show_status ;;
    6) show_current_profiles_only ;;
    7) list_instances ;;
    8) echo "[INFO] Exiting..."; return ;;
    *) echo "[ERROR] Invalid choice" ;;
  esac
}

cloud_manager() {
  restore_profiles
  while true; do
    main_menu
  done
}
alias cloud-manager=cloud_manager

select_profile() {
  local choice=$(printf "aws-webforx-sandbox\naws-personal\naws-superuser\noci-session\ngit-personal\ngit-work\n" | fzf --prompt="🌐 Choose Profile: ")
  case "$choice" in
    aws-webforx-sandbox) switch_aws_sso ;;
    aws-personal) switch_aws_personal ;;
    aws-superuser) switch_aws_superuser ;;
    oci-session) switch_oci_session ;;
    git-personal) switch_git_personal ;;
    git-work) switch_git_work ;;
    *) echo "[ERROR] Unknown profile" ;;
  esac
}
alias profile-picker=select_profile


# ---- Git Profile Manager ----

# File to persist Git profile state
GIT_STATE_FILE="$HOME/.git_profile_state"

restore_git_profile() {
  if [[ -f "$GIT_STATE_FILE" ]]; then
    source "$GIT_STATE_FILE"
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    echo "[INFO] Restored Git profile: $GIT_NAME <$GIT_EMAIL>"
  else
    echo "[INFO] No previous Git profile found."
  fi
}

save_git_profile() {
  echo "export GIT_NAME=\"$GIT_NAME\"" > "$GIT_STATE_FILE"
  echo "export GIT_EMAIL=\"$GIT_EMAIL\"" >> "$GIT_STATE_FILE"
}

switch_git_personal() {
  export GIT_NAME="Charlie Temitayo"
  export GIT_EMAIL="your.personal@email.com"
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  echo "[INFO] Switched to Personal GitHub Profile."
  save_git_profile
}

switch_git_work() {
  export GIT_NAME="Charlie T. (Webforx)"
  export GIT_EMAIL="your.work@webforx.com"
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  echo "[INFO] Switched to Forgejo Work Profile."
  save_git_profile
}

show_git_status() {
  echo "--------------------------"
  echo "Git Profile: ${GIT_NAME:-<unset>} <${GIT_EMAIL:-unset}>"
  echo "--------------------------"
  git config --list | grep 'user.'
}

git_manager() {
  restore_git_profile
  while true; do
    echo ""
    echo "1) Personal GitHub Profile"
    echo "2) Work Forgejo Profile"
    echo "3) Show Current Git Profile"
    echo "4) Exit"
    echo "==============================="
    read "gchoice?Enter choice [1-4]: "
    case "$gchoice" in
      1) switch_git_personal ;;
      2) switch_git_work ;;
      3) show_git_status ;;
      4) echo "[INFO] Exiting..."; return ;;
      *) echo "[ERROR] Invalid choice" ;;
    esac
  done
}

alias git-manager=git_manager
# ---- End of Git Profile Manager ----

# ---- Custom Environment Variables ----
# Custom additions beyond this line
export PATH="/opt/homebrew/bin:$PATH"
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/keys/age.key"
export VAULT_ADDR="https://vault.edusuc.net"

# Run commands on EC2 instance via AWS SSM



# DockerNet EC2 instance ID (update with your actual instance ID)
# ~/.zshrc

# Lookup EC2 Instance ID by tags
# Lookup EC2 Instance ID by tag
function get_dockernet_instance_id() {
  aws ec2 describe-instances \
    --filters \
      "Name=tag:Project,Values=dockernet" \
      "Name=tag:Environment,Values=sandbox" \
      "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text
}

# Main SSM Runner Function
function ssm_run() {
  INSTANCE_ID="${1:-$(get_dockernet_instance_id)}"
  REGION="${2:-us-east-1}"
  shift 2
  CMD="$*"

  if [[ -z "$INSTANCE_ID" ]]; then
    echo "[ERROR] No valid instance ID found for project 'dockernet'. Aborting."
    return 1
  fi

  echo "[INFO] Running SSM command on instance: $INSTANCE_ID in $REGION"
  CMD_ID=$(aws ssm send-command \
    --document-name "AWS-RunShellScript" \
    --instance-ids "$INSTANCE_ID" \
    --parameters "commands=[\"$CMD\"]" \
    --region "$REGION" \
    --query "Command.CommandId" \
    --output text 2>/dev/null)

  if [[ -z "$CMD_ID" ]]; then
    echo "[ERROR] Failed to send command via SSM. Check permissions, region, or instance status."
    return 1
  fi

  sleep 5

  aws ssm list-command-invocations \
    --command-id "$CMD_ID" \
    --details \
    --region "$REGION" \
    --query "CommandInvocations[].CommandPlugins[].Output" \
    --output text
}

echo ""
echo "🛠  Current Profiles → AWS: ${AWS_PROFILE:-<unset>} | Git: ${GIT_NAME:-<unset>} <${GIT_EMAIL:-unset}>"
