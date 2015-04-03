require_relative 'ct_bil'
require 'rspec'

include CtBil

describe CtBil do
  describe "count" do
    it "should work" do
      expect(CtBil::kmer_count(str: "ACAACTATGCATACTATCGGGAACTATCCT", pattern: "ACTAT")).to eq(3)
      expect(CtBil::kmer_count(str: "CGATATATCCATAG", pattern: "ATA")).to eq(3)
    end
  end

  describe "most_frequent_kmers" do
    it "should work" do
      expect(CtBil::most_frequent_kmers(str: "abc123xyz456abc123xyz456abc123xyz456", min_chunk_size: 4, max_chunk_size: 6)).to eq({3=>["abc1", "bc12", "c123", "123x", "23xy", "3xyz", "xyz4", "yz45", "z456", "abc12", "bc123", "c123x", "123xy", "23xyz", "3xyz4", "xyz45", "yz456", "abc123", "bc123x", "c123xy", "123xyz", "23xyz4", "3xyz45", "xyz456"]})
    end
  end

  describe "dna_reverse_compliment" do
    it "should work" do
      expect(dna_reverse_compliment("AAAACCCGGT")).to eq("ACCGGGTTTT")
    end
  end

  describe "find_indexes_of_ptrn" do
    it "should work" do
      expect(find_indexes_of_ptrn(:genome => "GATATATGCATATACTT", :pattern => "ATAT")).to eq([1, 3, 9])
    end
  end

  describe "lt_clump" do
    it "should work" do
      gen = "CGGACTCGACAGATGTGAAGAAATGTGAAGACTGAGTGAAGAGAAGAGGAAACACGACACGACATTGCGACATAATGTACGAATGTAATGTGCCTATGGC"
      k = 5
      l = 75
      t = 4
      expect(lt_clump(:genome => gen, :k_ptrn_length => k, :L_interval => l, :times => t)).to eq("CGACA GAAGA AATGT")
    end
  end
end
