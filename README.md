# Serverspec [Concourse](http://concourse.ci) Resource

This is [Serverspec](https://serverspec.org/) resource for [Concourse](http://concourse.ci) to be able to execute Serverspec tests from concourse.


## Source Configuration v0.0.2

Run serverspec with a host and user found into an **ansible inventory** file

Parameters available to use in the resource definition. 
* `ssh_key`: A string containing the ssh private key used for ssh connections.

#### Parameters

* `tests`: File where you put your tests
* `inventory`: File where you have your ansible inventory


## Example Pipeline

```yml
---
resource_types:  
  
- name: serverspec  
  type: docker-image  
  source:  
    repository: opicaud/serverspec-concourse 
    
resources:  
- name: check-test-environment  
  type: serverspec  
  source:  
    ssh_key: ((ssh-key-of-the-user))
  
- name: source-code  
  type: git  
  source:  
    uri: ((git-repo))  
    private_key: ((git-private-key))  
  
  
jobs:  
- name: run-some-infra-tests  
  plan:  
  - get: source-code  
  - put: check-test-environment  
    params:  
      tests: source-code/test_spec.rb
      inventory: source-code/example_host
```



## Source Configuration v0.0.1

Run serverspec with host and user declared into the pipeline

Parameters available to use in the resource definition. 
* `ssh_key`: A string containing the ssh private key used for ssh connections.
* `user`: Remote user used to establish a ssh connection.
* `host` : the host to connect on in order to run the tests

#### Parameters

* `tests`: File where you put your tests

## Example Pipeline

```yml
---
resource_types:  
  
- name: serverspec  
  type: docker-image  
  source:  
    repository: opicaud/serverspec-concourse 
    tag: 0.0.1
    
resources:  
- name: check-test-environment  
  type: serverspec  
  source:  
    host: ((host-to-run-the-tests))
    user: ((ssh-user-to-connect-to-host))  
    ssh_key: ((ssh-key-of-the-user))
  
- name: source-code  
  type: git  
  source:  
    uri: ((git-repo))  
    private_key: ((git-private-key))  
  
  
jobs:  
- name: run-some-infra-tests  
  plan:  
  - get: source-code  
  - put: check-test-environment  
    params:  
      tests: source-code/test_spec.rb
```



# Author

Olivier Picaud <opicaud.mailbox@gmail.com>