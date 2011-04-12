/*
 * A stemmer for the portuguese language written in ruby.
 *
 * It has been ported from the following perl implementation:
 * http://search.cpan.org/src/XERN/Lingua-PT-Stemmer-0.01/lib/Lingua/PT/Stemmer.pm
 * 
 * More information on this algortihm can be found at:
 * http://www.cs.mdx.ac.uk/research/PhDArea/rslp/RSLP.htm
 *
 * If you find any bugs, please contact me at dpr [at] cin.ufpe.br
 *
 * Hope you enjoy it!
 * Davi Pires
 *
 */

class StemmerPTBR

  def initialize()
    @rule = {}
    
    @rule["plural"] = {
        "ns"  => [ 1, "m" ],
        "ões" => [ 3, "ão" ],
        "ães" => [ 1, "ão" ],
        "ais" => [ 1, "al" ],
        "éis" => [ 2, "el" ],
        "eis" => [ 2, "el" ],
        "óis" => [ 2, "ol" ],
        "is"  => [ 2, "il" ],
        "les" => [ 2, "l" ],
        "res" => [ 3, "r" ],
        "s"   => [ 2, "" ],
    };
    
    @rule["femin"] = {
        "ona"   => [ 3, "ão" ],
        "ã"     => [ 2, "ão" ],
        "ora"   => [ 3, "or" ],
        "na"    => [ 4, "no" ],
        "inha"  => [ 3, "inho" ],
        "esa"   => [ 3, "ès" ],
        "osa"   => [ 3, "oso" ],
        "íaca"  => [ 3, "íaco" ],
        "ica"   => [ 3, "ico" ],
        "ada"   => [ 3, "ado" ],
        "ida"   => [ 3, "ido" ],
        "ída"   => [ 3, "ido" ],
        "ima"   => [ 3, "imo" ],
        "iva"   => [ 3, "ivo" ],
        "eira"  => [ 3, "eiro" ],
    };
    
    @rule["augment"] = {
        "díssimo"     => [ 5, '' ],
        "abilíssimo"  => [ 5,'' ],
        "íssimo"      => [ 3,'' ],
        "ésimo"       => [ 3,'' ],
        "érrimo"      => [ 4,'' ],
        "zinho"       => [ 2,'' ],
        "quinho"      => [ 4, "c" ],
        "uinho"       => [ 4,'' ],
        "adinho"      => [ 3,'' ],
        "inho"        => [ 3,'' ],
        "alhão"       => [ 4,'' ],
        "uça"         => [ 4,'' ],
        "aço"         => [ 4,'' ],
        "adão"        => [ 4,'' ],
        "ázio"        => [ 3,'' ],
        "arraz"       => [ 4,'' ],
        "arra"        => [ 3,'' ],
        "zão"         => [ 2,'' ],
        "ão"          => [ 3,'' ],
    };
    
    
    @rule["noun"] = {
        "encialista"  => [ 4, '' ],
        "alista"      => [ 5, '' ],
        "agem"        => [ 3, '' ],
        "iamento"     => [ 4, '' ],
        "amento"      => [ 3, '' ],
        "imento"      => [ 3, '' ],
        "alizado"     => [ 4, '' ],
        "atizado"     => [ 4, '' ],
        "izado"       => [ 5, '' ],
        "ativo"       => [ 4, '' ],
        "tivo"        => [ 4, '' ],
        "ivo"         => [ 4, '' ],
        "ado"         => [ 2, '' ],
        "ido"         => [ 3, '' ],
        "ador"        => [ 3,'' ],
        "edor"        => [ 3, '' ],
        "idor"        => [ 4, '' ],
        "atória"      => [ 5, '' ],
        "or"          => [ 2, '' ],
        "abilidade"   => [ 5,'' ],
        "icionista"   => [ 4, '' ],
        "cionista"    => [ 5, '' ],
        "ional"       => [ 4, '' ],
        "ència"       => [ 3, '' ],
        "ància"       => [ 4, '' ],
        "edouro"      => [ 3, '' ],
        "queiro"      => [ 3, 'c' ],
        "eiro"        => [ 3, '' ],
        "oso"         => [ 3, '' ],
        "alizaç"      => [ 5, '' ],
        "ismo"        => [ 3, '' ],
        "izaç"        => [ 5, '' ],
        "aç"          => [ 3, '' ],
        "iç"          => [ 3, '' ],
        "ário"        => [ 3, '' ],
        "ério"        => [ 6, '' ],
        "ès"          => [ 4, '' ],
        "eza"         => [ 3, '' ],
        "ez"          => [ 4, '' ],
        "esco"        => [ 4, '' ],
        "ante"        => [ 2, '' ],
        "ástico"      => [ 4, '' ],
        "ático"       => [ 3, '' ],
        "ico"         => [ 4, '' ],
        "ividade"     => [ 5, '' ],
        "idade"       => [ 5, '' ],
        "oria"        => [ 4, '' ],
        "encial"      => [ 5, '' ],
        "ista"        => [ 4, '' ],
        "quice"       => [ 4, 'c' ],
        "ice"         => [ 4, '' ],
        "íaco"        => [ 3, '' ],
        "ente"        => [ 4, '' ],
        "inal"        => [ 3, '' ],
        "ano"         => [ 4, '' ],
        "ável"        => [ 2, '' ],
        "ível"        => [ 5, '' ],
        "ura"         => [ 4, '' ],
        "ual"         => [ 3, '' ],
        "ial"         => [ 3, '' ],
        "al"          => [ 4, '' ],
    };
    
    
    @rule["verb"] = {
        "aríamo"    => [ 2, ''],
        "eria"      => [ 3, '' ],
        "ássemo"    => [ 2, '' ],
        "ermo"      => [ 3, '' ],
        "eríamo"    => [ 2, '' ],
        "esse"      => [ 3, '' ],
        "èssemo"    => [ 2, '' ],
        "este"      => [ 3, '' ],
        "iríamo"    => [ 3, '' ],
        "íamo"      => [ 3, '' ],
        "íssemo"    => [ 3, '' ],
        "iram"      => [ 3, '' ],
        "áramo"     => [ 2, '' ],
        "íram"      => [ 3, '' ],
        "árei"      => [ 2, '' ],
        "irde"      => [ 2, '' ],
        "aremo"     => [ 2, '' ],
        "irei"      => [ 3, '' ],
        "ariam"     => [ 2, '' ],
        "irem"      => [ 3, '' ],
        "aríei"     => [ 2, '' ],
        "iria"      => [ 3, '' ],
        "ássei"     => [ 2, '' ],
        "irmo"      => [ 3, '' ],
        "assem"     => [ 2, '' ],
        "isse"      => [ 3, '' ],
        "ávamo"     => [ 2, '' ],
        "iste"      => [ 4, '' ],
        "èramo"     => [ 3, '' ],
        "amo"       => [ 2, '' ],
        "eremo"     => [ 3, '' ],
        "ara"       => [ 2, '' ],
        "eriam"     => [ 3, '' ],
        "ará"       => [ 2, '' ],
        "eríei"     => [ 3, '' ],
        "are"       => [ 2, '' ],
        "èssei"     => [ 3, '' ],
        "ava"       => [ 2, '' ],
        "essem"     => [ 3, '' ],
        "emo"       => [ 2, '' ],
        "íramo"     => [ 3, '' ],
        "era"       => [ 3, '' ],
        "iremo"     => [ 3, '' ],
        "erá"       => [ 3, '' ],
        "iriam"     => [ 3, '' ],
        "ere"       => [ 3, '' ],
        "iríei"     => [ 3, '' ],
        "iam"       => [ 3, '' ],
        "íssei"     => [ 3, '' ],
        "íei"       => [ 3, '' ],
        "issem"     => [ 3, '' ],
        "imo"       => [ 3, '' ],
        "ando"      => [ 2, '' ],
        "ira"       => [ 3, '' ],
        "endo"      => [ 3, '' ],
        "irá"       => [ 3, '' ],
        "indo"      => [ 3, '' ],
        "ire"       => [ 3, '' ],
        "ondo"      => [ 3, '' ],
        "omo"       => [ 3, '' ],
        "aram"      => [ 2, '' ],
        "ai"        => [ 2, '' ],
        "arde"      => [ 2, '' ],
        "am"        => [ 2, '' ],
        "arei"      => [ 2, '' ],
        "ear"       => [ 4, '' ],
        "arem"      => [ 2, '' ],
        "ar"        => [ 2, '' ],
        "aria"      => [ 2, '' ],
        "uei"       => [ 3, '' ],
        "armo"      => [ 2, '' ],
        "ei"        => [ 3, '' ],
        "asse"      => [ 2, '' ],
        "em"        => [ 2, '' ],
        "aste"      => [ 2, '' ],
        "er"        => [ 2, '' ],
        "avam"      => [ 2, '' ],
        "eu"        => [ 3, '' ],
        "ávei"      => [ 2, '' ],
        "ia"        => [ 3, '' ],
        "eram"      => [ 3, '' ],
        "ir"        => [ 3, '' ],
        "erde"      => [ 3, '' ],
        "iu"        => [ 3, '' ],
        "erei"      => [ 3, '' ],
        "ou"        => [ 3, '' ],
        "èrei"      => [ 3, '' ],
        "i"         => [ 3, '' ],
        "erem"      => [ 3, '' ],
    };
    
    @rule["adverb"] = {
        "mente"     => [0, '']
    }
    
    @rule["vowel"] = {
        "[aeo]"     => [3, '']
    }
    
    @rule["accent"] = {
        "[äâàáã]"   => [0, 'a'],
        "[êéèë]"    => [0, 'e'],
        "[ïîìí]"    => [0, 'i'],
        "[üúùû]"    => [0, 'u'],
        "[ôöóòõ]"   => [0, 'o'],
        "[ç]"       => [0, 'c']
    };
  end  
  
  def stem(term)
    apply_rule("plural", term) if term =~ /s$/
    apply_rule("femin", term) if term =~ /a$/
    apply_rule("augment", term)
    apply_rule("adverb", term)
    apply_rule("noun", term)
    apply_rule("verb", term)
    apply_rule("vowel", term)  
    apply_rule("accent", term, false)  
    return term
  end
  
  private
  
  def apply_rule(rule_id, term, applyAtTheEnd=true)
    ruleToApply = @rule[rule_id]
    ruleToApply.each_pair do |suffix, operation| 
      re = Regexp.new(applyAtTheEnd ? suffix+"$" : suffix )
      temp_term = term.gsub(re,"")
      term.gsub!(re,operation[1]) if term =~ re && temp_term.length>operation[0] 
    end
    return term
  end

end
