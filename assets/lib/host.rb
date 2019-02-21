require 'fileutils'

class HostConfiguration

    include FileUtils

def initialize
    @serverspecPath = "/serverspec/spec/"
end

def create_host_directory(host)
    hostDir = @serverspecPath + host
    mkdir_p hostDir
end

def copy_spec_to_host_folder(pathOfTestFile,host)
    dest_folder = @serverspecPath + host
    cp(pathOfTestFile, dest_folder)
end

end