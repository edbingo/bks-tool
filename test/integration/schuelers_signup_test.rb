require 'test_helper'

class SchuelersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'Schueler.count' do
      post schuelers_path, params: { schueler: { name:  "",
                                             vorname:  "",
                                             mail: "user@invalid",
                                             klasse: "",
                                             number: "" } }
    end
    assert_template 'schuelers/new'
  end
end
