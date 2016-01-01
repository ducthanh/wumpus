require "minitest/autorun"

require "strscan"
require_relative "../lib/wumpus"

class Minitest::Unit::TestCase
	def must_eventually(message, n = 1000)
		n.times{ yield and return pass }
		flunk("Expected to #{message}, but didn't")
	end

	def with_stdin
		stdin = $stdin
		$stdin, write = IO.pipe
		capture_io { yield(write) }
	end
