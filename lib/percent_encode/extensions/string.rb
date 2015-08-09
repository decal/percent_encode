# encoding: utf-8
#
# @author Derek Callaway [decal (AT) ethernet {D0T} org]
#
# @version 0.9.0
#
# @since 0.9.0
#
# @see String
#
# @see PercentEncode::String::Mixin
#

require 'percent_encode/mixins/string'

class String
  include PercentEncode::String::Mixin
end
