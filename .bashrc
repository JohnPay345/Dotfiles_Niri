# Алиасы
alias ls='eza --icons=always --group-directories-first'
alias ll='eza -lbF --icons=always --group-directories-first --git'
alias la='eza -labF --icons=always --group-directories-first --git'
alias lt='eza --tree --level=2 --icons=always'
alias ltl='eza -lbF --tree --level=2 --icons=always --git'
alias update-grub="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub_arch && sudo grub-mkconfig -o /boot/grub/grub.cfg"

if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi

# 1. Находим и подключаем скрипт git-prompt (путь может слегка отличаться в разных ОС)
if [ -f /usr/lib/git-core/git-sh-prompt ]; then
  source /usr/lib/git-core/git-sh-prompt
elif [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# 2. Включаем отображение статусов (опционально)
GIT_PS1_SHOWDIRTYSTATE=1     # Появится *, если есть измененные файлы
GIT_PS1_SHOWUNTRACKEDFILES=1 # Появится %, если есть новые неотслеживаемые файлы
GIT_PS1_SHOWUPSTREAM="auto"  # Покажет стрелочки < >, если ветка о

if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
fi

# Функция определения ветки Git с иконкой
parse_git_branch() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git branch --show-current 2>/dev/null)
    if [ -z "$branch" ]; then
      branch=$(git rev-parse --short HEAD 2>/dev/null)
    fi

    # Проверяем статус (есть ли незакоммиченные изменения)
    local status_char=""
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      status_char="   " # Иконка измененного файла (Nerd Font)
    fi

    # Вывод: [ main   ] в оранжевом цвете (208)
    echo -n "( ${branch})"
  fi
}

# Функция динамической сборки PS1
build_prompt() {
  local EXIT_CODE=$? # Запоминаем статус последней команды

  # Цветовая палитра (256-цветов)
  local C_USER='\[\e[38;2;185;110;60m\]' # Пастельный зеленый
  local C_DOG='\[\e[38;2;193;164;68m\]'
  local C_HOST='\[\e[38;2;66;185;60m\]'
  local C_DIR='\[\e[38;5;39m\]' # Ярко-голубой
  local C_GIT='\[\e[38;5;39m\]'
  local C_ARROW='\[\e[38;5;243m\]' # Серый для стрелок-разделителей
  local C_RESET='\[\e[0m\]'

  # Меняем цвет индикатора ввода в зависимости от успеха команды
  if [ $EXIT_CODE -eq 0 ]; then
    local C_PROMPT='\[\e[38;5;46m\]' # Зеленая стрелка успеха
  else
    local C_PROMPT='\[\e[38;5;196m\]' # Красная стрелка ошибки
  fi

  # Выбираем иконку папки: домашняя () или обычная ()
  local DIR_ICON=""
  if [ "$PWD" = "$HOME" ]; then
    DIR_ICON=""
  fi

  # Сборка строки:
  # Строка 1: 👤 имя_пользователя  / путь [ ветка]
  # Строка 2:
  PS1="${C_USER}\u${C_RESET}${C_DOG}@${C_RESET}${C_HOST}\h${C_RESET}${C_DIR} ${DIR_ICON} \w${C_RESET} ${C_GIT}\$(parse_git_branch)${C_RESET}\n${C_PROMPT}${C_RESET} 󱞩 "
}

PROMPT_COMMAND=build_prompt

EDITOR=nvim

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
