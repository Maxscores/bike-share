describe "When a visitor submits a new condition" do
  it "new condition is saved" do
    visit '/conditions/new'

    fill_in('condition[date]', with: "2013-11-20")
    fill_in('condition[max_temperature_f]',  with: 59)
    fill_in('condition[mean_temperature_f]', with: 55)
    fill_in('condition[min_temperature_f]',  with: 51)
    fill_in('condition[mean_humidity]',    with: 90)
    fill_in('condition[mean_visibility_miles]',with:  9)
    fill_in('condition[mean_wind_speed_mph]',  with:  7)
    fill_in('condition[precipitation_inches]', with: 0.63)

    find('input[name="New"]').click

    expect(page).to have_content("2013-11-20")
    expect(page).to have_content(59)
    expect(page).to have_content(55)
    expect(page).to have_content(51)
    expect(page).to have_content(90)
    expect(page).to have_content(9)
    expect(page).to have_content(7)
    expect(page).to have_content(0.63)
    expect(page).to have_content("Edit")
  end

  it "is redirected to that condition's page" do
    visit '/conditions/new'

    fill_in('condition[date]', with: "2013-11-20")
    fill_in('condition[max_temperature_f]',  with: 59)
    fill_in('condition[mean_temperature_f]', with: 55)
    fill_in('condition[min_temperature_f]',  with: 51)
    fill_in('condition[mean_humidity]',    with: 90)
    fill_in('condition[mean_visibility_miles]',with:  9)
    fill_in('condition[mean_wind_speed_mph]',  with:  7)
    fill_in('condition[precipitation_inches]', with: 0.63)

    find('input[name="New"]').click

    expect(page).to have_current_path("/conditions/84")
  end
end
