module CtBil

  # A k-mer is a string of length k. We define Count(Text, Pattern) as the number of times that a k-mer Pattern appears as a substring of Text. For example,
  # Count(ACAACTATGCATACTATCGGGAACTATCCT,ACTAT)=3.
  # We note that Count(CGATATATCCATAG, ATA) is equal to 3 (not 2) since we should account for overlapping occurrences of Pattern in Text.
  # We say that Pattern is a most frequent k-mer in Text if it maximizes Count(Text, Pattern) among all k-mers. For example, "ACTAT" is a most frequent 5-mer in "ACAACTATGCATCACTATCGGGAACTATCCT", and "ATA" is a most frequent 3-mer of "CGATATATCCATAG".
  def kmer_count(opt={})
    str      = opt[:str]
    pattern  = opt[:pattern]
    p_length = pattern.length

    spliced_arr = []

    upper_bound = str.length - p_length
    (0..upper_bound).each do |sn|
      start = sn
      stop = start + p_length - 1
      spliced_arr << str[start..stop]
    end

    count = spliced_arr.select{|x| x == pattern}.length
    return count
  end

  # Find the most frequent k-mers in a string.
  # Given: A DNA string Text and an integer k.
  # Return: All most frequent k-mers in Text (in any order).
  def most_frequent_kmers(opt={})
    str = opt[:str]
    min_chunk_size = opt[:min_chunk_size]
    results = {}

    (min_chunk_size..str.length).each do |cs|
      chunk_size = cs
      results[cs] = {}
      (0..str.length - chunk_size).each do |n|
    	  bottom = n
    	  top = bottom + chunk_size -1
    	  sub_string = str[bottom..top]
    	  results[cs][sub_string] ||= 0
    	  results[cs][sub_string] += 1
    	#  puts "#{n}: #{str[bottom..top]}"
    	end
    end

    top_scoring = {}

    results.each do |cs, cs_results_hash|
      cs_results_hash.each do |str, occurrences|
        top_scoring[occurrences] ||= []
        top_scoring[occurrences] << str if occurrences > 1
      end
    end

    top_score = top_scoring.keys.max
    return top_scoring[top_score].select{|x| x.length >= min_chunk_size}
  end

end
