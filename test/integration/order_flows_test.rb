# encoding: UTF-8

require 'test_helper'

class OrderFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    pepijn = users(:pepijn)
    pepijn.password = "testing"
    pepijn.save!

    visit new_user_session_path
    fill_in 'E-mail', with: pepijn.email
    fill_in 'Wachtwoord', with: pepijn.password
    within 'form' do
      click_on 'Inloggen'
    end
  end

  def use_coupon_code(coupon_code)
    within '.main-kortingscode' do
      fill_in 'Kortingscode', with: coupon_code
      click_on 'Gebruiken'
    end
  end

  def order_uva_course
    visit institutes_path

    click_link 'Universiteit van Amsterdam', match: :first
    click_link 'Faculteit Economie en Bedrijfskunde', match: :first
    click_link 'Eco en Bedrijfskunde', match: :first

    click_on 'Bestellen'
    click_on 'Afrekenen'
  end

  def order_vu_course
    visit institutes_path

    within '.dropdown-list' do
      click_link 'Vrije Universiteit'
      click_link 'Faculteit der Psychologie en Pedagogiek'
      click_link 'Pedagogische wetenschappen'
    end 

    click_on 'Bestellen'
    click_link 'Afrekenen'
  end

  #test "correct information" do
    #order_uva_course

    #assert has_content? 'Pepijn Looije'
    #assert has_content? 'pepijnlooije@gmail.com'
    #assert has_content? '0627379500'

    #assert has_content? 'Nieuwe Prinsengracht 110-2'
    #assert has_content? '1018 VX Amsterdam'
    #assert has_content? 'Nederland'

    #within 'table' do
      #assert has_content? 'SuperStoomcursus'
      #assert has_content? 'Wiskunde en Statistiek'
      #assert has_content? 'zat 05 januari - zat 05 januari'
    #end
  #end

  #test "place order without coupon" do
    #order_uva_course

    #assert has_content? 'Af te rekenen: €59,95'

    #click_on 'Afrekenen'
    ##assert has_content? OMNI_KASSA_REDIRECT_STRING
  #end

  #test "place order with coupon" do
    #order_uva_course

    #use_coupon_code 'TEST'

    #assert has_content? '€59,95'
    #assert has_content? '€7,40'
    #assert has_content? 'Af te rekenen: €52,55'

    #click_on 'Afrekenen'
    ##assert has_content? OMNI_KASSA_REDIRECT_STRING
  #end

  #test "place free order" do
    #order_uva_course

    #use_coupon_code 'GRATIS'

    #assert has_content? 'Af te rekenen: €0,00'
    #click_on 'Afronden'

    #assert has_content? 'Bestelling succesvol'
  #end

  #test "order cash course" do
    #order_vu_course

    #assert has_content? '€99,95'
    #assert has_content? 'Af te rekenen: €0,00'
    #click_on 'Afronden'

    #assert has_content? 'Bestelling succesvol'
  #end

  #test "order cash course with coupon" do
    #order_vu_course

    #use_coupon_code 'TEST'

    #assert has_content? '€99,95'
    #assert has_content? '€12,33'
    #assert has_content? '€87,62'
    #assert has_content? 'Af te rekenen: €0,00'
    #click_on 'Afronden'

    #assert has_content? 'Bestelling succesvol'
  #end

  #test "order omnikassa and cash course" do
    #order_vu_course
    #order_uva_course

    #assert has_content? '€59,95'
    #assert has_content? '€99,95'
    #assert has_content? '€159,90'
    #assert has_content? 'Af te rekenen: €59,95'

    #click_on 'Afrekenen'
    ##assert has_content? OMNI_KASSA_REDIRECT_STRING
  #end

  #test "order omnikassa and cash course with coupon" do
    #order_vu_course
    #order_uva_course

    #use_coupon_code 'TEST'

    #assert has_content? '€59,95'
    #assert has_content? '€99,95'

    #assert has_content? '€19,73'
    #assert has_content? '€140,17'
    #assert has_content? 'Af te rekenen: €52,55'

    #click_on 'Afrekenen'
    ##assert has_content? OMNI_KASSA_REDIRECT_STRING
  #end
end

