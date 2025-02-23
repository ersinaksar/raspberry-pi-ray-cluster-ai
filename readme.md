### Your Raspberry Pi’s IP Address May Not Be Visible or There May Be a Connection Issue. You can follow the steps below to verify the connection and try again:

1. Restarting the Raspberry Pi

	•	Restart your Raspberry Pi and make sure it is connected to your Mac via an Ethernet cable.

2. Checking the IP Address Again

	•	Run the following command in the terminal again to check connected devices:

```bash 
arp -a
``` 
3. mDNS Connecting Using

	•	Your Raspberry Pi may also be accessible via station1.local. Try the following command:
```bash 
ssh pi@station1.local
``` 
4. Manually Finding the IP Address

	•	If you still cannot find the IP address, run the following command on your Raspberry Pi to retrieve its IP address:
```bash
hostname -I
``` 
This Command Will Display the IP Address of Your Raspberry Pi on the Network

5. Connecting via IP Address

	•	Once you have retrieved the IP address, use the following command in the Mac Terminal to connect via SSH:
```bash 
ssh pi@[bulduğunuz_ip_adresi]
```
If these steps do not resolve the issue, there might be another connection problem. In that case, you can check the cable connection and network settings again or try a different method (such as connecting via Wi-Fi). Feel free to reach out if you need further assistance.


#### Raspberry Pi Updates
```bash
sudo apt-get update --allow-releaseinfo-change
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -f
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 lsb-release software-properties-common
sudo add-apt-repository --remove ppa:webupd8team/atom


sudo apt-get upgrade
sudo apt-get update --allow-releaseinfo-change
sudo rm /etc/apt/sources.list.d/atom.list
sudo rm /etc/apt/sources.list.d/atom.list.save
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 lsb-release software-properties-common

sudo apt-get install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	lsb-release \
	software-properties-common

curl -fsSL https://download.docker.com/linux/raspbian/gpg | sudo apt-key add -


sudo nano /etc/apt/sources.list

Dosyanın sonuna aşağıdaki satırı ekleyin:
deb [arch=armhf] https://mirrors.aliyun.com/docker-ce/linux/raspbian buster stable


curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/raspbian/gpg | sudo apt-key add -


sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg2 lsb-release software-properties-common



```

#### 1. Checking DNS Settings
sudo nano /etc/resolv.conf

Add the following lines to the file:

Google DNS Servers
nameserver 8.8.8.8
nameserver 8.8.4.4

Cloudflare DNS 
nameserver 1.1.1.1
nameserver 1.0.0.1

#### 2. Updating the Package List
After changing the DNS settings, update the package list and try reinstalling any missing packages:
```bash 
sudo apt-get update
sudo apt-get install docker-ce
``` 



https://itsfoss.com/raspberry-pi-ollama-ai-setup/
#### setup of ollama for linux
```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama run tinyllama
```

```bash
pip uninstall ray
pip show ray
pip show ray llama-index-llms-ollama
sudo apt install python3.12-venv
python3 -m venv .venv
source .venv/bin/activate
pip install ray==2.34.0
```



### Starting the Ray Cluster
#### Starting the Ray Head Node on Mac
#### Find Your Mac’s IP Address

```bash
ifconfig
ray start --head --port=6379
```

``` 
Local node IP: 127.0.0.1

--------------------
Ray runtime started.
--------------------

Next steps
  
  To connect to this Ray cluster:
    import ray
    ray.init()
  
  To terminate the Ray runtime, run
    ray stop
  
  To view the status of the cluster, use
    ray status
```



You can find your IP address under the inet line of the en0 interface.


#### For example, your IP address might be 192.168.1.100
#### Starting the Ray Worker Node on an Ubuntu Virtual Machine
#### Starting the Ray Worker Node to Connect to Your Mac’s IP Address
```bash
ray start --address='192.168.1.100:6379'
ray start --address='MAC_IP_ADDRESS:6379'
ray start --head --node-ip-address=192.168.0.4 --port=6379
```

#### Creating and Running a Distributed Python Script
```bash
echo "Your input text here" | python distributed_tinyllama.py
```

```bash
ray stop
ray start --head --port=6379
ray start --address='192.168.0.4:6379'
hostname
ray start --address='hostname:6379'
ray start --head --port=6379 --log-to-driver
ray start --address='192.168.0.4:6379' --log-to-driver
```

### Configuring a Bridged Network in Multipass
- Open the Multipass GUI and go to the “Settings” section. Under “Virtualization”, set the “Bridged network” option to en0 (or your active network interface).

- Creating a New Ubuntu VM
```bash
multipass launch --network en0 --name my-ubuntu-vm
```

- Check the IP Addresses.
```bash 
multipass list
```

- Start the Ray Worker Node on the Ubuntu VM.
```bash
multipass shell my-ubuntu-vm
multipass shell incisive-poodle
```

- On the Virtual Machine:
```bash
sudo apt update
sudo apt install python3-pip
pip3 install ray
ray start --address='MAC_IP_ADDRESS:6379'
```


```bash
python --version
ray --version
```

### Downgrading Python and Ray Version on Ubuntu Virtual Machine
```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.10 python3.10-venv python3.10-dev
python3.10 -m venv .venv
source .venv/bin/activate
pip install ray==2.32.0
deactivate
```
Ray: 2.32.0
Python: 3.10.14


#### Starting the Ray Head Node on Mac
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379
```
#### Starting the Ray Worker Node on Ubuntu Virtual Machine
```bash
ray start --address='192.168.0.4:6379'
```

#### Using the Ray Dashboard
```bash
pip install -U "ray[default]"
```
1. Starting the Ray Dashboard
```bash
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0
```
2. Accessing the Dashboard

```bash
http://192.168.0.4:8265
```
- Ensure the Ray Dashboard is Running
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0
```
- Check the Dashboard Port and IP Address
```bash
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0 --dashboard-port 8888
```
- In this case, you should be able to access the Dashboard at the following URL:
```bash
http://192.168.0.4:8888
```
- Check Firewall and Network Settings
Ensure that the firewall settings on your Mac are not blocking access to the Dashboard. Also, verify that your Mac and Ubuntu virtual machine are on the same network and can communicate with each other.
- Check the Status of the Ray Dashboard
Use Ray’s status commands to check if the Ray Dashboard is running and on which port:
```bash 
ray status
```
- Manually Starting the Ray Dashboard 
Try starting the Ray Dashboard manually:
1. Start the Ray Head Node (without the Dashboard):
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379 --include-dashboard=false

```
2. Start the Dashboard in a separate terminal window:
```bash
ray dashboard --port 8265

ray dashboard http://192.168.0.4:8265
```

-  Checking Ray Dashboard Logs
Check the logs to understand why the Dashboard is not starting. You can find Ray log files in the Ray log directory:
```bash
ls /tmp/ray/session_latest/logs/
```

#### Running the Distributed Script on Mac
The script will only be located on your Mac and executed from there. Here are the full steps for running the distributed script:
1. Starting the Ray Cluster
- Start the Ray Worker Node on the Ubuntu Virtual Machine
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0 --dashboard-port 8265

```
- Start the Ray Worker Node on the Ubuntu Virtual Machine
```bash
ray start --address='192.168.0.4:6379'
```
2. Creating and Running the Distributed Python Script
- Run the distributed_tinyllama.py script on your Mac. 
```bash
pip install git+https://github.com/ollama/ollama-python.git
pip install llama-index-llms-ollama 
pip install llama-index qdrant_client torch transformers

pip install llama_index
```

3. Executing the Script
- Run the script and monitor the execution.
```bash
echo "What is the use case of div tag in html?" | python distributed_tinyllama.py
```

4. Ray Dashboard and Monitoring
- Use the Ray Dashboard to track the execution and performance.
```bash
http://192.168.0.4:8265
```
