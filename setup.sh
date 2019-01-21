#!/bin/bash

# ------------------------
# 時刻同期
# ------------------------
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sudo sed -i 's/#NTP=/NTP=ntp.nict.jp/g' /etc/systemd/timesyncd.conf

# ------------------------
# OSアップデート
# ------------------------
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt clean -y

# ------------------------
# pyenvの環境設定
# ------------------------
sudo apt install -y git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev vim
git clone git://github.com/yyuu/pyenv.git ${HOME}/.pyenv
cat << EOF >> ${HOME}/.profile
export PYENV_ROOT=\${HOME}/.pyenv
export PATH=\${PYENV_ROOT}/bin:\${PATH}
eval "\$(pyenv init -)"
EOF
source ${HOME}/.profile
pyenv install 3.6.8
pyenv global 3.6.8
pyenv rehash

# ------------------------
# talibのインストール
# ------------------------
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -zxvf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure --prefix=/usr
sudo make
sudo make install
cd ../
sudo rm -rf ta-lib-0.4.0-src.tar.gz
sudo rm -rf ta-lib
pip install TA-Lib
cd ~

# ------------------------
# 完了
# ------------------------
echo "------------------------"
echo "complete."
python --version
echo "Restart your computer."
echo "------------------------"
