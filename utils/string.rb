module Utils
  module String
    def is_integer(val)
      val.to_i.to_s == val
    end
  end
end
