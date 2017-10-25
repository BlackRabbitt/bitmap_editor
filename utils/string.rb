module Utils
  module String
    def is_integer?(val)
      val.to_i.to_s == val
    end

    def is_colour?(str)
      str.size == 1 && str[0] >= 'A' && str[0] <= 'Z'
    end
  end
end
