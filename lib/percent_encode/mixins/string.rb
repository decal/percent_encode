# encoding: utf-8
#
# @author Derek Callaway [decal (AT) ethernet {D0T} org]
#
# @version 0.9.2
#
# @since 0.9.0
#

require'cgi'

module PercentEncode
  module String 
    module Mixin
      #
      # @param [Fixnum, Integer] achr a character to encode represented as a `String` of size 1
      #
      # @raise [TypeError] achr `Object` is not a kind of `Fixnum` or `Integer` 
      #
      # @return [String] encoded `achr` character
      #
      # @example String#char_encode
      #
      # @todo String#char_decode
      #
      def char_encode(achr)
        raise(TypeError, 'achr must be a kind of Fixnum or Integer!') if !(achr.kind_of?(Fixnum) or achr.kind_of?(Integer))

        case achr
        when 15 
          'F'
        when 14 
          'E' 
        when 13 
          'D' 
        when 12 
          'C'
        when 11 
          'B'
        when 10 
          'A'
        else
          achr
        end
      end

      #
      # @return [String] single percent encode of original `self` `String`
      #
      def percent_encode
        astr = ''

        self.bytes.map do |c|
          astr << "%#{char_encode(c / 16)}#{char_encode(c % 16)}"
        end

        astr
      end

      #
      # @return [String] a single percent encode of original `self` `String`
      #
      def percent_encode!
        astr = ''

        self.bytes.map! do |c|
          astr << "%#{char_encode(c / 16)}#{char_encode(c % 16)}"
        end

        self.sub!(%r{^.*$}, astr)
      end

      # 
      # @return [String] percent decoded string
      #
      def percent_decode
        astr = CGI.unescape(self)
      end

      #
      # @return [String] percent decoded string (with destructive invoke)
      #
      def percent_decode!
        astr = CGI.unescape(self)

        self.sub!(%r{^.*$}, astr)
      end

      # 
      # @param [Hash] opts
      #   URL hexadecimal encoding options
      #
      # @option opts [Symbol, NilClass] :nibble
      #   Style of encoding to use, `nil` means the default which is similar to
      #   `CGI.escape` from Ruby's standard library 
      #
      # @option opts [Fixnum, Integer] :count
      #   Number of times to encode
      #
      # @raise [TypeError] opts must be a kind of `Hash` 
      #   opts[:nibble] must be a kind of `Symbol` or `NilClass`
      #   opts[:count] must be a kind of `Fixnum` or `Integer`
      #
      # @raise [NotImplementedError] Unknown opts[:nibble] `Symbol`
      #
      # @raise [RangeError] opts[:count] cannot be less than or equal to zero
      #
      # @return [String] a custom-encoded version of the original `self` `String`
      #
      # @see https://tools.ietf.org/html/rfc3986#section-2.1
      #
      # @see http://www.w3schools.com/tags/ref_urlencode.asp
      #
      # @todo more options? 
      #
      # @example 'a'.urlencode!({:nibble => :single, count => 1}) => "%41"
      # 
      def urlencode!(opts = {:nibble => :single, :count => 1})
        isop, anib, aret, acnt, anum = false, nil, %q{}, 1, 0

        return aret if self and self.empty?

        if opts
          raise(TypeError, 'opts must be a kind of Hash!') if !opts.kind_of?(Hash)

          isop = true
        end

        if isop
          if opts.key?(:nibble)
            anib = opts[:nibble]

            raise(TypeError, 'opts[:nibble] must be a kind of Symbol or NilClass!') if !(anib.kind_of?(Symbol) or anib.kind_of?(NilClass))

            case anib
            when :first
            when :second
            when :single
            when :double
            when :triple
            when :unicode
            when nil
            else
              raise(NotImplementedError, 'Unknown opts[:nibble] symbol!') if anib
            end
          end

          if opts.key?(:count)
            acnt = opts[:count]

            raise(TypeError, 'opts[:count] must be a kind of Fixnum or Integer!') if !(acnt.kind_of?(Fixnum) or acnt.kind_of?(Integer))
            raise(RangeError, 'opts[:count] cannot be less than or equal to zero!') if acnt.zero? or acnt < 0
          end
        end

        for i in 1 .. acnt do
          aret, aflg, crpt, atmp = %q{}, true, %q{%}, %q{}
          empt, hstr, ptre, glre = atmp.dup, %q{H*}, %r{crpt}, %r{^.*$}

          case anib
          when :unicode # @todo refactor below code into a reusable &block method
            aint, ahex = 0, self.percent_encode

            ahex.bytes.each_with_index do |c, k|
              if aint.zero?
                aret << '%'

                aint += 1
              elsif aint == 1
                aret << "%U00#{char_encode(c / 16)}#{char_encode(c % 16)}"

                aint += 1
              else
                aret << "%U00#{char_encode(c / 16)}"

                aint = 0
              end
            end
          when :first
            aint, ahex = 0, self.percent_encode

            ahex.bytes.each_with_index do |c, k|
              if aint.zero?
                aret << '%'

                aint += 1
              elsif aint == 1
                aret << "%#{char_encode(c / 16)}#{char_encode(c % 16)}"

                aint += 1
              else
                aret << "#{char_encode(c % 16)}"

                aint = 0
              end
            end
          when :second
            aint, ahex = 0, self.percent_encode

            ahex.bytes.each_with_index do |c, k|
              if aint.zero?
                aret << '%'

                aint += 1
              elsif aint == 1
                aret << "%#{char_encode(c / 16)}"

                aint += 1
              else
                aret << "%#{char_encode(c / 16)}#{char_encode(c % 16)}"

                aint = 0
              end
            end
          when :triple
            aret << self.percent_encode.percent_encode.percent_encode
          when :double
            aret << self.percent_encode.percent_encode
          when :single
            aret << self.percent_encode
          else
            aret << self.percent_encode
          end

          self.sub!(glre, aret)
        end

        (aret and !aret.empty?) ? aret : self
      end

      #
      # Wrapper for urlencode
      #
      # @param aopt [Hash] options setting symbol values
      # 
      # @return [String] singly percent encoded URL
      #
      def urlencode1(aopt = {:nibble => :single, :count => 1 } )
        self.urlencode
      end

      # 
      # Helper for constructive method percent_decode
      #
      # @return [String] doubly percent encoded URL
      #
      def urlencode2
        self.percent_encode.percent_encode
      end

      #
      # Another helper for constructive method percent_decode
      #
      # @return [String] triply percent encoded URL
      #
      def urlencode3
        self.percent_encode.percent_encode.percent_encode
      end

      # 
      # Wrapper for destructive method urlencode! 
      #
      # @param [Hash] aopt options setting symbol values
      #
      # @return [String] singly percent encoded URL
      # 
      def urlencode1!(aopt = {:nibble => :single, :count => 1 } )
        self.urlencode!(aopt)
      end

      #
      # Another wrapper for destructive method urlencode!
      #
      # @param [Hash] aopt options setting symbol values
      #
      # @return [String] doubly percent encoded URL
      #
      def urlencode2!(aopt = {:nibble => :double, :count => 1 } )
        self.urlencode!(aopt)
      end

      #
      # Yet another Wrapper for destructive method urlencode!
      #
      # @param [Hash] aopt options setting symbol values
      #
      # @return [String] triply percent encoded URL
      #
      def urlencode3!(aopt = {:nibble => :triple, :count => 1 } )
        self.urlencode!(aopt)
      end

      alias_method :url_encode!, :urlencode!
      alias_method :uri_encode!, :urlencode!
      alias_method :uriencode!, :urlencode! 
      alias_method :uriencode1!, :urlencode1!
      alias_method :uriencode2!, :urlencode2!
      alias_method :uriencode3!, :urlencode3!
      alias_method :uriencode1, :urlencode1
      alias_method :uriencode2, :urlencode2
      alias_method :uriencode3, :urlencode3
      alias_method :uri_encode1, :urlencode1
      alias_method :uri_encode2, :urlencode2
      alias_method :uri_encode3, :urlencode3
      alias_method :uri_encode1!, :urlencode1!
      alias_method :uri_encode2!, :urlencode2!
      alias_method :uri_encode3!, :urlencode3!
      alias_method :url_encode1, :urlencode1
      alias_method :url_encode2, :urlencode2
      alias_method :url_encode3, :urlencode3
      alias_method :url_encode1!, :urlencode1!
      alias_method :url_encode2!, :urlencode2!
      alias_method :url_encode3!, :urlencode3!
      alias_method :percent_encode1, :percent_encode
      alias_method :percent_decode1, :percent_decode
      alias_method :percent_encode1!, :percent_encode!
      alias_method :percent_decode1!, :percent_decode!
      alias_method :urldecode, :percent_decode
      alias_method :urldecode1, :percent_decode
      alias_method :urldecode!, :percent_decode!
      alias_method :urldecode1!, :percent_decode!
      alias_method :url_decode, :percent_decode
      alias_method :url_decode!, :percent_decode!
      alias_method :uri_decode, :percent_decode
      alias_method :uridecode, :percent_decode
      alias_method :uri_decode!, :percent_decode!
      alias_method :uridecode1, :percent_decode
      alias_method :uridecode1!, :percent_decode!
    end
  end
end
