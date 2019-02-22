require_relative '../../assets/lib/serverspec_ansible_configuration.rb'
require 'json'

describe '::ServerspecAnsibleConfiguration' do

  context "when Concourse run the out script, " do

    let(:jsonFile) do
      jsonFile = File.read('spec/resources/source_with_ansible.json')
      jsonFile
    end

    let(:params) do
      params = JSON.parse(jsonFile)["params"]
      params
    end

    let(:serverspecConfiguration) do
      serverspecConfiguration = ServerspecAnsibleConfiguration.new(params, ".")
      serverspecConfiguration
    end

    it "can give the host from an ansible inventory" do
      host = serverspecConfiguration.host
      expect(host).to eq("ec2-35-180-46-86.eu-west-3.compute.amazonaws.com")
    end
    it "can give the user from ansible inventory" do
      user = serverspecConfiguration.user
      expect(user).to eq("admin")
    end


  end
end