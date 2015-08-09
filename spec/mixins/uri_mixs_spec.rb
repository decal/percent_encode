# encoding: utf-8

require'uri'
require'percent_encode/mixins/uri'

describe URI do
  subject { URI } 

  it_should_behave_like 'PercentEncode::URI::Mixin'

  it 'should alias uriencode! to urlencode!' do
    auri = subject

    auri.should respond_to(:uriencode!)
  end

  it 'should alias uri_encode! to urlencode!' do
    auri = subject

    auri.should respond_to(:uri_encode!)
  end

  it 'should alias url_encode! to urlencode!' do
    auri = subject

    auri.should respond_to(:url_encode!)
  end
end
