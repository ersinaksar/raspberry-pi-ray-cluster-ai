#### Raspberry Pi’nizin IP adresi görünmüyor olabilir veya bağlantıda bir sorun olabilir. 
- Bağlantıyı doğrulamak ve tekrar denemek için aşağıdaki adımları izleyebilirsiniz:
1. Raspberry Pi’yi Yeniden Başlatma
	- Raspberry Pi’yi yeniden başlatın ve Ethernet kablosu ile Mac’e bağlı olduğundan emin olun.
2. IP Adresini Tekrar Kontrol Etme
	-	Terminal’de aşağıdaki komutu tekrar çalıştırarak bağlı cihazları kontrol edin:
```bash
arp -a
```
3. mDNS Kullanarak Bağlanma
	-	Raspberry Pi’niz station1.local adıyla da bağlanabilir. Aşağıdaki komutu den###eyin:
```bash
ssh pi@station1.local
```
4. IP Adresini Manuel Bulma
	-	Eğer hala IP adresini bulamıyorsanız, Raspberry Pi’de şu komutu çalıştırarak IP adresini öğrenebilirsiniz:
```bash
hostname -I
```
- Bu komut size Raspberry Pi’nin bağlı olduğu ağdaki IP adresini verecektir.
5. IP Adresi ile Bağlanma
	-	IP adresini öğrendikten sonra, Mac Terminal’de SSH ile bağlanmak için aşağıdaki komutu kullanın:
```bash
ssh pi@[bulduğunuz_ip_adresi]
```
- Eğer bu adımlar sorunları çözmezse, bağlantıda başka bir problem olabilir. Bu durumda, bağladığınız kabloyu ve ağ ayarlarını tekrar kontrol edebilir ya da farklı bir yöntem (Wi-Fi ile bağlantı gibi) deneyebilirsiniz. Herhangi bir sorunda tekrar bana yazabilirsiniz.