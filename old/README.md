# What is this?
my homelab dotfiles

thats about it :3

# VM GUIDE:

### Create SSH tunnel:
run on laptop
  ```sh
  ssh -L 5900:localhost:5900 user@your-homelab-ip
  ```
### Create new VM:
arch example, CHANGE THE PORT FOR EACH NEW MACHINE

run on homelab
```sh
virt-install \
  --name archbtw \
  --memory 4096 \
  --vcpus 2 \
  --disk size=20,format=qcow2 \
  --cdrom /path/to/arch.iso \
  --os-variant archlinux \
  --network network=default \
  --graphics spice,listen=127.0.0.1,port=5901 \
  --video qxl \
  --sound ich9 \
  --boot cdrom,menu=on
```
### Remote into VM with GUI:
run on laptop
```sh
    remote-viewer spice://localhost:5900
```
### 🔗 Quick Connect Steps
SSH with port forward: `ssh -L 5900:localhost:5900 user@host`

Keep that session open

Launch remote-viewer pointing to localhost:5900
### list of ports and VM's
- there are none
- ive not made any
