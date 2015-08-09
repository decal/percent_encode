#!/usr/bin/env ruby

root_dir = File.expand_path(File.join(File.dirname(__FILE__),'..'))
lib_dir = File.join(root_dir,'lib')
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require'benchmark'
require'percent_encode'

Benchmark.bm do |b|
  (1 .. 20).each do |n|
    aurl = 'https://www.google.com:80/robots.txt'
    anar = (1 .. n).to_a

    b.report("n=#{n}") do
      anar.each do |k|
        aurl.urlencode!({:nibble => nil, :count => 1})
      end
    end
  end
end
