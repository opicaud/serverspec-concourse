require 'fileutils'

class CreateHostConfiguration

    include FileUtils


def create_host_directory(path,host)
    hostDir = path + host
    mkdir_p hostDir
end

def copy_spec_to_host_folder(pathOfTestFile,destPath,host)
    dest_folder = destPath + host
    cp(pathOfTestFile, dest_folder)
end

end