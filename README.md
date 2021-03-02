## BAaaS Modeller

This repo contains a `Dockerfile` and small `bash` script to build and publish a container
image for the updated Modeller used as part of the BAaaS Demo 2.0.

The code for the updated modeller is included as a Git sub-module in the `kogito-tooling` directory.
This is configured to track the `BAAAS-POC` branch of Roberto Emanuel's fork of Kogito Tooling.

## Building and Publishing the Container

### Pre-requisites

You will need to install the following:

* Docker/Buildah
* Node v12.16.3
* Yarn 1.19.1

You also need to initialize the Git SubModule by running `git submodule init` after you have cloned the repository.

Also ensure that you are able to authenticate with the quay.io repository: rblake/baaas-modeller. Ask Rob for access
if you cannot.

### Building

From the root of this directory, simply execute `build-modeller.sh`. This will take quite a long time
(particularly if this is the first time running).

This will build and push a container image to `quay.io/rblake/baaas-modeller` and the container will
be tagged with the latest Git SHA of the Git Submodule.

### Updating the Modeller Code

The Modeller is tracked as a Git Submodule. Git Submodules do not automatically update their refs, so
you have to pull the latest changes from the tracked `origin`. So to update to some latest changes, the workflow
would be:

```shell
cd kogito-tooling
git pull origin
cd ..
./build-modeller.sh
```

You would then also need to commit the update to the Git Submodule to this repository