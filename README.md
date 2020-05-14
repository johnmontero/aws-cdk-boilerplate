aws-cdk-boilerplate
-------------------

Requirements
------------
* Docker
* Cmake
* Python >= 3.6

Help
----
* make
* make help

Commands
--------
```console
Target           Help                                                        Usage
------           ----                                                        -----
build.image       Build image for development                                make build.image
deploy            deploy this stack to your default AWS account/region       make deploy
destroy           destroy this stack to your default AWS account/region      make destroy
diff              compare deployed stack with current state                  make diff
docs              open CDK documentation                                     make docs
init              application init                                           make init
ls                list all stacks in the app                                 make ls
ssh               Connect to the container by ssh                            make ssh
synth             emits the synthesized CloudFormation template              make synth
```