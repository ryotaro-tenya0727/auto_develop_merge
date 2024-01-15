#!/bin/bash

# 切り替え先のブランチ
target_branch="develop"

git checkout develop
git pull origin develop

# すべてのブランチに対してdevelopをマージ
for branch in $(git branch | sed 's/\*//'); do
    # developブランチの場合はスキップ
    if [ "$branch" = "$target_branch" ]; then
        echo "Skipping $target_branch"
        continue
    fi

    # 切り替え先のブランチに移動
    git checkout $branch

    # developをマージ
    git merge $target_branch

    # マージが成功したかを確認
    if [ $? -eq 0 ]; then
        echo "Merged $target_branch into $branch"
    else
        echo "Failed to merge $target_branch into $branch"
    fi
done

git checkout develop