#!/bin/bash

name=dragonflyoss/supernode
tag=0.3.0
reg=registry.cn-hangzhou.aliyuncs.com

# get auth token
curl -i "https://$reg/v2/$name/manifests/$tag" | grep -i 'www-authenticate'

# pull image layer
curl -i "https://$reg/v2/$name/blobs/$tag"
