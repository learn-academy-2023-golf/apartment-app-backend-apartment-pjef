require 'rails_helper'

RSpec.describe Apartment, type: :model do
  let(:user) {User.create(
    email: "test1@example.com",
    password: "password",
    password_confirmation: "password"
  )}

  # Street
    it "should validate street name is not blank" do
      apartment = user.apartments.create(
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
      )

      expect(apartment.errors[:street]).to include "can't be blank"
    end

    # Unit
    it "should validate unit is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:unit]).to include "can't be blank"
    end

    # City
    it "should validate city name is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:city]).to include "can't be blank"
    end

    # State
    it "should validate state name is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          city: "Sydney",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:state]).to include "can't be blank"
    end

    # Price
    it "should validate price is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:price]).to include "can't be blank"
    end

    # Square Footage
    it "should validate square footage is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:square_footage]).to include "can't be blank"
    end

    # Bedrooms
    it "should validate bed rooms is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:bedrooms]).to include "can't be blank"
    end

    # Bathrooms
    it "should validate bathrooms is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:bathrooms]).to include "can't be blank"
    end

    # Pets
    it "should validate pets is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      )

      expect(apartment.errors[:pets]).to include "can't be blank"
    end

    # Image
    it "should validate image is not blank" do
      apartment = user.apartments.create(
          street: "Street",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only"
      )

      expect(apartment.errors[:image]).to include "can't be blank"
    end
end
