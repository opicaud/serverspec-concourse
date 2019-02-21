require_relative '../../assets/lib/serverspec_configuration.rb'
require 'json'

describe '::ServerSpecConfiguration' do

context "when Concourse run the out script, " do
   let(:hostConfiguration) do
    hostConfiguration=HostConfiguration.new
    allow(hostConfiguration).to receive(:create_host_directory)
    allow(hostConfiguration).to receive(:copy_spec_to_host_folder)
    hostConfiguration
   end

    let(:sshConfiguration) do
       sshConfiguration=double("SSHConfiguration")
       allow(sshConfiguration).to receive(:set_ssh_user)
       allow(sshConfiguration).to receive(:add_ssh_key)
       sshConfiguration
      end

   let(:jsonFile) do
    jsonFile = File.read('spec/lib/source.json')
    jsonFile
   end

   let(:serverspecConfiguration) do
    serverspecConfiguration=ServerspecConfiguration.new(jsonFile,hostConfiguration,sshConfiguration,"source_concourse")
    serverspecConfiguration
   end


   it "configure the host folder in order to run the specs" do
    serverspecConfiguration.run
    expect(hostConfiguration).to have_received(:create_host_directory).with(JSON.parse(jsonFile)["source"]["host"])
   end

   it "copy the spec to the host folder" do
       serverspecConfiguration.run
       path="source_concourse/" + JSON.parse(jsonFile)["params"]["tests"]
       expect(hostConfiguration).to have_received(:copy_spec_to_host_folder).with(path,JSON.parse(jsonFile)["source"]["host"])
   end

    it "set the ssh user from the json" do
          serverspecConfiguration.run
          expect(sshConfiguration).to have_received(:set_ssh_user).with(JSON.parse(jsonFile)["source"]["user"])
    end

     it "set the ssh key from the json" do
              serverspecConfiguration.run
              expect(sshConfiguration).to have_received(:add_ssh_key).with(JSON.parse(jsonFile)["source"]["ssh_key"])
      end

      it "can give the host" do
                   host=serverspecConfiguration.host
                   expect(host).to eq(JSON.parse(jsonFile)["source"]["host"])
           end
      it "can give the user" do
                        user=serverspecConfiguration.user
                        expect(user).to eq(JSON.parse(jsonFile)["source"]["user"])
                end


end
end