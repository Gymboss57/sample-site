# module SampleHelpers
#   def foo
#     return 'bar'
#   end
# end

module JavascriptHelpers

  # Print hash as javascript literal
  def print_hash_as_jliteral(hash)
    js_literal = ''

    # literal hash
    hash.each do |k, v|
      case hash[k].class.to_s
        # hash
        when 'Thor::CoreExt::HashWithIndifferentAccess'
          js_literal << k + ": {"
          js_literal << print_hash_as_jliteral(hash[k]) # recursion
          js_literal << '},'

        # true / false
        when 'TrueClass', 'FalseClass'
          js_literal << k + ": " + hash[k].to_s + ",\n"

        # string
        when 'String'
            js_literal << k + ": '" + hash[k].to_s + "',\n"
        else
            js_literal << 'print_hash_as_jliteral.error.unknown_type: ' + hash[k].class.to_s + ",\n"
        end
      end
    return js_literal
  end

end
