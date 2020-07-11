require 'rails_helper'
require 'ffaker'
require 'platform_a_api'
require 'platform_b_api'

describe VenuesController do
  before(:each) do
    @valid_attributes = {
      name: "Paulita Robel", address_line_1: "5066 Herzogstraat", address_line_2: "Apt. 111",
      website: "http://murazikemmerich.nu", phone_number: "913697070", lat: 0.388951e2, lng: -0.770364e2,
      category_id_a: 1100, category_id_b: 2100, closed: true,
      hours: "10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00",
      created_at: Date.today, updated_at: Date.today
    }
    @invalid_attributes = {
      "name"=>"Paulita Robel", "address_line_1"=>"5066 Herzogstraat", "address_line_2"=>"Apt. 111",
      "website"=>"http://murazikemmerich.nu", "phone_number"=>"913697070", "lat"=> '0.388951e2', "lng"=> -0.770364e2,
      "category_id_a"=>1100, "category_id_b"=>3100, "closed"=>true,
      "hours"=>"10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00",
      "created_at"=> Date.today, "updated_at"=> Date.today
    }
  end

  describe "GET #index" do
    it "returns a success response" do
      create(:venue)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      venue = create(:venue)
      get :show, params: {id: venue.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Venue" do
        expect {
          post :create, params: {venue: @valid_attributes}
        }.to change(Venue, :count).by(1)
      end

      it "renders a JSON response with the new venue" do
        post :create, params: {venue: @valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(venue_url(Venue.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new venue" do
        post :create, params: {venue: @invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "Pepito Perez", address_line_1: "159 London Avenue", address_line_2: "Apt. 222",
        website: "http://murazikemmerich.es", phone_number: "913697070", lat: 0.388951e2, lng: -0.770364e2,
        category_id_a: 1200, category_id_b: 2200, closed: true,
        hours: "10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,10:00-22:00,11:00-18:00,11:00-18:00",
        created_at: Date.today, updated_at: Date.today }
      }

      it "updates the requested venue" do
        venue = create(:venue)
        put :update, params: {id: venue.to_param, venue: new_attributes}
        venue.reload
        expect(venue.name).to eq('Pepito Perez')
      end

      it "renders a JSON response with the venue" do
        venue = create(:venue)
        put :update, params: {id: venue.to_param, venue: @valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the venue" do
        venue = create(:venue)
        put :update, params: {id: venue.to_param, venue: @invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested venue" do
      venue = create(:venue)
      expect {
        delete :destroy, params: {id: venue.to_param}
      }.to change(Venue, :count).by(-1)
    end
  end

  describe '#get_platform_a' do
    it 'gives us the JSON with platform_a data' do
      api = PlatformAApi.new
      response = api.platform_a_info
      expect(response["name"]).to eq("O'Reilly Group")
    end
  end

  describe '#get_platform_b' do
    it 'gives us the JSON with platform_b data' do
      api = PlatformBApi.new
      response = api.platform_b_info
      expect(response["category_id"]).to eq(2000)
    end
  end
end
