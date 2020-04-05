class Reader
  def initialize(filename)
    @filename = filename
    @blocks = []
  end

  def process
    lines = File.open(@filename).readlines
    read_blocks(lines)
    self
  end

  def code_blocks_count
    @blocks.count
  end

  private

  def read_blocks(lines)
    idx = 0

    while idx < lines.count
      if lines[idx] =~ /```(.*) #(.*)/
        language = $1.strip
        name = $2.strip
        block = []

        # idx += 1
        # while lines[idx] != '```'
        #   puts lines[idx]
        #   block << lines[idx]
        #   idx += 1
        # end

        @blocks << {
          name: name,
          language: language,
          content: block.join("\n")
        }
      end

      idx += 1
    end
  end
end
