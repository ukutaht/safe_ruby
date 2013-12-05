require 'spec_helper'

describe SafeRuby do
	describe '#eval' do
		it 'allows basic operations' do
			expect{ SafeRuby.eval("4 + 5") }.to_not raise_error
			expect{ SafeRuby.eval("[4, 5].map{|n| n+1}") }.to_not raise_error
		end

		it 'does not allow malicious operations' do
			expect{ SafeRuby.eval("system('ls')") }.to raise_error
			expect{ SafeRuby.eval("`ls`") }.to raise_error
			expect{ SafeRuby.eval("Kernel.abort") }.to raise_error
		end
	end
end