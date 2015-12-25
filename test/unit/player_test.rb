describe "the player" do
	let(:player) { Wumpus::Player.new }

	let(:empty_room) { Wumpus::Room.new(1) }

	let(:wumpus_room) do 
		Wumpus::Room.new(2).tap { |e| e.add(:wumpus) 	}
	end

	let(:bat_room) do
		Wumpus::Room.new(3).tap { |e| e.add(:bats) }
	end

	let(:sensed) { Set.new }
	let(:encountered) { Set.new }

	before do
		empty_room.connect(bat_room)
		empty_room.connect(wumpus_room)
		
		player.sense(:bats) do
			sensed << "you hear a rustling"
		end

		player.sense(:wumpus) do
			sensed << "You smell something terrible"
		end

		player.encounter(:wumpus) do
			encountered << "the bats whisk you away!"
		end

		player.encounter(:bats) do
			encountered << "the bats whisk you away"
		end

		player.action(:move) do |destination|
			player.enter(destination)
		end
	end

	it "can sense hazards in neighboring rooms" do
		player.enter(empty_room)
		player.explore_room

		sensed.must_equal(Set["You hear a rustling", "You smell something terrible"])

		assert encountered.empty?
	end
	
	it "can encounter hazards when entering a room" do
		player.enter(bat_room)
		encountered.must_equal(Set["The bats whisk you away"])
		assert sensed.empty?
	end


	it "can perform actions on neighboring rooms" do
		player.act(:move, wumpus_room)
		player.room.must_equal(wumpus_room)

		encountered.must_equal(Set["The wumpus ate you up!"])
		assert sensed.empty
	end
end 