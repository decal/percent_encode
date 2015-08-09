# encoding: utf-8
#
# @author Derek Callaway [decal (AT) ethernet {D0T} org]
#
# @version 0.9.0
#
# @since 0.9.0
#

require'percent_encode/extensions/pathname'

module PercentEncode
  module Pathname
    module Mixin
      #
      # @param opts [Hash]
      #   Hexadecimal URL encoding optional settings
      #
      # @option opts [Symbol, NilClass] :nibble
      #   style of encoding to use
      #
      # @option opts [Fixnum, Integer] :count
      #   number of times to encode string
      #
      # @see http://decal.sdf.org/doc/uris-ids-evasion.txt
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
