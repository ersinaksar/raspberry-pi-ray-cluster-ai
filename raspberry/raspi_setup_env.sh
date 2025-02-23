
#!/bin/bash

sudo apt update
sudo apt install -y wget build-essential libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev

wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz
tar -xf Python-3.10.4.tgz
cd Python-3.10.4

./configure --enable-optimizations
make -j 4 
sudo make altinstall

cd ..
python3.10 -m venv myenv
source myenv/bin/activate

python --version

# chmod +x setup_python.sh
# ./setup_python.sh
