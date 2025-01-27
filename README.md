# metal3-dev-tools

Set of internal tools for metal3 development

## Setup

```sh
make setup-local-repos
```

## Update the nordix main branches

```sh
make update-remote-repos
```

## Run the metal3 dev env

First, make sure that hardware virtualization is enabled, then you need to
source your Openstack credentials

```sh
source openstack.rc
```

Then run

```sh
make run-dev-env
```

If the IP address of the newly created virtual machine is not shown, then run the following

```
virsh net-dhcp-leases default
```

ssh into the machine with the metal3ci user

```
ssh metal3ci@VM_IP
```

When running ```make``` as described below, if you hit an issue about the default network, saying that it is already in use
by ens2, you need to modify the file ```/etc/libvirt/qemu/networks/default.xml```
to change the CIDR to not use the same CIDR as ens2 or any other interface.
Then run

```sh
sudo virsh net-define /etc/libvirt/qemu/networks/default.xml
sudo virsh net-start default
```

Then you can set up the environment :

```sh
git clone https://github.com/metal3-io/metal3-dev-env.git
export CONTAINER_RUNTIME=docker
cd metal3-dev-env
make
```

### Running the tests

All the following actions take place in the container. Otherwise
check you have installed everything properly (go 1.18, bazel, etc.)

If you want to run the metal3 tests, you first need to fetch the dependencies.

```sh
dep ensure
```

Then for all repositories :

```sh
make test
```

## metal3-dev-tools integration tests

This repository is mainly used for keeping scripts related to building node and
host images (OS). Once, new changes are pushed related to node images, there is
no way to test if those newly build images are going to work or not when running
integration tests in metal3-dev-env repository.
For that reason, and also to detect any possible issues early enough, we can run
metal3-dev-tools integration tests on a PR in this repository which:

1. Creates and pushes temporary node images to the artifactory from the changes
   on the PR;
1. Pulls and uses those images while running integration tests on PR;
1. Deletes those images from the artifactory at the the end of the integration tests.

To trigger metal3-dev-tools integration tests on a PR, please use the following
phrases:

* **/test-integration-metal3-dev-tools-ubuntu** runs metal3-dev-tools integration
  tests on Ubuntu
* **/test-integration-metal3-dev-tools-centos** runs metal3-dev-tools integration
  tests on CentOS

## Ways of working

* [Github Workflow](wow/github-workflow.md)

## Useful links

* [Github Nordix organization](https://github.com/Nordix)
* [Jenkins Nordix](https://jenkins.nordix.org)
* [Wiki Nordix](https://wiki.nordix.org/)
* [Jira Nordix](https://jira.nordix.org/secure/Dashboard.jspa)
* [Gerrit Nordix](https://gerrit.nordix.org)
* [Harbour nordix](https://registry.nordix.org)
* [Slack EST](estech-group.slack.com)
* [Our Wiki Nordix Pages](https://wiki.nordix.org/display/CPI/Cloud+and+Programmable+Infrastructure)
