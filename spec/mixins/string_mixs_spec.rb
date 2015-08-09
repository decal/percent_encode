# encoding: utf-8

require'percent_encode/mixins/string'

describe String do
  subject { String } 

  it_should_behave_like 'PercentEncode::String::Mixin'

  it 'should alias url_encode! to urlencode!' do
    astr = subject

    astr.should respond_to(:url_encode!)
  end

  it 'should alias uri_encode! to urlencode!' do
    astr = subject

    astr.should respond_to(:uri_encode!)
  end

  it 'should alias uriencode! to urlencode!' do
    astr = subject

    astr.should respond_to(:uriencode!)
  end

  it 'should alias uriencode1! to urlencode1!' do
    astr = subject

    astr.should respond_to(:uriencode1!)
  end

  it 'should alias uriencode2! to urlencode2!' do
    astr = subject

    astr.should respond_to(:uriencode2!)
  end

  it 'should alias uriencode3! to urlencode3!' do
    astr = subject

    astr.should respond_to(:uriencode3!)
  end

  it 'should alias uriencode1 to urlencode' do
    astr = subject

    astr.should respond_to(:uriencode1)
  end

  it 'should alias uriencode2 to urlencode2' do
    astr = subject

    astr.should respond_to(:uriencode2)
  end

  it 'should alias uriencode3 to urlencode3' do
    astr = subject

    astr.should respond_to(:uriencode3)
  end

  it 'should alias uri_encode1 to urlencode1' do
    astr = subject

    astr.should respond_to(:uri_encode1)
  end

  it 'should alias uri_encode2 to urlencode2' do
    astr = subject

    astr.should respond_to(:uri_encode2)
  end

  it 'should alias uri_encode3 to urlencode3' do
    astr = subject

    astr.should respond_to(:uri_encode3)
  end

  it 'should alias uri_encode1! to urlencode1!' do
    astr = subject

    astr.should respond_to(:uri_encode1!)
  end

  it 'should alias uri_encode2! to urlencode2!' do
    astr = subject

    astr.should respond_to(:uri_encode2!)
  end

  it 'should alias uri_encode3! to urlencode3!' do
    astr = subject

    astr.should respond_to(:uri_encode3!)
  end

  it 'should alias url_encode1 to urlencode1' do
    astr = subject

    astr.should respond_to(:url_encode1)
  end

  it 'should alias url_encode2 to urlencode2' do
    astr = subject

    astr.should respond_to(:url_encode2)
  end

  it 'should alias url_encode3 to urlencode3' do
    astr = subject

    astr.should respond_to(:url_encode3)
  end

  it 'should alias url_encode1! to urlencode1!' do
    astr = subject

    astr.should respond_to(:url_encode1!)
  end

  it 'should alias url_encode2! to urlencode2!' do
    astr = subject

    astr.should respond_to(:url_encode2!)
  end

  it 'should alias url_encode3! to urlencode3!' do
    astr = subject

    astr.should respond_to(:url_encode3!)
  end

  it 'should respond to char_encode' do
    astr = subject

    astr.should respond_to(:char_encode)
  end

  it 'should respond to percent_encode' do
    astr = subject

    astr.should respond_to(:percent_encode)
  end

  it 'should respond to percent_encode!' do
    astr = subject

    astr.should respond_to(:percent_encode!)
  end

  it 'percent_encode1 should alias to percent_encode' do
    astr = subject

    astr.should respond_to(:percent_encode1)
  end

  it 'percent_encode1! should alias to percent_encode!' do
    astr = subject

    astr.should respond_to(:percent_encode1!)
  end

  it 'percent_decode1 should alias to percent_decode' do
    astr = subject

    astr.should respond_to(:percent_decode1)
  end

  it 'percent_decode1! should alias to percent_decode!' do
    astr = subject

    astr.should respond_to(:percent_decode1!)
  end

  it 'urlencode! should raise TypeError if opts is not a kind of Hash' do
    astr = subject

    lambda { subject.urlencode!('a') }.should raise_error(TypeError)
  end

  it 'urlencode! should raise TypeError if opts[:nibble] is not a kind of Symbol or NilClass' do
    astr = subject

    lambda { subject.urlencode!({:nibble => '', :count => 1}) }.should raise_error(TypeError)
  end

  it 'urlencode! should raise RangeError if opts[:count] is equal to zero' do
    astr = subject

    lambda { subject.urlencode!({:nibble => :first, :count => 0}) }.should raise_error(RangeError)
  end

  it 'urlencode! should raise RangeError if opts[:count] is less than zero' do
    astr = subject

    lambda { subject.urlencode!({:nibble => :first, :count => -1}) }.should raise_error(RangeError)
  end

  it 'urlencode! should raise NotImplementedError for unknown opts[:nibble] Symbols' do
    astr = subject

    lambda { subject.urlencode!({:nibble => :x, :count => 1}) }.should raise_error(NotImplementedError)
  end

  it 'urldecode should alias to percent_decode' do
    astr = subject

    astr.should respond_to(:urldecode)
  end

  it 'urldecode1 should alias to percent_decode' do
    astr = subject

    astr.should respond_to(:urldecode1)
  end

  it 'urldecode1! should alias to percent_decode!' do
    astr = subject

    astr.should respond_to(:urldecode1!)
  end

  it 'urldecode! should alias to percent_decode!' do
    astr = subject

    astr.should respond_to(:urldecode!)
  end

  it 'urldecode1! should alias to percent_decode!' do
    astr = subject

    astr.should respond_to(:urldecode1!)
  end

  it 'url_decode should alias to percent_decode' do
    astr = subject

    astr.should respond_to(:url_decode)
  end

  it 'url_decode! should alias to percent_decode!' do
    astr = subject

    astr.should respond_to(:url_decode!)
  end

  it 'uri_decode should alias to percent_decode' do
    astr = subject
    
    astr.should respond_to(:uri_decode)
  end

  it 'uri_decode! should alias to percent_decode!' do
    astr = subject

    astr.should respond_to(:uri_decode!)
  end

  it 'uridecode1 should alias to percent_decode' do
    astr = subject

    astr.should respond_to(:uridecode1)
  end

  it 'uridecode1! should alias to percent_decode!' do
    astr = subject

    astr.should respond_to(:uridecode1!)
  end

  it 'percent_encode should return a percent encoded String' do
    require'cgi'

    astr = subject

    lambda { CGI.unescape(subject.percent_encode) }.should == subject
  end
end
