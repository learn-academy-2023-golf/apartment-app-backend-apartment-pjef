# Apartment Backend Notes

```ruby
require 'rails_helper'

RSpec.describe "Apartments", type: :request do

  let(:user) {User.create(
    email: "test@example.com",
    password: "password",
    password_confirmation: "password"
  )
}

  describe "GET /index" do
    it 'gets a list of apartments' do
      apartment = user.apartments.create(
        street: '4 Privet Drive',
        unit: '2A',
        city: 'Little Whinging',
        state: 'Surrey',
        square_footage: 2000,
        price: '2000',
        bedrooms: 3,
        bathrooms: 2,
        pets: 'yes',
        image: 'https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg'
      )
      get '/apartments'

      apartment = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(apartment.first['street']).to eq('4 Privet Drive')
      expect(apartment.first['unit']).to eq('2A')
      expect(apartment.first['city']).to eq('Little Whinging')
      expect(apartment.first['state']).to eq('Surrey')
      expect(apartment.first['square_footage']).to eq(2000)
      expect(apartment.first['price']).to eq('2000')
      expect(apartment.first['bedrooms']).to eq(3)
      expect(apartment.first['bathrooms']).to eq(2)
      expect(apartment.first['pets']).to eq('yes')
      expect(apartment.first['image']).to eq('https://c8.alamy.com/comp/B0RJGE/small-bungalow-home-with-pathway-in-addlestone-surrey-uk-B0RJGE.jpg')
    end
  end

  describe "POST /create" do
    it "create an apartment" do
      apartment_params = {
        apartment: {
          street: "Walaby Way",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          user_id: user.id
        }
      }

      post '/apartments', params: apartment_params

      apartment = Apartment.first
      expect(response).to have_http_status(200)
      expect(apartment.street).to eq "Walaby Way"
      expect(apartment.unit).to eq "42"
      expect(apartment.city).to eq "Sydney"
      expect(apartment.state).to eq "Australia"
      expect(apartment.square_footage).to eq 1500
      expect(apartment.price).to eq "3000"
      expect(apartment.bedrooms).to eq 3
      expect(apartment.bathrooms).to eq 2
      expect(apartment.pets).to eq "fish only"
      expect(apartment.image).to eq "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      expect(apartment.user_id).to eq user.id
    end
  end

  describe "PATCH /update" do
    it "update an apartment" do
      apartment_params = {
        apartment: {
          street: "Walaby Way",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          user_id: user.id
        }
      }

      post '/apartments', params: apartment_params

      apartment = Apartment.first

      updated_apartment_params = {
        apartment: {
          street: "Walaby Way",
          unit: "24",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          user_id: user.id
        }
      }

      patch "/apartments/#{apartment.id}", params: updated_apartment_params

      expect(response).to have_http_status(200)

      updated_apartment = Apartment.find(apartment.id)
      expect(updated_apartment.unit).to eq "24"
    end
  end

  describe "DELETE /destroy" do
    it "deletes an apartment" do
      apartment_params = {
        apartment: {
          street: "Walaby Way",
          unit: "42",
          city: "Sydney",
          state: "Australia",
          square_footage: 1500,
          price: "3000",
          bedrooms: 3,
          bathrooms: 2,
          pets: "fish only",
          image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          user_id: user.id
        }
      }

      post '/apartments', params: apartment_params

      apartment = Apartment.first

      delete "/apartments/#{apartment.id}"

      expect(response).to have_http_status(200)
      apartments = Apartment.all
      expect(apartments).to be_empty
    end
  end
end
```

```ruby
# controller methods
class ApartmentsController < ApplicationController
    def index
        apartments = Apartment.all
        render json: apartments
    end

    def create
        apartment = Apartment.create(apartment_params)

        if apartment.valid?
            render json: apartment
        else
            render json: apartment.errors, status: 422
        end
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        render json: apartment
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        render json: apartment
    end

    private
    def apartment_params
        params.require(:apartment).permit(:street, :unit, :city, :state,  :square_footage, :price, :bedrooms, :bathrooms, :pets, :image, :user_id)
    end
end

```


describe "PATCH /update" do
    let!(:apartment) {
      Apartment.create(
        street: "Walaby Way",
              unit: "24",
              city: "Sydney",
              state: "Australia",
              square_footage: 1500,
              price: "3000",
              bedrooms: 3,
              bathrooms: 2,
              pets: "fish only",
              image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              user_id: user.id
      )
    }
    context 'with valid parameters' do
      let(:valid_params) { { apartment: { street: 'Jeckell Way' } } }
      it 'changes a apartment' do
        patch "/apartments/#{apartment.id}", params: valid_params
        apartment.reload
        expect(response).to have_http_status(200)
        expect(apartment.street).to eq 'Jeckell Way'
      end
    end
    it "doesn't update without valid parameters" do
      apartment_params = {
        apartment: {
            street: "Walaby Way",
              unit: "24",
              city: "Sydney",
              state: "Australia",
              square_footage: 1500,
              price: "3000",
              bedrooms: 3,
              bathrooms: 2,
              pets: "fish only",
              image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              user_id: user.id
        }
      }
      post '/apartments', params: apartment_params
      apartment = Apartment.first
      updated_apartment_params = {
        apartment: {
            street: "Walaby Way",
              unit: "24",
              city: "Sydney",
              state: "Australia",
              square_footage: 1500,
              price: "3000",
              bedrooms: nil,
              bathrooms: 2,
              pets: "fish only",
              image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              user_id: user.id
      }
    }
      patch "/apartments/#{apartment.id}", params: updated_apartment_params
      expect(response.status).to eq 422
      updated_apartment = Apartment.find(apartment.id)
      expect(updated_apartment.bedrooms).to include "can't be blank"
      
    end
  end

end
