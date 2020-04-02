require 'octokit'

class Gists
  attr_reader :client

  def initialize
    @client = Octokit::Client.new(access_token: ENV['GIST_GITHUB_API_TOKEN'])
  end

  def create(list, description: '', is_public: true)
    raise ArgumentError, 'duplicated filename' if duplicated_filenames?(list)

    files = formatted_files list
    @client.create_gist(
      files: files,
      description: description,
      public: is_public
    )
  end

  private

  def formatted_files(list)
    Hash[list.map do |filename, content|
      [filename, { content: content }]
    end]
  end

  def duplicated_filenames?(list)
    list.map(&:first).uniq.count != list.count
  end
end

puts Gists.new.create([['filename.rb', 'puts puts'], ['filename2.rb', 'kooot']], description: 'my gist')
