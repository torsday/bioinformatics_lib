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
      expect(CtBil::most_frequent_kmers(str: "abc123xyz456abc123xyz456abc123xyz456", min_chunk_size: 4)).to eq(["abc1", "bc12", "c123", "123x", "23xy", "3xyz", "xyz4", "yz45", "z456", "abc12", "bc123", "c123x", "123xy", "23xyz", "3xyz4", "xyz45", "yz456", "abc123", "bc123x", "c123xy", "123xyz", "23xyz4", "3xyz45", "xyz456", "abc123x", "bc123xy", "c123xyz", "123xyz4", "23xyz45", "3xyz456", "abc123xy", "bc123xyz", "c123xyz4", "123xyz45", "23xyz456", "abc123xyz", "bc123xyz4", "c123xyz45", "123xyz456", "abc123xyz4", "bc123xyz45", "c123xyz456", "abc123xyz45", "bc123xyz456", "abc123xyz456"])
    end
  end
end
