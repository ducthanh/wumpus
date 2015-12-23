describe "A room" do
	let(:room) { Wumpus::Room.new(12) }
	it "has a number" do
		room.number.must_equal(12)
	end
	it "may contain hazards"

	describe "with neighbors" do
		it "has two-way connections of all neighboring rooms"
		it "knows the numbers of all neighboring rooms"
		it "can choose a neighbor randomly"
		it "is not safe if it has hazards"
		it "it not safe if its neighbors have hazards"
		it "it is safe when it and its neighbors have no hazards"
	end
end