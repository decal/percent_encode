# encoding: utf-8
#
# @author Derek Callaway [decal (AT) ethernet {D0T} org]
#
# @version 0.9.2
#
# @since 0.9.0
#
# @see URI
#
# @see PercentEncode::URI::Mixin
#

require'percent_encode/mixins/uri'
require'uri'

module URI
  include PercentEncode::URI::Mixin
end
