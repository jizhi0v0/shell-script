#!/bin/sh
# 设置代理
export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153
# 开始检查更新
echo "brew update..."
brew update

# 开始更新软件
echo "brew upgrade..."
brew upgrade

# 开始清理
echo "brew cleanup..."
brew cleanup

# 获取macOS 应用程序、字体和插件以及其他非开源软件
caskapp=$(brew list --cask)

# 已经是最新版本的警告信息
latest_warn_info="the latest version is already installed"

upgraded_apps=("已更新")
# 遍历更新
for app in $caskapp
do
echo "try upgrade" "${app}"
# 终端输出信息
output_info=$(brew upgrade --cask "${app}" 2>&1)
is_contains_warn_info=$(echo "${output_info}" | grep "${latest_warn_info}")
if [ "${is_contains_warn_info}" != "" ]
    then continue
else
    upgraded_apps[${#upgraded_apps[@]}]=${app}
fi
done
if [ ${#array[*]} -gt 1 ]
    then
    echo ${upgraded_apps[@]}
else
    echo "无可用更新"
fi