require 'lib/stemmer-pt-br'
stemmer = StemmerPTBR.new

w = ["bons", "chilena", "pezinho", "existencialista", "beberiam", "bebe", "existencialistas"]
wc = ["bom", "chilen", "pezinh", "existenc", "beb", "bebe", "existenc"]
w.each_index {|x| p "W=#{w[x]}, WC=#{wc[x]} => W.sterm = #{stemmer.stem(w[x])} - " + ((stemmer.stem(w[x]) == wc[x]) ? "Ok" : "Falhou"); }