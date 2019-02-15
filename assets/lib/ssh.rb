def add_ssh_key(ssh_key)
    FileUtils.mkdir_p "/root/.ssh"
    ssh_key_file = File.join("/root/.ssh", "id_rsa")
    File.open(ssh_key_file, 'w') { |file| file.write(ssh_key) }
end

def set_ssh_user(path, user)
    spec_helper_file = File.read(path)
    spec_helper_file_with_ssh_user_set = spec_helper_file.gsub(/{{ user }}/, user)
    File.open(path, "w") {|file| file.puts spec_helper_file_with_ssh_user_set }
end