require_relative "../ranking"

describe User do
	let(:user) {User.new}
	
	it "should have a default rank of -8" do 
		expect(user.rank).to eq(-8)
	end

	it "should have a default progress of 0" do
		expect(user.progress).to eq(0)
	end

	it "should be able to increase rank" do
		expect(user.rank).to eq(-8)
		user.add_rank(1)
		expect(user.rank).to eq(-7)
	end

	it "should be able to increase rank by more than 1 with .add_rank" do
		expect(user.rank).to eq(-8)
		user.add_rank(2)
		expect(user.rank).to eq(-6)
	end

	it "should not be able to get to rank 0" do
		user.add_rank(8)
		expect(user.rank).to eq(1)
	end

	it "should not be able to get past rank 8" do
		user.add_rank(17)
		expect(user.rank).to eq(8)
	end

	it "should be able to add progress" do
		expect(user.progress).to eq(0)
		user.add_progress(50)
		expect(user.progress).to eq(50)
	end

	it "should increase rank when progress reaches 100" do
		user.add_progress(100)
		expect(user.rank).to eq(-7)
	end

	it "should reset progress when it increases rank" do
		user.add_progress(150)
		expect(user.rank).to eq(-7)
		expect(user.progress).to eq(50)
	end

	it "should be able to increase by more than one rank with .add_progress" do
		user.add_progress(250)
		expect(user.rank).to eq(-6)
	end

	it "should not be able to attain progress once at rank 8" do
		user.add_rank(15)
		user.add_progress(350)
		expect(user.rank).to eq(8)
		expect(user.progress).to eq(0)
	end

	it "should gain 3 points from an acitivty ranked the same as the user" do
		user.inc_progress(-8)
		expect(user.progress).to eq(3)
	end

	it "should gain 1 point form an activity ranked one lower than the user" do
		user.add_rank(1)
		expect(user.progress).to eq(0)
		user.inc_progress(-8)
		expect(user.progress).to eq(1)
	end

	it "should gain no points from activities 2 or more ranks lower than the user" do
		user.add_rank(3)
		user.inc_progress(-8)
		expect(user.progress).to eq(0)
	end

	it "should gain 10 points from activities ranked 1 above the user" do
		user.inc_progress(-7)
		expect(user.progress).to eq(10)
	end

	it "should gain 40 points from activities ranked 2 above the user" do
		user.inc_progress(-6)
		expect(user.progress).to eq(40)
	end

	it "should ignore ranks not in the acceptable range" do
		expect{user.inc_progress(0)}.to raise_error(RuntimeError)
		expect{user.inc_progress(9)}.to raise_error(RuntimeError)
		expect{user.inc_progress(-9)}.to raise_error(RuntimeError)
	end

	it "should reach -2 when completing a 1 activity" do
		user.inc_progress(1)
		expect(user.rank).to eq(-2)
	end

	it "should add 1 progress when a 1 user completes a -1 activity" do
		user.add_rank(8)
		expect(user.rank).to eq(1)
		user.inc_progress(-1)
		expect(user.progress).to eq(1)
	end
end