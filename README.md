# Serverspec [Concourse](http://concourse.ci) Resource

This is [Serverspec](https://serverspec.org/) resource for [Concourse](http://concourse.ci) to be able to execute Serverspec tests from concourse.

## Source Configuration

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