# Patching And Rebooting CDN Servers
This repo is capable of patching and rebooting the CDN servers sequentially.

## Technologies
- Ansible
- Bash

## Inventory
On file [hosts.txt](./hosts.txt) there is a static list of all the **CDN** servers.

It is separated in groups/Tenants: Lab, Corp and Prod

We need to consider that this list is not dynamic. That means that we need to update it if necessary.

## Procedure  
### 1. Patching
It is recommended that we begin patching `cdnlab`, `cdncorp` and `cdnprod`. In that particular order.

First execute the script [patchingRun.sh](./patchingRun.sh). It will ask for a tenant to start. Then it will automatically run the playbook [patchingLinux.yaml](./patchingLinux.yaml)

```bash
$ ./patchingRun.sh
Pick a Tenant: cdnlab | cdncorp | cdnprod:
```

### 2. Rebooting and Validate afterwards
As a second step, we need to reboot the newly patched servers.
For that, we need to execute the script [rebootRun.sh](./rebootRun.sh)

It will ask for a tenant just like the first script:

```bash
$ ./rebootRun.sh
Pick a Tenant: cdnlab | cdncorp | cdnprod:
```

We should probably follow the same order: `cdnlab`, `cdncorp` and `cdnprod`.

That same script will execute the playbook [rebootLinux.yaml](./rebootLinux.yaml) and it will start rebooting the servers one by one.

If, in any case, one of the runs fails, the execution will **not** continue. This playbook is sequential `serial: 1`

The script will aso validate once the server is online. It will automatically use the script [validateCdn.sh](./validateCdn.sh) within each of the remote servers.

[validateCdn.sh](./validateCdn.sh) will make sure that the mount `/mnt/rsrcs` exists and also that the service `httpd` is **Active**

After that confirmation, the run will continue to the next server on the [host.txt](./hosts.txt) list.