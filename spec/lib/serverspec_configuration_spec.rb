require_relative '../../assets/lib/serverspec_configuration.rb'
require 'json'

describe '::ServerSpecConfiguration' do

  context "when Concourse run the out script, " do

    let(:jsonFile) do
      jsonFile = File.read('spec/resources/source.json')
      jsonFile
    end

    let(:source_items) do
      source_items=JSON.parse(jsonFile)["source"]
      source_items
    end

    let(:serverspecConfiguration) do
      serverspecConfiguration = ServerspecConfiguration.new(source_items)
      serverspecConfiguration
    end



    it "can give the host from a json source" do
      host = serverspecConfiguration.host
      expect(host).to eq(source_items["host"])
    end
    it "can give the user from a json source" do
      user = serverspecConfiguration.user
      expect(user).to eq(source_items["user"])
    end


  end
end