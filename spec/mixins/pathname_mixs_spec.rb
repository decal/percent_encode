# encoding: utf-8

require'pathname'
require'percent_encode/mixins/pathname'

describe Pathname do
  subject { Pathname } 

  it_should_behave_like 'PercentEncode::Pathname::Mixin'
end
