def create_host_directory(path,host)
    hostDir = path + host
    FileUtils.mkdir_p hostDir
end

def copy_spec_to_host_folder(pathOfTestFile,destPath,host)
    dest_folder = destPath + host
    FileUtils.cp(pathOfTestFile, dest_folder)
end