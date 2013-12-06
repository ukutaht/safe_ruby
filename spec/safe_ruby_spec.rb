require 'spec_helper'

describe SafeRuby do
	describe '#eval' do
		it 'allows basic operations' do
			expect{ SafeRuby.eval("4 + 5") }.to_not raise_error
			expect{ SafeRuby.eval("[4, 5].map{|n| n+1}") }.to_not raise_error
		end

		it 'returns correct object' do
			SafeRuby.eval('[1,2,3]').should eq [1,2,3]
		end

		it 'does not allow malicious operations' do
			expect{ SafeRuby.eval("system('rm *')") }.to raise_error
			expect{ SafeRuby.eval("`rm *`") }.to raise_error
			expect{ SafeRuby.eval("Kernel.abort") }.to raise_error
		end

		it 'times out' do
			expect{ SafeRuby.eval('loop {}') }.to raise_error
		end
	end
end
