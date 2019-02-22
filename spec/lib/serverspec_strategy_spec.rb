require_relative '../../assets/lib/../../assets/lib/serverspec_strategy.rb'

require 'json'

describe '::ServerSpecStrategy' do

  context "when Concourse run the out script, " do


    let(:jsonFile) do
      jsonFile = File.read('spec/resources/source.json')
      jsonFile
    end

    let(:jsonFile2) do
      jsonFile2 = File.read('spec/resources/source2.json')
      jsonFile2
    end

    it "use the strategy ServerSpecConfiguration by default" do
      strategy = ServerspecStrategy.new(jsonFile)
      expect(strategy.instance_variable_get(:@strategy)).to be_an_instance_of(ServerspecConfiguration)
    end

    it "use the ansible strategy if ansible is present in the jsonFile" do
      strategy = ServerspecStrategy.new(jsonFile2)
      expect(strategy.instance_variable_get(:@strategy)).to be_an_instance_of(ServerspecAnsibleConfiguration)
    end


  end
end