require 'rails_helper'

RSpec.describe Search, type: :model do

  describe "initialize" do
    it "should set term property" do
     sem_search_initialize_sets_term_helper
    end
    it "should set client property" do
     sem_search_initialize_sets_client_helper
    end
  end

end

