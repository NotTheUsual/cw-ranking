class User
	attr_reader :rank, :progress
	def initialize
		@rank = -8
		@progress = 0
	end

	def add_rank(amount)
		@rank += amount
		@rank += 1 if @rank == 0
		@rank = 8 if @rank > 8
	end

	def add_progress(amount)
		@progress += amount
		add_rank(@progress / 100)
		@progress %= 100
		@progress = 0 if self.rank == 8
	end

	def inc_progress(rank)
		raise "Not an acceptable rank" if is_unacceptable?(rank)
		difference = rank - self.rank
		if sign_differs_from_users?(rank)
			difference > 0 ? difference -= 1 : difference += 1
		end
		add_progress(3) if difference == 0
		add_progress(1) if difference == -1
		add_progress(10 * difference**2) if rank > self.rank
	end

	def is_unacceptable?(rank)
		rank == 0 || rank > 8 || rank < -8
	end

	def sign_differs_from_users?(rank)
		((rank < 0 && self.rank > 0) || (rank > 0 && self.rank < 0))
	end
end