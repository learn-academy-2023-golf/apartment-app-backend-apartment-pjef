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

        it "cant create an apartment without a unit" do
        apartment_params = {
            apartment: {
                street: "Walaby Way",
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
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['unit']).to include "can't be blank"
        end

        it "cant create an apartment without a street" do
            apartment_params = {
                apartment: {
                    unit:"42",
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
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['street']).to include "can't be blank"
        end

        it "cant create an apartment without a city" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
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
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['city']).to include "can't be blank"
        end

        it "cant create an apartment without a state" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
                    city: "Sydney",
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
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['state']).to include "can't be blank"
        end
                
        it "cant create an apartment without a square footage" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
                    state: "Australia",
                    city: "sydney",
                    price: "3000",
                    bedrooms: 3,
                    bathrooms: 2,
                    pets: "fish only",
                    image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    user_id: user.id
                }
                }
            post '/apartments', params: apartment_params
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['square_footage']).to include "can't be blank"
        end

        it "cant create an apartment without a price" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
                    state: "Australia",
                    square_footage: 1500,
                    city: "Sydney",
                    bedrooms: 3,
                    bathrooms: 2,
                    pets: "fish only",
                    image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    user_id: user.id
                }
                }
            post '/apartments', params: apartment_params
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['price']).to include "can't be blank"
        end
                        
        it "cant create an apartment without bedrooms" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
                    state: "Australia",
                    square_footage: 1500,
                    price: "3000",
                    city: "sydney",
                    bathrooms: 2,
                    pets: "fish only",
                    image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    user_id: user.id
                }
                }
            post '/apartments', params: apartment_params
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['bedrooms']).to include "can't be blank"
        end

        it "cant create an apartment without bathrooms" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
                    state: "Australia",
                    square_footage: 1500,
                    price: "3000",
                    bedrooms: 3,
                    city: "sydney",
                    pets: "fish only",
                    image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    user_id: user.id
                }
                }
            post '/apartments', params: apartment_params
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['bathrooms']).to include "can't be blank"
        end

        it "cant create an apartment without a pets" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
                    state: "Australia",
                    square_footage: 1500,
                    price: "3000",
                    bedrooms: 3,
                    bathrooms: 2,
                    city: "sydney",
                    image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    user_id: user.id
                }
                }
            post '/apartments', params: apartment_params
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['pets']).to include "can't be blank"
        end

        it "cant create an apartment without an image" do
            apartment_params = {
                apartment: {
                    unit:"42",
                    street: "walaby way",
                    state: "Australia",
                    square_footage: 1500,
                    price: "3000",
                    bedrooms: 3,
                    bathrooms: 2,
                    pets: "fish only",
                    city: "sydney",
                    user_id: user.id
                }
                }
            post '/apartments', params: apartment_params
            apartment = JSON.parse(response.body)
            expect(response).to have_http_status(422)
            expect(apartment['image']).to include "can't be blank"
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
end
