#!/usr/bin/env ruby

require 'json'

sSource = STDIN.read
source = JSON.parse(sSource)
host = source["source"]["host"]
user = source["source"]["user"]
ssh_key = source["source"]["ssh_key"]
tests = source["params"]["tests"]


STDERR.puts "Lancement des tests"

f = File.open(test, "r")
f.each_line do |line|
  puts line
end
f.close



ret = {
    "version": {"host": host, "user": user},

    "metadata": [
        {"name": "a-metadata", "value":"out"}
    ]
}

puts ret.to_json
