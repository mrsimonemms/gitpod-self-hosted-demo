#  Gitpod Self-Hosted Demo

A demo installation of Gitpod for conferences

## Quickstart

This should be run on a machine with Ubuntu 22.04 LTS installed. Our demo machine has 64GB RAM and a 2TB SSD as we
expect to be able to cater for multiple running instances. It is recommended to have
[passwordless sudo](https://timonweb.com/devops/how-to-enable-passwordless-sudo-for-a-specific-user-in-linux) enabled
on your machine as this will simplify adding nodes.

To deploy Gitpod to your machine:
1. Clone this repository to your machine
2. Download your Gitpod licence
3. Run `LICENCE_PATH=/path/to/gitpod-licence.yaml GITPOD_URL=your.gitpod.domain.com make`

After a few minutes, your cluster will available for you.
