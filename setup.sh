#!/bin/bash

# ------------------------
# OSアップデート
# ------------------------
sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt clean -y

# ------------------------
# パッケージインストール
# ------------------------
sudo apt install -y build-essential libffi-dev zlib1g-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev

# ------------------------
# 時刻同期
# ------------------------
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sudo sed -i 's/#NTP=/NTP=time.google.com/g' /etc/systemd/timesyncd.conf

# ------------------------
# pyenvの環境設定
# ------------------------
git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv
cat << EOF >> ${HOME}/.profile
export PYENV_ROOT=\${HOME}/.pyenv
export PATH=\${PYENV_ROOT}/bin:\${PATH}
eval "\$(pyenv init --path)"
EOF
source ${HOME}/.profile
pyenv install 3.8.10
pyenv global 3.8.10
pyenv rehash
pip install -U pip

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
sudo rm -rf ta-lib*
pip install TA-Lib
cd ~

# ------------------------
# 完了
# ------------------------
echo "------------------------"
echo "complete."
python -V
pip -V
echo "Restart your computer."
echo "------------------------"
