require 'spec_helper'

require_relative '../reader'

RSpec.describe Reader do
  let(:subject) { reader('example.md') }

  describe '.code_blocks_count' do
    it { expect(subject.code_blocks_count).to eq(8) }
  end

  describe '.code_blocks' do
    it 'returns a list of code blocks with the filenames in the first position' do
      filenames = (1..8).map { |i| "example#{i}.kt" }

      expect(subject.code_blocks.map(&:first)).to eq(filenames)
    end

    it 'works for snippets without extensions' do
      r = reader('no-extension.md')

      expect(r.code_blocks.map(&:first)).to eq(['example1'])
    end

    it 'raises an error if a block does not have a title' do
      expect { reader('no-name.md').code_blocks }.to raise_error(ArgumentError)
    end

    it 'raises an error if a block has an unknown language' do
      expect { reader('unknown-language.md').code_blocks }.to raise_error(ArgumentError)
    end

    it 'returns a list of code blocks with the actual code in the second position' do
      expected_code = %(@ExceptionHandler(JWTVerificationException::class)
fun handleException(exception: JWTVerificationException): ResponseEntity<ErrorMessage> {
    return ResponseEntity
      .status(HttpStatus.BAD_GATEWAY)
      .body(ErrorMessage.fromException(exception))
}
)
      _, code = subject.code_blocks[0]
      expect(code).to eq(expected_code)
    end
  end

  private

  def reader(filename)
    Reader.new("fixtures/#{filename}").process
  end
end
