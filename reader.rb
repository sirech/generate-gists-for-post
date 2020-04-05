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

  def code_blocks
    @blocks.map { |block|
      [
        block_name(block[:name], block[:language]),
        block[:content]
      ]
    }
  end

  private

  def extension(language)
    d = {
      'kotlin' => 'kt',
      'javascript' => 'js',
      'typescript' => 'ts',
      'hcl' => 'hcl'
    }
    d[language]
  end

  def read_blocks(lines)
    idx = 0

    while idx < lines.count
      if lines[idx] =~ /```/
        language, name = lines[idx]
                         .sub(/```/, '')
                         .split('#')
                         .map(&:strip)
        raise ArgumentError, 'No name specified for block' unless name

        block = []

        idx += 1
        while lines[idx] !~ /```/
          block << lines[idx]
          idx += 1
        end

        @blocks << {
          name: name,
          language: language,
          content: block.join
        }
      end

      idx += 1
    end
  end

  def block_name(name, language)
    ext = extension language
    if ext
      "#{name}.#{ext}"
    else
      name
    end
  end
end
