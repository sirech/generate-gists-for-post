require 'octokit'

class Gists
  attr_reader :client

  def initialize
    @client = Octokit::Client.new(access_token: ENV['GIST_GITHUB_API_TOKEN'])
  end

  def create(list, prefix:, description: '', is_public: true)
    raise ArgumentError, 'duplicated filename' if duplicated_filenames?(list)
    raise ArgumentError, 'prefix cannot be empty' if prefix.empty?

    files = formatted_files list, prefix
    files.map do |file|
      @client.create_gist(
        files: file,
        description: description,
        public: is_public
      ).git_pull_url
    end
  end

  private

  def formatted_files(list, prefix)
    list.map.with_index do |elem, index|
      filename, content = elem
      { "#{prefix}-#{index + 1}-#{filename}" => { content: content } }
    end
  end

  def duplicated_filenames?(list)
    list.map(&:first).uniq.count != list.count
  end
end
