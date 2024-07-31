### Raspberry Pi’nizin IP adresi görünmüyor olabilir veya bağlantıda bir sorun olabilir. Bağlantıyı doğrulamak ve tekrar denemek için aşağıdaki adımları izleyebilirsiniz:

1. Raspberry Pi’yi Yeniden Başlatma

	•	Raspberry Pi’yi yeniden başlatın ve Ethernet kablosu ile Mac’e bağlı olduğundan emin olun.

2. IP Adresini Tekrar Kontrol Etme

	•	Terminal’de aşağıdaki komutu tekrar çalıştırarak bağlı cihazları kontrol edin:

```bash 
arp -a
``` 
3. mDNS Kullanarak Bağlanma

	•	Raspberry Pi’niz station1.local adıyla da bağlanabilir. Aşağıdaki komutu deneyin:
```bash 
ssh pi@station1.local
``` 
4. IP Adresini Manuel Bulma

	•	Eğer hala IP adresini bulamıyorsanız, Raspberry Pi’de şu komutu çalıştırarak IP adresini öğrenebilirsiniz:
```bash
hostname -I
``` 
Bu komut size Raspberry Pi’nin bağlı olduğu ağdaki IP adresini verecektir.

5. IP Adresi ile Bağlanma

	•	IP adresini öğrendikten sonra, Mac Terminal’de SSH ile bağlanmak için aşağıdaki komutu kullanın:
```bash 
ssh pi@[bulduğunuz_ip_adresi]
```
Eğer bu adımlar sorunları çözmezse, bağlantıda başka bir problem olabilir. Bu durumda, bağladığınız kabloyu ve ağ ayarlarını tekrar kontrol edebilir ya da farklı bir yöntem (Wi-Fi ile bağlantı gibi) deneyebilirsiniz. Herhangi bir sorunda tekrar bana yazabilirsiniz.


#### Raspi güncellemeleri
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

#### 1. DNS Ayarlarını Kontrol Etme
sudo nano /etc/resolv.conf

Dosyaya aşağıdaki satırları ekleyin

Google DNS sunucuları
nameserver 8.8.8.8
nameserver 8.8.4.4

Cloudflare DNS 
nameserver 1.1.1.1
nameserver 1.0.0.1

#### 2. Paket Listesini Güncelleme
DNS ayarlarını değiştirdikten sonra, paket listesini güncelleyip eksik paketleri tekrar yüklemeyi deneyin:
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



### Ray cluster başlat
#### Mac Üzerinde Ray Head Node Başlatma
#### Mac bilgisayarınızın IP adresini bul

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



en0 arayüzünün altındaki inet satırında IP adresinizi görebilirsiniz. Örnek olarak, IP adresiniz 192.168.1.100 olsun.


#### Ubuntu Sanal Makinesinde Ray Worker Node'u Başlatma
#### Ray worker node'unu Mac'inizin IP adresine bağlanacak şekilde başlatı
#### Doğru IP Adresi ile Ray Head Node'u Başlatma
```bash
ray start --address='192.168.1.100:6379'
ray start --address='MAC_IP_ADDRESS:6379'
ray start --head --node-ip-address=192.168.0.4 --port=6379
```

#### Dağıtık Python Script'i Oluşturma ve Çalıştırma
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

### Multipass İçinde Köprülü Ağ Yapılandırma
- Multipass GUI'yi açın ve "Settings" bölümüne gidin. "Virtualization" altında, "Bridged network" ayarını en0 (veya aktif ağ arayüzünüz) olarak ayarlayın

- Yeni Ubuntu VM Oluşturun
```bash
multipass launch --network en0 --name my-ubuntu-vm
```

- IP Adreslerini Kontrol Edin
```bash 
multipass list
```

- Ray Worker Node'u Ubuntu VM'de Başlatma
```bash
multipass shell my-ubuntu-vm
multipass shell incisive-poodle
```

- Sanal makinede:
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

### Ubuntu Sanal Makinenizde Python ve Ray Sürümünü Düşürme
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


#### Mac Üzerinde Ray Head Node'u Başlatma
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379
```
#### Ubuntu Sanal Makinesinde Ray Worker Node'u Başlatma
```bash
ray start --address='192.168.0.4:6379'
```

#### Ray Dashboard'u Kullanma
```bash
pip install -U "ray[default]"
```
1. Ray Dashboard'u Başlatma
```bash
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0
```
2. Dashboard'a Erişim

```bash
http://192.168.0.4:8265
```
- Ray Dashboard'un Başlatıldığından Emin Olun
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0
```
- Dashboard Portunu ve IP Adresini Kontrol Edin
```bash
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0 --dashboard-port 8888
```
- Bu durumda, Dashboard'a şu URL'den erişmelisiniz:
```bash
http://192.168.0.4:8888
```
- Firewall ve Ağ Ayarlarını Kontrol Edin
Mac bilgisayarınızdaki firewall ayarlarının Dashboard'a erişimi engellemediğinden emin olun. Ayrıca, Mac ve Ubuntu sanal makinenizin aynı ağda olduğundan ve birbirlerine erişebildiklerinden emin olun.
- Ray Dashboard'un Durumunu Kontrol Edin
Ray Dashboard'un başlatılıp başlatılmadığını ve hangi portta çalıştığını kontrol etmek için Ray'ın durum komutlarını kullanabilirsiniz:
```bash 
ray status
```
- Ray Dashboard'u Manuel Olarak Başlatın 
Ray Dashboard'u manuel olarak başlatmayı deneyin:
1. Ray head node'unu başlatın (Dashboard olmadan):
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379 --include-dashboard=false

```
2. Dashboard'u ayrı bir terminal penceresinde başlatın:
```bash
ray dashboard --port 8265

ray dashboard http://192.168.0.4:8265
```

-  Ray Dashboard Loglarını Kontrol Edin
Dashboard'un neden başlatılmadığını anlamak için logları kontrol edin. Ray log dosyalarını bulmak için Ray'ın log dizinine bakabilirsiniz:
```bash
ls /tmp/ray/session_latest/logs/
```

#### Dağıtık Script'in Mac Üzerinde Çalıştırılması
script sadece Mac bilgisayarınızda bulunacak ve buradan çalıştırılacak. İşte dağıtık script'in tam adımları:
1. Ray Cluster'ı Başlatma
- Mac Üzerinde Ray Head Node'u Başlatma
```bash
ray stop
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0
ray start --head --node-ip-address=192.168.0.4 --port=6379 --dashboard-host 0.0.0.0 --dashboard-port 8265

```
- Ubuntu Sanal Makinesinde Ray Worker Node'u Başlatma
```bash
ray start --address='192.168.0.4:6379'
```
2. Dağıtık Python Script'ini Oluşturma ve Çalıştırma
- distributed_tinyllama.py script'ini Mac bilgisayarınızda çalıştırarak 
```bash
pip install git+https://github.com/ollama/ollama-python.git
pip install llama-index-llms-ollama 
pip install llama-index qdrant_client torch transformers

pip install llama_index
```

3. Script'i Çalıştırma
```bash
echo "What is the use case of div tag in html?" | python distributed_tinyllama.py
```

4. Ray Dashboard ve İzleme
```bash
http://192.168.0.4:8265
```
