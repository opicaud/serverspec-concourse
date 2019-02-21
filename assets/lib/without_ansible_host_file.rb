require_relative 'host.rb'
require_relative 'ssh.rb'
require 'json'


class WithoutAnsibleHostFile

def initialize(jsonFile, hostConfiguration,sshConfiguration, source_concourse)
    @jsonFile = jsonFile
    @hostConfiguration = hostConfiguration
    @sshConfiguration = sshConfiguration
    @source_concourse = source_concourse
end

def run()
    jsonFile = JSON.parse(@jsonFile)
    source_items  = jsonFile["source"]
    params_items = jsonFile["params"]

    runHostConfiguration(params_items["tests"], source_items["host"])
    runSshConfiguration(source_items["user"], source_items["ssh_key"])

end


def runHostConfiguration(tests,host)
    @hostConfiguration.create_host_directory(host)
    @hostConfiguration.copy_spec_to_host_folder(File.join(@source_concourse,tests),host)
end

def runSshConfiguration(user, ssh_key)
    @sshConfiguration.set_ssh_user(user)
    @sshConfiguration.add_ssh_key(ssh_key)

end

end