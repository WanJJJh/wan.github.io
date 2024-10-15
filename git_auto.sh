#!/bin/bash

# git_auto.sh - 一个自动执行 git add、commit 和 push 的脚本

# 检查是否在 Git 仓库中
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "错误: 当前目录不是一个 Git 仓库。请切换到正确的仓库目录。"
    exit 1
fi

# 获取提交信息
if [ -z "$1" ]; then
    echo "使用方法: $0 \"提交信息\""
    # exit 1
    COMMIT_MESSAGE = 'change'
else
    COMMIT_MESSAGE="$1"
fi


# 执行 git add
echo "正在添加所有更改到暂存区..."
git add .

if [ $? -ne 0 ]; then
    echo "错误: git add 失败。请检查你的更改并重试。"
    exit 1
fi

# 执行 git commit
echo "正在提交更改：$COMMIT_MESSAGE"
git commit -m "$COMMIT_MESSAGE"

if [ $? -ne 0 ]; then
    echo "错误: git commit 失败。请检查提交信息和更改。"
    exit 1
fi

# 执行 git push
echo "正在推送到远程仓库..."
git push origin academicpages

if [ $? -ne 0 ]; then
    echo "错误: git push 失败。请检查网络连接和远程仓库配置。"
    exit 1
fi

echo "成功: 更改已添加、提交并推送到远程仓库。"
