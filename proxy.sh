docker run --rm --name docker_registry_proxy -d \
       -p 0.0.0.0:3128:3128 \
       -v $(pwd)/docker_mirror_cache:/docker_mirror_cache \
       -v $(pwd)/docker_mirror_certs:/ca \
       -e REGISTRIES="registry.k8s.io gcr.io quay.io your.own.registry another.public.registry zjharbor.com" \
       -e AUTH_REGISTRIES="auth.docker.io:dockerhub_username:dockerhub_password your.own.registry:username:password" \
       rpardini/docker-registry-proxy:0.2.4
