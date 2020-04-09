require 'spec_helper'

require_relative '../client'

RSpec.describe Gists do
  let(:subject) { described_class.new }

  it 'initializes' do
    subject
  end

  it 'calls the right api when creating gists' do
    expected1 = { 'prefix-1-filename.rb' => { content: 'stuff' } }
    expect_any_instance_of(Octokit::Client).to receive(:create_gist)
      .with(files: expected1, description: 'desc', public: true)
      .and_return(instance_double('gists', git_pull_url: 'http://github.com '))

    expected2 = { 'prefix-2-filename2.rb' => { content: 'more stuff' } }
    expect_any_instance_of(Octokit::Client).to receive(:create_gist)
      .with(files: expected2, description: 'desc', public: true)
      .and_return(instance_double('gists', git_pull_url: 'http://github.com '))

    subject.create([['filename.rb', 'stuff'], ['filename2.rb', 'more stuff']],
                   prefix: 'prefix',
                   description: 'desc')
  end
end
