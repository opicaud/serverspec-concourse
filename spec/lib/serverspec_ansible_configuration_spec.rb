require_relative '../../assets/lib/serverspec_ansible_configuration.rb'
require 'json'

describe '::ServerspecAnsibleConfiguration' do

  context "when Concourse run the out script, " do

    let(:hostConfiguration) do
      hostConfiguration = HostConfiguration.new
      allow(hostConfiguration).to receive(:create_host_directory)
      allow(hostConfiguration).to receive(:copy_spec_to_host_folder)
      hostConfiguration
    end

    let(:sshConfiguration) do
      sshConfiguration = double("SSHConfiguration")
      allow(sshConfiguration).to receive(:set_ssh_user)
      allow(sshConfiguration).to receive(:add_ssh_key)
      sshConfiguration
    end

    let(:jsonFile) do
      jsonFile = File.read('spec/resources/source2.json')
      jsonFile
    end

    let(:serverspecConfiguration) do
      serverspecConfiguration = ServerspecAnsibleConfiguration.new(jsonFile, hostConfiguration, sshConfiguration, "source_concourse")
      serverspecConfiguration
    end


    it "configure the host folder in order to run the specs" do
      serverspecConfiguration.run
      expect(hostConfiguration).to have_received(:create_host_directory).with("ec2-35-180-46-86.eu-west-3.compute.amazonaws.com")
    end

    it "copy the spec to the host folder" do
      serverspecConfiguration.run
      path = "source_concourse/" + JSON.parse(jsonFile)["params"]["tests"]
      expect(hostConfiguration).to have_received(:copy_spec_to_host_folder).with(path, "ec2-35-180-46-86.eu-west-3.compute.amazonaws.com")
    end

    it "set the ssh user from the json" do
      serverspecConfiguration.run
      expect(sshConfiguration).to have_received(:set_ssh_user).with("admin")
    end

    it "set the ssh key from the json" do
      serverspecConfiguration.run
      expect(sshConfiguration).to have_received(:add_ssh_key).with(JSON.parse(jsonFile)["source"]["ssh_key"])
    end

    it "can give the host" do
      host = serverspecConfiguration.host
      expect(host).to eq("ec2-35-180-46-86.eu-west-3.compute.amazonaws.com")
    end
    it "can give the user" do
      user = serverspecConfiguration.user
      expect(user).to eq("admin")
    end


  end
end