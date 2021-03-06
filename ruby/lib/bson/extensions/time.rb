module BSON
  module Extensions
    module Time
      BSON_TYPE = "\x09"

      def to_bson
        [BSON_TYPE, [(to_i * 1000) + (usec / 1000)].pack(INT64_PACK)]
      end

      module ClassMethods
        def from_bson(bson)
          seconds, fragment = bson.read(8).unpack(INT64_PACK).first.divmod 1000
          at(seconds, fragment * 1000).utc
        end
      end
    end
  end
end