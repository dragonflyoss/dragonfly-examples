#!/bin/bash

echo "######## step1 generate server"
# step 1 为服务器端和客户端准备公钥、私钥
# 生成服务器端私钥
openssl genrsa -out server.key 1024
# 生成服务器端公钥
openssl rsa -in server.key -pubout -out server.pem


echo "######## step2 generate ca certificate"
# step 2 生成 CA 证书
# 生成客户端私钥
openssl genrsa -out client.key 1024
# 生成客户端公钥
openssl rsa -in client.key -pubout -out client.pem

# 生成 CA 私钥
openssl genrsa -out ca.key 1024
# X.509 Certificate Signing Request (CSR) Management.
cat ./content | openssl req -new -key ca.key -out ca.csr
# X.509 Certificate Data Management.
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt

# ➜  keys  openssl req -new -key ca.key -out ca.csr
# You are about to be asked to enter information that will be incorporated
# into your certificate request.
# What you are about to enter is what is called a Distinguished Name or a DN.
# There are quite a few fields but you can leave some blank
# For some fields there will be a default value,
# If you enter '.', the field will be left blank.
# -----
# Country Name (2 letter code) [AU]:CN
# State or Province Name (full name) [Some-State]:Zhejiang
# Locality Name (eg, city) []:Hangzhou
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:My CA
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []:localhost
# Email Address []:


echo "######## step3 generate client"
# step 3 生成服务器端证书和客户端证书
# 服务器端需要向 CA 机构申请签名证书，在申请签名证书之前依然是创建自己的 CSR 文件
cat ./content | openssl req -new -key server.key -out server.csr
# 向自己的 CA 机构申请证书，签名过程需要 CA 的证书和私钥参与，最终颁发一个带有 CA 签名的证书
openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in server.csr -out server.crt

# client 端
cat ./content | openssl req -new -key client.key -out client.csr
# client 端到 CA 签名
openssl x509 -req -CA ca.crt -CAkey ca.key -CAcreateserial -in client.csr -out client.crt
