require 'spec_helper'

describe command('curl http://localhost:8500/v1/health/state/critical') do
  its(:stdout) {should match /\[\]/}
end