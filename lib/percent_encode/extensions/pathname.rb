# encoding: utf-8
#
# @author Derek Callaway [decal (AT) ethernet {D0T} org]
#
# @version 0.9.0
#
# @since 0.9.0
#
# @see Pathname
#
# @see PercentEncode::Pathname::Mixin
#

require'percent_encode/mixins/pathname'
require'pathname'

class Pathname
  include PercentEncode::Pathname::Mixin
end
