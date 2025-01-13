#!/bin/bash

# 检查权限
if [ "$EUID" -ne 0 ]; then
  echo "请以 root 或使用 sudo 运行此脚本。"
  exit 1
fi

# 更新系统并安装必要工具
echo "正在安装必要软件..."
apt update && apt install -y wget git curl vim zsh

# 安装 Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "正在安装 Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh 已存在，跳过安装..."
fi

# 切换默认 Shell 为 Zsh
echo "切换默认 Shell 为 Zsh..."
chsh -s $(which zsh)

# 安装 Powerlevel10k 主题
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "正在安装 Powerlevel10k 主题..."
  git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
else
  echo "Powerlevel10k 主题已存在，跳过安装..."
fi

# 安装 Zsh 插件
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  echo "正在安装 zsh-autosuggestions 插件..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
  echo "zsh-autosuggestions 插件已存在，跳过安装..."
fi

if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  echo "正在安装 zsh-syntax-highlighting 插件..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting 插件已存在，跳过安装..."
fi

# 配置 Zsh
echo "配置 Zsh..."
cat << 'EOF' > ~/.zshrc
# Oh My Zsh 配置
ZSH_THEME="powerlevel10k/powerlevel10k"

# 启用插件
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# 加载 Oh My Zsh
source $ZSH/oh-my-zsh.sh
EOF

# 配置 Powerlevel10k
echo "配置 Powerlevel10k..."
cat << 'EOF' > ~/.p10k.zsh
# Powerlevel10k configuration
POWERLEVEL9K_MODE='nerdfont-complete'

# Left prompt elements
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir vcs python_venv)

# Right prompt elements
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs battery time)

# Colors and styles
POWERLEVEL9K_OS_ICON_FOREGROUND=32
POWERLEVEL9K_OS_ICON_BACKGROUND=237
POWERLEVEL9K_DIR_FOREGROUND=117
POWERLEVEL9K_DIR_BACKGROUND=234
POWERLEVEL9K_STATUS_OK_FOREGROUND=76
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=196
POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND=226
POWERLEVEL9K_BATTERY_CHARGED_FOREGROUND=46

# Git integration
POWERLEVEL9K_VCS_BRANCH_ICON='\uE725'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=202
POWERLEVEL9K_VCS_CLEAN_BACKGROUND=46
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=178

# Time format
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'

# Python virtualenv
POWERLEVEL9K_PYTHON_ICON='\uE235'
POWERLEVEL9K_PYTHON_FOREGROUND=106
POWERLEVEL9K_PYTHON_BACKGROUND=237

# Battery settings
POWERLEVEL9K_BATTERY_ICON='\uF240'

# Command execution time threshold
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1.5
EOF

# 提示字体安装
echo "请确保安装支持 Nerd Fonts 的字体（如 MesloLGS NF）以获得最佳效果！"

# 切换到 Zsh 并加载配置
echo "切换到 Zsh 并加载配置..."
export SHELL=$(which zsh)
exec zsh -c "source ~/.zshrc && echo 'Powerlevel10k 配置已生效！'"
echo "重启终端生效"
echo "输入 p10k configure 命令重新自定义样式"