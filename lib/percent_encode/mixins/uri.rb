# encoding: utf-8
#
# @author Derek Callaway [decal (AT) ethernet {D0T} org]
#
# @version 0.9.0
#
# @since 0.9.0
#

require'percent_encode/mixins/string'

module PercentEncode
  module URI
    module Mixin
      # 
      # @options opts [Hash]
      #   Hexadecimal URL encoding optional settings
      #
      def urlencode!(opts = {})
        self.to_s.urlencode!(opts)
      end

      alias_method :url_encode!, :urlencode!
      alias_method :uri_encode!, :urlencode!
      alias_method :uriencode!, :urlencode!
    end
  end
end
