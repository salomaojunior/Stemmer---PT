require 'lib/stemmer-pt-br'
stemmer = StemmerPTBR.new

stemmer.stem('helpers')   # helper
stemmer.stem('dying')     # die
stemmer.stem('scarred')   # scar