user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

user1_apartments = [
  {
    street: "ABC Sesame Street",
    unit: "20",
    city: "Sesame",
    state: "CA",
    square_footage: 900,
    price: 5000,
    bedrooms: 1,
    bathrooms: 1,
    pets: "cats only ($500 fee)",
    image: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  }
]

user2_apartments = [
  {
    street: "Walaby Way",
    unit: "42",
    city: "Sydney",
    state: "Australia",
    square_footage: 1500,
    price: 3000,
    bedrooms: 3,
    bathrooms: 2,
    pets: "fish only",
    image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  }
]

user1_apartments.each do |apartment| 
  user1.apartments.create(apartment)
  p "created: #{apartment}"
end

user2_apartments.each do |apartment| 
  user2.apartments.create(apartment)
  p "created: #{apartment}"
end