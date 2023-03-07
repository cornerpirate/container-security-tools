# container-security-tools

Tools to make container pentesting slightly easier. Mild gains at best.

# dprenum.sh

You can find private docker registries. These will be accessible over HTTP and you can "pull" and "push" images to them depending on how they are configured. Scenario (7 of kubernetes-goat)[https://madhuakula.com/kubernetes-goat/docs/scenarios/scenario-7] explains this eloquently.

Vulnerable Target: 

Dprenum will access the ```/v2/_catalog``` URL to list all available images. You can then choose to pull one or all of them at once.

Usage: dprenum -h <host> -p <port>

```bash
./dprenum.sh -h 127.0.0.1 -p 1235
[*] host: 127.0.0.1, port: 1235
[*] listing available images
============
1) madhuakula/k8s-goat-alpine
2) madhuakula/k8s-goat-users-repo
3) DOWNLOAD ALL IMAGES
============
Which image(s) do you want to pull down? 2
============
[*] pulling down  madhuakula/k8s-goat-users-repo
Using default tag: latest
latest: Pulling from madhuakula/k8s-goat-users-repo
df20fa9351a1: Already exists 
36b3adc4ff6f: Pull complete 
7031d6d6c7f1: Pull complete 
81b7f5a7444b: Pull complete 
0f8a54c5d7c7: Pull complete 
536ef5475913: Pull complete 
Digest: sha256:c538145a114bab7a8c0f61cd6234252d59266f17e3e264e0c037872981accb5d
Status: Downloaded newer image for 127.0.0.1:1235/madhuakula/k8s-goat-users-repo:latest
127.0.0.1:1235/madhuakula/k8s-goat-users-repo:latest
```

From there you can run ```docker images``` and find your new images:

```bash
docker images | grep 127                                        
127.0.0.1:1235/madhuakula/k8s-goat-users-repo   latest          87052f400e15   2 years ago     78.9MB
```

Then you can get a root level shell into these by running them as normal, access config files, source code etc.
