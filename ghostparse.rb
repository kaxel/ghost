module Ghostparse
  def self.slugify(input)
    return input.to_s.gsub(" ", "-")
  end
end