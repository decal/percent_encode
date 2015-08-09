# encoding: utf-8

require'./spec_helper'
require'percent_encode/version'

describe PercentEncode do
  subject.const_get('VERSION').should_not be nil
end
