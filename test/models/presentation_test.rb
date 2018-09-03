require 'test_helper'

class PresentationTest < ActiveSupport::TestCase
  def setup
    @pres = Presentation.new(Name:"xyz",Klasse:"6 Gf",Titel:"zyx",Fach:"Bio",Betreuer:"CAB",Zimmer:"C12",Von:"12",Bis:"13",Datum:"07",Frei:5,Besetzt:0,Besucher:nil)
  end
end
