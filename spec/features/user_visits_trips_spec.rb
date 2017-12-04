describe "When a user visits trips" do
  before(:each) do
    @trip = Trip.create(duration: 2,
                    start_date: "2017-01-01",
                    start_station: "South SF",
                    start_station_id: 1,
                    end_date: "2017-01-01",
                    end_station: "North SF",
                    end_station_id: 2,
                    bike_id: 21,
                    subscription_type: "Subscriber",
                    zipcode: 12345
                   )
    Station.create(name: "South SF", dock_count: 55, city: "San Juniperno", installation_date: "1992-11-21", latitude: 30.1023, longitude: -30.1235)
    Station.create(name: "North SF", dock_count: 55, city: "San Juniperno", installation_date: "1992-11-21", latitude: 40.1023, longitude: -30.1235)
  end

  it "sees banner" do
    visit '/trips'

    expect(page).to have_current_path('/trips')

    expect(page).to have_content("SF Bike Share")
    expect(page).to have_link("Station Dashboard")
    expect(page).to have_link("Station Index")
    expect(page).to have_link("Trips Index")
  end

  it "sees all trips" do
    visit '/trips'

    expect(page).to have_current_path('/trips')

    expect(page).to have_content("All Trips")
    expect(page).to have_content("Subscriber")
    expect(page).to have_link("Trip 1")
    expect(page).to have_link("New Trip")
  end

  it "clicks on a specific trip link" do
    visit '/trips'

    click_link("#{@trip.id}")

    expect(page).to have_current_path('/trips/1')
  end

  it "click on a new trip link" do
    visit '/trips'

    click_link("New Trip")

    expect(page).to have_current_path('/trips/new')
  end
end
