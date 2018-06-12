# Setup a swarm cluster on Azure IaaS using Terraform #

## Usage ##
* login to your azure subscription: `az login`
* Initialize terraform (fetch needed plugins & providers): `terraform init`
* Use terraform: 
    * load required modules: `terraform get`
    * graph your resources: `terraform graph`
        * use Graphviz for plotting: https://graphviz.gitlab.io/ or the web version http://www.webgraphviz.com/
    * plan your deployment: `terraform plan`
        * it possible to plan for other action, like destroy: `terraform plan -destroy`
    * apply your changes: `terraform apply`
    * destroy deployed resources: `terraform destroy`
        * it is possible to specify a specific resource with the `-target RESOURCE_ADDDRESS` option, carefull with dependancies !
    * tips : the `-auto-approve` flag can be used to bypass user validation on any terraform command

## Roadmap ##
 -[ ] Align resources ID naming -ex : manager-0 with alias man-1, to correct)
- [ ] Refine NSG rules of subnets (Capgemini IP . VPN IP, docker swarm ports, close all by default) 
- [ ] Rename "docker-install" to "vm-init"
- [ ] Don't wait for ssh command to end (ex : docker install)
- [ ] Use separated ssh keys for admin / managers / workers
- [ ] Extract OS disk from VM declaration
- [ ] Setup staic ip for swarm nodes
- [ ] Use a custom OS image preinstalled with docker (?)
- [ ] setup the Swarm cluster on top of the VM cluster
- [ ] Setup the VM using cloud-init (?)
- [ ] Add a keyvault to store ssh key, password, etc
- [ ] Build a portable (dockerized) work environment
- [ ] Setup a module / modules (with input var and ouput) to have a reusable swarm cluster build (maybe setup low level modules like VM+NIC, vnet+subnet+nsg+rules, etc ?)
- [ ] module hosting on github (?)
- [ ] Use a clear directory structure for modules
- [ ] Add a remote Terraform backend (state sharing) to work as a team
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
* list available VM images by region: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/cli-ps-findimage
* Linux general purpose VM sizes: https://docs.microsoft.com/en-us/azure/virtual-machines/linux/sizes-general

### Unix ###
* add ssh aliases: https://scotch.io/tutorials/how-to-create-an-ssh-shortcut

### blogs ###
* Gruntwork post series :
    1. Why Terraform: https://blog.gruntwork.io/why-we-use-terraform-and-not-chef-puppet-ansible-saltstack-or-cloudformation-7989dad2865c
    2. Introduction to Terraform: https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180
    3. Terraform state management: https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
    4. Terraform module creation: https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d






