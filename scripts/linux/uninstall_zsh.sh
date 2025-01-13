#!/bin/bash

# 检查权限
if [ "$EUID" -ne 0 ]; then
  echo "请以 root 或使用 sudo 运行此脚本。"
  exit 1
fi

echo "开始卸载 Zsh 和相关配置..."

# 切换默认 Shell 回 Bash
echo "切换默认 Shell 回 Bash..."
chsh -s $(which bash) || {
  echo "切换默认 Shell 失败！"
  exit 1
}

# 删除 Oh My Zsh 及相关配置
echo "删除 Oh My Zsh 和相关文件..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  rm -rf "$HOME/.oh-my-zsh"
fi

# 删除 Powerlevel10k 主题
echo "删除 Powerlevel10k 主题..."
if [ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  rm -rf "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# 删除 Zsh 插件
echo "删除 Zsh 插件..."
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi
if [ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  rm -rf "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

# 删除 Zsh 配置文件
echo "删除 Zsh 配置文件..."
if [ -f "$HOME/.zshrc" ]; then
  rm -f "$HOME/.zshrc"
fi
if [ -f "$HOME/.p10k.zsh" ]; then
  rm -f "$HOME/.p10k.zsh"
fi

# 卸载 Zsh
echo "卸载 Zsh..."
apt remove --purge zsh -y || {
  echo "卸载 Zsh 失败！"
  exit 1
}

# 清理无用的软件包
echo "清理无用的软件包..."
apt autoremove -y && apt autoclean

bash
echo "卸载完成，终端已切换回 Bash。"
echo "建议重新启动终端以确保设置生效！"
