Gem.find_files("when/**/*.rb").each { |path| require path }

module When
  def self.start
  end
end
