function _usage() {
  print -P "%F{red}usage:%f %F{green}%B${1}%b%f %F{cyan}${2}%f" >&2
  [[ -n "$3" ]] && print -P "       %F{white}${3}%f" >&2
}

function tmp() {
  local base="${${TMPDIR:-/tmp}%/}/workspaces"

  case "${1:-}" in
    # bare `tmp` — interactive: pick existing or create new
    "")
      local -a ws=("${base}"/*(N-/on))
      if (( ${#ws} == 0 )); then
        # no workspaces, create one
        tmp new
      elif (( $+commands[fzf] )); then
        # fzf pick from existing, with option to create
        local pick
        pick=$(printf '%s\n' "+ new workspace" "${ws[@]:t}" | fzf --prompt="workspace> " --height=40% --reverse)
        [[ -z "$pick" ]] && return
        [[ "$pick" == "+ new workspace" ]] && { tmp new; return }
        cd "${base}/${pick}"
      else
        tmp ls
      fi
      ;;
    new)
      local name="${2:-$(date +%Y%m%d-%H%M%S)}"
      local d="${base}/${name}"
      command mkdir -p "$d" && cd "$d"
      print -P "%F{green}↳%f %F{cyan}${name}%f" >&2
      ;;
    ls|list)
      local -a ws=("${base}"/*(N-/on))
      if (( ${#ws} == 0 )); then
        print -P "%F{white}no workspaces%f  %F{white}(run %F{green}tmp%f to create one)%f" >&2
        return 0
      fi
      local dir
      for dir in "${ws[@]}"; do
        local age=$(( EPOCHSECONDS - $(zstat +mtime "$dir") ))
        local h=$(( age / 3600 )) m=$(( (age % 3600) / 60 ))
        local when
        if (( h > 0 )); then when="${h}h${m}m ago"
        elif (( m > 0 )); then when="${m}m ago"
        else when="${age}s ago"
        fi
        local count=$(command ls -1A "$dir" 2>/dev/null | wc -l | tr -d ' ')
        local name="${dir:t}"
        if [[ "$PWD" == "$dir"* ]]; then
          print -P "%F{green}▸ ${name}%f  %F{white}${count} files  ${when}%f"
        else
          print -P "  ${name}  %F{white}${count} files  ${when}%f"
        fi
      done
      ;;
    cd)
      if [[ -z "$2" ]] && (( $+commands[fzf] )); then
        # no name given — fzf pick
        local -a ws=("${base}"/*(N-/:t))
        (( ${#ws} == 0 )) && { print -P "%F{white}no workspaces%f" >&2; return 1; }
        local pick=$(printf '%s\n' "${ws[@]}" | fzf --prompt="cd> " --height=40% --reverse)
        [[ -n "$pick" ]] && cd "${base}/${pick}"
        return
      fi
      [[ -n "$2" ]] || { _usage tmp "cd <name>" "cd into a workspace (omit name for picker)"; return 1; }
      local target="${base}/${2}"
      [[ -d "$target" ]] || { print -P "%F{red}not found:%f ${2}  %F{white}(try: tmp ls)%f" >&2; return 1; }
      cd "$target"
      ;;
    rm)
      if [[ -z "$2" ]] && (( $+commands[fzf] )); then
        # no name given — fzf pick (multi-select)
        local -a ws=("${base}"/*(N-/:t))
        (( ${#ws} == 0 )) && { print -P "%F{white}no workspaces%f" >&2; return 1; }
        local -a picks=(${(f)"$(printf '%s\n' "${ws[@]}" | fzf --multi --prompt="rm> " --height=40% --reverse)"})
        (( ${#picks} == 0 )) && return
        for p in "${picks[@]}"; do
          [[ "$PWD" == "${base}/${p}"* ]] && cd ~
          command rm -rf "${base}/${p}"
          print -P "%F{green}removed:%f ${p}" >&2
        done
        return
      fi
      [[ -n "$2" ]] || { _usage tmp "rm <name>" "delete a workspace (omit name for picker)"; return 1; }
      local target="${base}/${2}"
      [[ -d "$target" ]] || { print -P "%F{red}not found:%f ${2}  %F{white}(try: tmp ls)%f" >&2; return 1; }
      [[ "$PWD" == "$target"* ]] && cd ~
      command rm -rf "$target"
      print -P "%F{green}removed:%f ${2}" >&2
      ;;
    clean)
      local -a ws=("${base}"/*(N-/))
      if (( ${#ws} == 0 )); then
        print -P "%F{white}nothing to clean%f" >&2
        return 0
      fi
      print -P "%F{magenta}${#ws}%f workspaces"
      read -q "?delete all? [y/N] " || { echo; return 0; }
      echo
      [[ "$PWD" == "$base"* ]] && cd ~
      command rm -rf "$base"
      print -P "%F{green}cleaned%f" >&2
      ;;
    -h|--help|help)
      print -P "%F{green}%Btmp%b%f — throwaway workspaces %F{white}(auto-deleted on reboot)%f"
      echo ""
      print -P "  %F{green}tmp%f                  interactive picker %F{white}(or create if none exist)%f"
      print -P "  %F{green}tmp new%f %F{cyan}[name]%f      new workspace %F{white}(default: timestamp)%f"
      print -P "  %F{green}tmp ls%f                list all workspaces"
      print -P "  %F{green}tmp cd%f %F{cyan}[name]%f      cd into workspace %F{white}(fzf picker if no name)%f"
      print -P "  %F{green}tmp rm%f %F{cyan}[name]%f      delete workspace %F{white}(fzf multi-select if no name)%f"
      print -P "  %F{green}tmp clean%f             delete all workspaces"
      print -P "  %F{green}tmp%f %F{cyan}<name>%f         create or cd into named workspace"
      ;;
    *)
      local d="${base}/${1}"
      if [[ -d "$d" ]]; then
        cd "$d"
      else
        command mkdir -p "$d" && cd "$d"
        print -P "%F{green}↳%f %F{cyan}${1}%f" >&2
      fi
      ;;
  esac
}