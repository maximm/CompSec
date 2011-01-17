

#Generate private keys
openssl genrsa -out CA_key.pem 1024
openssl genrsa -out client_key.pem 1024
#Create CA.crt
openssl req -new -x509 -key CA_key.pem -out CA.crt -subj /CN="cim04mm6"/OU="datasek"/O="LTH"/L="lund"/ST="skane"/C="se"/
#Create a scr
openssl req -new -key client_key.pem -out client.csr -subj /CN="Bruce Lee"/OU=seattle/O=Hollywood/L=anykey/ST=washington/C=us
#Sign client.csr with the CA's certificate
openssl x509 -req -CA CA.crt -CAkey CA_key.pem -CAcreateserial -in client.csr -out client.crt 

#Generate a key pair and store in keystore called compseckeystore
keytool -genkeypair -dname "cn=Lady Gaga, ou=torment dept, o=succubi inc, l=9th circle, st=hell c=US" -alias gaga -keypass totally666 -keystore compseckeystore -storepass bestpassever123
#Make a certificate signing request for Lady Gaga called gaga.csr
keytool -certreq -file gaga.csr -alias gaga -keypass totally666 -keystore compseckeystore -storepass bestpassever123
#Sign gaga.csr with the CA's certificate
openssl x509 -req -CA CA.crt -CAkey CA_key.pem -CAcreateserial -in gaga.csr -out gaga.crt 
#import the CA to the keystore
keytool -importcert -alias ca -file CA.crt -keystore compseckeystore -storepass bestpassever123 -noprompt
#import Lady Gaga's certificate
keytool -importcert -alias gaga -file gaga.crt -keypass totally666 -keystore compseckeystore -storepass bestpassever123
#Check keystore
keytool -list -v -keystore compseckeystore -storepass bestpassever123

