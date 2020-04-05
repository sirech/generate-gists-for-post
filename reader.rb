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
    @blocks.map do |block|
      [
        block_name(block[:name], block[:language]),
        block[:content]
      ]
    end
  end

  private

  def extension(language)
    return nil if language.empty?

    d = {
      'kotlin' => 'kt',
      'javascript' => 'js',
      'typescript' => 'ts',
      'hcl' => 'hcl',
      'json' => 'json',
      'groovy' => 'groovy'
    }

    raise ArgumentError, "Unknown language #{language}" unless d.key?(language)

    d[language]
  end

  def read_blocks(lines)
    idx = 0

    while idx < lines.count
      if lines[idx] =~ /```/
        language, name = language_and_name lines[idx]
        raise ArgumentError, 'No name specified for block' unless name

        block, idx = capture_block(lines, idx)

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

  def capture_block(lines, idx)
    block = []

    idx += 1
    while lines[idx] !~ /```/
      block << lines[idx]
      idx += 1
    end

    [block, idx]
  end

  def language_and_name(line)
    line
      .sub(/```/, '')
      .split('#')
      .map(&:strip)
  end
end
