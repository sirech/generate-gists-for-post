require_relative './client'
require_relative './reader'

class Gists < Thor
  desc 'create FILE', 'Create gists for a post'
  method_option :prefix, :aliases => "-p", :desc => "Prefix for the gists"
  def create(file)
    r = Reader.new(path(file)).process
    puts "Code blocks found: #{r.code_blocks_count}"

    url = ::Gists.new.create(r.code_blocks, prefix: options[:prefix])
    puts "Created gists can be found under: #{url}"
  end

  private

  def path(article)
    File.expand_path("~/mine/homepage2/src/pages/articles/#{article}/index.md")
  end
end
