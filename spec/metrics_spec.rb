require 'spec_helper'

create_tables_for(:user)

class Pet < ActiveRecord::Base

end

class User < ActiveRecord::Base
  include Metrics
  has_many :pets, dependent: :destroy

  has_metric :name_length do
    name.length
  end

  has_metric :pets_count do
    pets.count
  end

  has_metric :average_pet_weight do
    pets.average(:weight)
  end
end
UserMetrics.migrate!
User.update_all_metrics!


describe Metrics do
  describe "defining metrics" do
    let(:user) { User.create(:name => "Fuzz") }
    before { User.destroy_all }
    after { User.destroy_all }

    it "creates rows for the metrics" do
      UserMetrics.columns.count.should == 7
      User.has_metric :name_length_squared do
        name_length * name_length
      end
      User.update_all_metrics!
      UserMetrics.columns.count.should == 9
      user.name_length_squared.should == 16
    end

    it "calculates their block when called" do
      user.name.should == "Fuzz"
      user.name_length.should == 4

      user.name = "Bib"

      # since 20 hours hasn't passed, the value is pulled from cache, not recalculated
      user.name_length.should == 4
      # (true) forces it to recalculate right away
      user.name_length(true).should == 3

      # since it wasn't saved, it's the same in the DB
      User.find_by_name("Fuzz").name_length.should == 4

      user.save
      user.name_length(true).should == 3
      User.find_by_name("Bib").name_length.should == 3
    end

    it "has their values precomputed" do
      user
      User.update_all_metrics!
      UserMetrics.count(:group => :name_length).should == {4=>1}
    end

    describe 'aggregate functions' do
      before { User.create!(name: 'Goose').pets.create! weight: 265 }

      it 'calls aggregate function alone' do
        user.pets.create!(age: 1, weight: 2)
        UserMetrics.any_instance.should_not_receive(:average_pet_weight=)
        User.update_all_metrics!
        expect(user.metrics.updated__average_pet_weight__at.to_i).to eql Time.current.to_i
        expect(user.average_pet_weight).to eql 2
      end

      it 'arrives at the same value as the single instance calculation' do
        user.pets.create!(age: 1, weight: 2)
        user.pets.create!(age: 3, weight: 8)
        User.update_all_metrics!
        agg_result = user.average_pet_weight
        single_result = user.average_pet_weight(true)
        expect(agg_result.to_d).to eql single_result.to_d
      end
    end
  end
end
