# Setup a swarm cluster on Azure IaaS using Terraform #

## Prerequisite ##
* Azure CLI & Terraform installed
* Azure subscription available
* ssh key pair in the /ssh folder (can be initialized using `ssh-key-init.sh` script in `dev-tools` folder)

## Usage ##
* login to your azure subscription: `az login`
    * switch to the desired subscription with Azure CLI : `az account set -s SUBSCRIPTION_NAME`
* Initialize terraform (fetch needed modules & providers): `terraform init`
    * the `-upgrade` flag will check for upgrade on already installed modules / plugins
* Use terraform: 
    * load required modules: `terraform get`
    * graph your resources: `terraform graph`
        * use Graphviz for plotting: https://graphviz.gitlab.io/ or the web version http://www.webgraphviz.com/
    * plan your deployment: `terraform plan`
        * it possible to plan for other action, like destroy: `terraform plan -destroy`
    * apply your changes: `terraform apply`
        * Optionnaly, override variables to suit your needs:
            * create a file named `configs.tfvars` in the project directory and override variables as you wish
            * deploy your setup: `terraform apply -var-file="configs.tfvars"`
    * destroy deployed resources: `terraform destroy`
        * it is possible to specify a specific resource with the `-target RESOURCE_ADDDRESS` option, be carefull with dependancies !
    * tips : the `-auto-approve` flag can be used to bypass user validation on any terraform command

## Roadmap ##
- [ ] FIX - Find a way to execute vm-init script when vm are re-created (PB: after a modification, scripts played from admin VM are not played again)
- [ ] FIX - fix the traffic manager endpoint creation failure 
- [ ] FIX - fix issue preventing addition of manager to the swarm (NSG issue ? check docker daemon log)
- [ ] FEATURE - Add a firewall rule on MySQL service, allowing only swarm workers to connect
- [ ] FEATURE - Extract the AG in a module
- [ ] COMPONENT - Add a keyvault to store ssh keys
- [ ] COMPONENT - Add a backup Recovery Vault
- [ ] FEATURE - Add nodes ID address in all nodes hosts (to enable usage of SSH Aliases)
- [ ] FEATURE - Setup the NFS mount on cluster creation  /OR/ automate cloudstor installation for docker swarm (on worker VM)
- [ ] FEATURE - Setup the Swarm cluster on top of the VM cluster
- [ ] UPDATE - Setup SSH aliases using ssh config (add ssh host .ssh/config, and then use shortnames in bash_aliases)
- [ ] UPDATE - Use a custom OS image preinstalled with docker (?)
- [ ] UPDATE - Setup the VM using cloud-init (?)
- [ ] UPDATE - change terraform ressources naming using underscores "_" instead of dash "-", and simplify ressources name to avoid long references when using interpolation
- [ ] FEATURE - Setup a module / modules (with input var and ouput) with a clear folder structure to have a reusable swarm cluster build (maybe setup low level modules like VM+NIC, vnet+subnet+nsg+rules, etc ?)
- [ ] UPDATE - module hosting on github
- [ ] UPDATE - Add a remote Terraform backend (state sharing) to work as a team
- [X] COMPONENT - Add an Application Gateway (with it's set of rules, certs, etc)
- [X] COMPONENT - Add a Traffic Manager
- [X] COMPONENT - Add a Redis managed service
- [X] COMPONENT - Add a MySQL managed service
- [X] FEATURE - Use separated ssh keys for admin / managers / workers
- [X] FEATURE - Add a .tfvar exemple for setup
- [X] FEATURE - calcultate subnet range using cidrsubnet() terraform function & correct CIDR subnet mask
- [X] FEATURE - Add a storage acount
- [X] Align resources ID naming (ex : manager-0 with alias man-1, to correct)
- [X] Setup static ip for swarm nodes & add variable for VNET / subnet masks (?)
- [X] extract vnet / subnet mask in var
- [X] Refine NSG rules of subnets (SSH on amdin public IP, close inbound by default, allow ssh between admin and managers / workers, open swarm ports between managers / workers)
- [X] Don't wait for ssh command to end (ex : docker install)
- [X] Rename "docker-install" to "vm-init"
- [X] Apply VM docker install on managers / worker trought admin vm
- [X] Remove public IP + associated NSG rules (managers / worker) => 
- [X] Add SSH aliases to admin VM
- [X] Add an admin VM (separated subnet & NSG)
- [X] variabilize the infrastructure deployment (number of machines, sizes, etc)
- [X] Swarm cluster infrastructure deployment (manager + worker + all the storage / network stack)

## Resources ##

### Terraform doc: ###
Full documentation : https://www.terraform.io/docs/index.html

* resource configuration: https://www.terraform.io/docs/configuration/resources.html
* interpolation: https://www.terraform.io/docs/configuration/interpolation.html
    * Build-in functions: https://www.terraform.io/docs/configuration/interpolation.html#supported-built-in-functions
* variables: https://www.terraform.io/docs/configuration/variables.html
* resources addressing: https://www.terraform.io/docs/internals/resource-addressing.html
* graph: https://www.terraform.io/docs/commands/graph.html
* external datasource: https://www.terraform.io/docs/providers/external/data_source.html
* modules: https://www.terraform.io/docs/modules/index.html
* backends : https://www.terraform.io/docs/backends/index.html

### Swarm cluster setup examples: ###
* build a swarm cluster on Scaleway  with TF: https://github.com/stefanprodan/scaleway-swarm-terraform
* build a swarm cluster on Azure ACS with TF: https://github.com/vfarcic/cloud-provisioning/tree/master/terraform/azure
* build a swarm cluster on Digital Ocean with TF: https://knpw.rs/blog/docker-swarm-terraform/

### Azure ###
* Linux general purpose VM sizes: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/sizes-general
* list available VM images by region: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage
* List VM tiers available for an availability set: https://docs.microsoft.com/en-us/cli/azure/vm/availability-set?view=azure-cli-latest#az-vm-availability-set-list-sizes

### Unix ###
* add ssh aliases: https://scotch.io/tutorials/how-to-create-an-ssh-shortcut

### Docker ###
* Firewall configuration for Swarm: https://www.digitalocean.com/community/tutorials/how-to-configure-the-linux-firewall-for-docker-swarm-on-ubuntu-16-04

### blogs ###
* Gruntwork post series :
    1. Why Terraform: https://blog.gruntwork.io/why-we-use-terraform-and-not-chef-puppet-ansible-saltstack-or-cloudformation-7989dad2865c
    2. Introduction to Terraform: https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180
    3. Terraform state management: https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
    4. Terraform module creation: https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d






