require 'set'

module CtBil

  # ---
  # Frequent Words Problem

  # A k-mer is a string of length k. We define Count(Text, Pattern) as the number of times that a k-mer Pattern appears as a substring of Text. For example,
  # Count(ACAACTATGCATACTATCGGGAACTATCCT,ACTAT)=3.
  # We note that Count(CGATATATCCATAG, ATA) is equal to 3 (not 2) since we should account for overlapping occurrences of Pattern in Text.
  # We say that Pattern is a most frequent k-mer in Text if it maximizes Count(Text, Pattern) among all k-mers. For example, "ACTAT" is a most frequent 5-mer in "ACAACTATGCATCACTATCGGGAACTATCCT", and "ATA" is a most frequent 3-mer of "CGATATATCCATAG".
  def kmer_count(opt={})
    str         = opt[:str]
    pattern     = opt[:pattern]
    p_length    = pattern.length
    spliced_arr = []
    upper_bound = str.length - p_length

    (0..upper_bound).each do |sn|
      start = sn
      stop  = start + p_length - 1
      spliced_arr << str[start..stop]
    end

    count = spliced_arr.select{|x| x == pattern}.length
    return count
  end

  # Find the most frequent k-mers in a string.
  # Given: A DNA string Text and an integer k.
  # Return: All most frequent k-mers in Text (in any order).
  def most_frequent_kmers(opt={})
    str            = opt[:str]
    min_chunk_size = opt[:min_chunk_size] || 1
    max_chunk_size = opt[:max_chunk_size] || str.length - 1
    min_occurences = opt[:min_occurences] || 1
    results        = {}
    top_scoring    = {}

    (min_chunk_size..max_chunk_size).each do |cs|
      chunk_size  = cs
      results[cs] = {}
      (0..str.length - chunk_size).each do |n|
        bottom     = n
        top        = bottom + chunk_size -1
        sub_string = str[bottom..top]
        results[cs][sub_string] ||= 0
        results[cs][sub_string]  += 1
      end
    end

    results.each do |cs, cs_results_hash|
      cs_results_hash.each do |str, occurrences|
        top_scoring[occurrences] ||= []
        top_scoring[occurrences]  << str if occurrences >= min_occurences
      end
    end

    top_score = top_scoring.keys.max

    return { top_score => top_scoring[top_score].select{|x| x.length >= min_chunk_size } }
  end

  # ---
  # Reverse Complement Problem

  # In DNA strings, symbols 'A' and 'T' are complements of each other, as are 'C' and 'G'. Given a nucleotide p, we denote its complementary nucleotide as p. The reverse complement of a DNA string Pattern = p1…pn is the string Pattern = pn … p1 formed by taking the complement of each nucleotide in Pattern, then reversing the resulting string.
  # For example, the reverse complement of Pattern = "GTCA" is Pattern = "TGAC".
  def dna_reverse_compliment(str)
    result  = ""
    rev_str = str.reverse.downcase
    legend  = {
      "a" => "t",
      "t" => "a",
      "g" => "c",
      "c" => "g"
    }

    rev_str
      .split("")
      .map{|x| legend[x]} # translate
      .join('')
      .upcase
  end

  # ---
  # Pattern Matching Problem

  def find_indexes_of_ptrn(opt={})
    s = opt[:genome]
    ptrn = opt[:pattern]
    p_length = ptrn.length
    (0 ... s.length).select { |i| s[i,p_length] == ptrn }
  end

  # ---
  # Clump Finding Problem

  # Given integers L and t, a string Pattern forms an (L, t)-clump inside a (larger) string Genome if there is an interval of Genome of length L in which Pattern appears at least t times. For example, TGCA forms a (25,3)-clump in the following Genome: gatcagcataagggtcccTGCAaTGCAtgacaagccTGCAgttgttttac.
  # Find patterns forming clumps in a string.
  # Given: A string Genome, and integers k, L, and t.
  # Return: All distinct k-mers forming (L, t)-clumps in Genome.
  def lt_clump(opt={})
    end_matches     = Set.new
    genome          = opt[:genome]
    interval_length = opt[:L_interval]
    occurrences     = opt[:times]
    pattern_length  = opt[:k_ptrn_length]

    (0..(genome.length - interval_length - 1)).each do |n|
      start   = n
      stop    = start + interval_length
      gen_str = genome[start..stop]
      most_frequent_kmers(
        :str            => gen_str,
        :min_chunk_size => pattern_length,
        :max_chunk_size => pattern_length,
        :min_occurences => occurrences
      ).each do |matches,pattern|
        end_matches += pattern
      end
    end
    end_matches.inject{|sum,x| sum + " #{x}"}
  end

end
