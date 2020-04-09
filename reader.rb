LANGUAGES = {
  'kotlin' => 'kt',
  'javascript' => 'js',
  'typescript' => 'ts',
  'hcl' => 'hcl',
  'json' => 'json',
  'groovy' => 'groovy',
  'console' => 'sh'
}.freeze

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

    raise ArgumentError, "Unknown language #{language}" unless LANGUAGES.key?(language)

    LANGUAGES[language]
  end

  def read_blocks(lines)
    idx = 0

    while idx < lines.count
      if lines[idx] =~ /```/
        language, name = language_and_name(lines, idx)

        block, idx = capture_block(lines, idx)
        @blocks << { name: name, language: language, content: block.join }
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

  def language_and_name(lines, idx)
    language = language_from_line lines[idx]
    name = name_from_line lines[idx - 1]
    raise ArgumentError, 'No name specified for block' unless name

    [language, name]
  end

  def language_from_line(line)
    line
      .sub(/```/, '')
      .strip
  end

  def name_from_line(line)
    return unless line =~ /<!--(.*)-->/

    $1.strip
  end
end
