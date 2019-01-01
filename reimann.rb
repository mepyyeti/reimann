#!/usr/bin/env ruby

#reimann.rb

class Primes
	attr_reader :num
	attr_accessor :prime

	def num=(num)
		if num == 0
			raise "integers only"
		else
			puts num.to_i
		end
		@num = num
	end

	def initialize(num)
		@primes_lst = []
		@num_lst = []
		self.num = num
		self.prime = false
	end

	def divide_for_primes
		(2...num).each do |i|
			if num % i == 0
				@primes_lst << i
			end
		end
		@primes_lst
	end

	def remove_evens
		if num >= 2
			@primes_lst << 2
		end
		(2..num).each do |i|
			if i % 2 != 0 #if odd loop
				@primes_lst << i
			end
		end
		@primes_lst
	end

	def remove_odds
		@num_lst = @primes_lst.reverse
		@num_lst.each do |i|
			@primes_lst.each do |j|
				if i % j == 0 && i != j
					@primes_lst.delete(i)
				end
			end
		end
		puts "#{num} = #{@primes_lst.size} primes. --> #{@primes_lst}"
		@primes_lst
	end

	def is_prime
		@primes_lst.empty? ? self.prime = true : prime
		@primes_lst.empty? ? "prime." : "not prime.\nDividers are #{@primes_lst}."
	end

	def write
		file_new = File.open('primes.txt', 'a+')
		file_new.write("#{num}")
		unless prime
			file_new.puts(" is not prime")
			file_new.puts("#{@primes_lst}")
		else
			file_new.write(" is prime\n")
		file_new.close
		end
	end
end

go = true
while go
	time0 = Time.now
	print "enter num: ["
	foo = gets.chomp.to_i

	x = Primes.new(foo)
	puts "1 if you want to find the primes for the RANGE -> (0 .. #{foo})"
	puts "2 if you want to test if #{foo} is prime"
	choice = gets.chomp.to_i
	time1 = Time.now
	if choice == 1
		x.remove_evens
		x.remove_odds
	else
		x.divide_for_primes
		puts x.is_prime
	end
	time2 = Time.now
	puts "overall time: #{(time2 - time0) * 10000} ms"
	puts "calc time: #{(time2 - time1) * 10000} ms"
	puts 'save? [y/n]'
	choice = gets.chomp.downcase
	if choice == 'y' || choice == 'yes' || choice == 'o' || choice == 'oui'
		x.write
	end
	puts "try another number? [y/n]"
	choice = gets.chomp.downcase
	if choice == 'y' || choice == 'yes' || choice == 'o' || choice == 'oui'
		next
	else
		go = false
	end
end
