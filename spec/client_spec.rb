require 'spec_helper'

require_relative '../client'

RSpec.describe Gists do
  let(:subject) { Gists.new }

  it 'initializes' do
    subject
  end

  it 'calls the right api when creating gists' do
    expected_files = {
      '1-filename.rb' => { content: 'stuff' },
      '2-filename2.rb' => { content: 'more stuff' }
    }

    expect_any_instance_of(Octokit::Client).to receive(:create_gist)
      .with(files: expected_files,
            description: 'desc',
            public: true)

    subject.create([
                     ['filename.rb', 'stuff'],
                     ['filename2.rb', 'more stuff']
                   ],
                   description: 'desc')
  end
end
