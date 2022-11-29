require 'test_helper'

class PaymentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  # TODO: update to Buckaroo
  test "successful return from omnikassa" do
    params = {"Data"=>"amount=9995|captureDay=0|captureMode=AUTHOR_CAPTURE|currencyCode=978|merchantId=002020000000001|orderId=3644|transactionDateTime=2013-01-10T18:19:40+01:00|transactionReference=omnikassatest1357838381|keyVersion=1|authorisationId=0020000006791167|paymentMeanBrand=IDEAL|paymentMeanType=CREDIT_TRANSFER|responseCode=00", "InterfaceVersion"=>"HP_1.0", "Encode"=>"", "Seal"=>"40099670ef169aa2b2a3fd22e3c4ffc225f591868cdb331d198871357658df59"}

    #post :create, params
    #assert_redirected_to orders_url
    #assert_not_nil assigns(:order)
  end
end

