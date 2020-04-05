require 'spec_helper'

require_relative '../reader'

RSpec.describe do
  let(:subject) { Reader.new('fixtures/example.md').process }

  describe '.code_blocks_count' do
    it { expect(subject.code_blocks_count).to eq(8) }
  end
end
