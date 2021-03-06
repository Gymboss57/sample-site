module Padrino
  module Helpers
    ##
    # Helpers related to producing html tags within templates.
    #
    module TagHelpers
      ##
      # Tag values escaped to html entities.
      #
      ESCAPE_VALUES = {
        "&" => "&amp;",
        "<" => "&lt;",
        ">" => "&gt;",
        '"' => "&quot;"
      }

      ##
      # Cached Regexp for escaping values to avoid rebuilding one
      # on every escape operation.
      #
      ESCAPE_REGEXP = Regexp.union(*ESCAPE_VALUES.keys)

      BOOLEAN_ATTRIBUTES = [
        :autoplay,
        :autofocus,
        :formnovalidate,
        :checked,
        :disabled,
        :hidden,
        :loop,
        :multiple,
        :muted,
        :readonly,
        :required,
        :selected,
        :declare,
        :defer,
        :ismap,
        :itemscope,
        :noresize,
        :novalidate
      ]

      ##
      # Custom data attributes,
      # feel free to update with yours:
      #
      #   Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
      #   text_field :foo, :dialog => true
      #   # Generates: <input type="text" data-dialog="true" name="foo" />
      #
      DATA_ATTRIBUTES = [
        :method,
        :remote,
        :confirm
      ]

      ##
      # A html_safe newline string to avoid allocating a new on each
      # concatenation.
      #
      NEWLINE = "\n".html_safe.freeze

      ##
      # Creates an HTML tag with given name, content, and options.
      #
      # @overload content_tag(name, content, options = nil)
      #   @param [Symbol] name
      #     The name of the HTML tag to create.
      #   @param [String] content
      #     The content inside of the tag.
      #   @param [Hash] options
      #     The HTML options to include in this tag.
      #
      # @overload content_tag(name, options = nil, &block)
      #   @param [Symbol] name
      #     The name of the HTML tag to create.
      #   @param [Hash] options
      #     The HTML options to include in this tag.
      #   @param [Proc] block
      #     The block returning HTML content.
      #
      # @macro [new] global_html_attributes
      #   @option options [String] :id
      #     Specifies a unique identifier for the element.
      #   @option options [String] :class
      #     Specifies the stylesheet class of the element.
      #   @option options [String] :title
      #     Specifies the title for the element.
      #   @option options [String] :accesskey
      #     Specifies a shortcut key to access the element.
      #   @option options [Symbol] :dropzone
      #     Specifies what happens when dragged items are dropped on the element. (:copy, :link, :move)
      #   @option options [Boolean] :hidden
      #     Specifies whether or not the element is hidden from view.
      #   @option options [Boolean] :draggable
      #     Specifies whether or not the element is draggable. (true, false, :auto)
      #   @option options [Boolean] :contenteditable
      #     Specifies whether or not the element is editable.
      #
      # @return [String]
      #   Generated HTML with specified +options+.
      #
      # @example
      #   content_tag(:p, 'Hello World', :class => 'light')
      #
      #   # => <p class="light">
      #   # =>   Hello World
      #   # => </p>
      #
      #   content_tag(:p, :class => 'dark') do
      #     link_to 'Padrino', 'http://www.padrinorb.com'
      #   end
      #
      #   # => <p class="dark">
      #   # =>   <a href="http://www.padrinorb.com">Padrino</a>
      #   # => </p>
      #
      def content_tag(name, content = nil, options = nil, &block)
        if block_given?
          options = content if content.is_a?(Hash)
          content = capture_html(&block)
        end

        options    = parse_data_options(name, options)
        attributes = tag_attributes(options)
        output = ActiveSupport::SafeBuffer.new
        output.safe_concat "<#{name}#{attributes}>"
        if content.respond_to?(:each) && !content.is_a?(String)
          content.each { |c| output.concat c; output.safe_concat NEWLINE }
        else
          output.concat content
        end
        output.safe_concat "</#{name}>"

        block_is_template?(block) ? concat_content(output) : output
      end

      ##
      # Like #content_tag, but assumes its input to be safe and doesn't
      # escape. It also returns safe HTML.
      #
      # @see #content_tag
      #
      def safe_content_tag(name, content = nil, options = nil, &block)
        mark_safe(content_tag(name, mark_safe(content), options, &block))
      end

      ##
      # Creates an HTML input field with the given type and options.
      #
      # @param [Symbol] type
      #   The type of input to create.
      # @param [Hash] options
      #   The HTML options to include in this input.
      #
      # @option options [String] :id
      #   Specifies a unique identifier for the input.
      # @option options [String] :class
      #   Specifies the stylesheet class of the input.
      # @option options [String] :name
      #   Specifies the name of the input.
      # @option options [String] :accesskey
      #   Specifies a shortcut key to access the input.
      # @option options [Integer] :tabindex
      #   Specifies the tab order of the input.
      # @option options [Boolean] :hidden
      #   Specifies whether or not the input is hidden from view.
      # @option options [Boolean] :spellcheck
      #   Specifies whether or not the input should have it's spelling and grammar checked for errors.
      # @option options [Boolean] :draggable
      #   Specifies whether or not the input is draggable. (true, false, :auto)
      # @option options [String] :pattern
      #   Specifies the regular expression pattern that the input's value is checked against.
      # @option options [Symbol] :autocomplete
      #   Specifies whether or not the input should have autocomplete enabled. (:on, :off)
      # @option options [Boolean] :autofocus
      #   Specifies whether or not the input should automatically get focus when the page loads.
      # @option options [Boolean] :required
      #   Specifies whether or not the input is required to be completed before the form is submitted.
      # @option options [Boolean] :readonly
      #   Specifies whether or not the input is read only.
      # @option options [Boolean] :disabled
      #   Specifies whether or not the input is disabled.
      #
      # @return [String]
      #   Generated HTML with specified +options+.
      #
      # @example
      #   input_tag :text, :name => 'handle'
      #   # => <input type="test" name="handle" />
      #
      #   input_tag :password, :name => 'password', :size => 20
      #   # => <input type="password" name="password" size="20" />
      #
      #   input_tag :text, :name => 'username', :required => true, :autofocus => true
      #   # => <input type="text" name="username" required autofocus />
      #
      #   input_tag :number, :name => 'credit_card', :autocomplete => :off
      #   # => <input type="number" autocomplete="off" />
      #
      def input_tag(type, options = {})
        tag(:input, options.reverse_merge!(:type => type))
      end

      ##
      # Creates an HTML tag with the given name and options.
      #
      # @param [Symbol] name
      #  The name of the HTML tag to create.
      # @param [Hash] options
      #  The HTML options to include in this tag.
      #
      # @macro global_html_attributes
      #
      # @return [String]
      #   Generated HTML with specified +options+.
      #
      # @example
      #   tag :hr, :class => 'dotted'
      #   # => <hr class="dotted" />
      #
      #   tag :input, :name => 'username', :type => :text
      #   # => <input name="username" type="text" />
      #
      #   tag :img, :src => 'images/pony.jpg', :alt => 'My Little Pony'
      #   # => <img src="images/pony.jpg" alt="My Little Pony" />
      #
      #   tag :img, :src => 'sinatra.jpg, :data => { :nsfw => false, :geo => [34.087, -118.407] }
      #   # => <img src="sinatra.jpg" data-nsfw="false" data-geo="34.087 -118.407" />
      #
      def tag(name, options = nil, open = false)
        options    = parse_data_options(name, options)
        attributes = tag_attributes(options)
        "<#{name}#{attributes}#{open ? '>' : ' />'}".html_safe
      end

      private
      ##
      # Returns a compiled list of HTML attributes.
      #
      def tag_attributes(options)
        return '' if options.nil?
        attributes = options.map do |k, v|
          next if v.nil? || v == false
          if v.is_a?(Hash)
            nested_values(k, v)
          elsif BOOLEAN_ATTRIBUTES.include?(k)
            %(#{k}="#{k}")
          else
            %(#{k}="#{escape_value(v)}")
          end
        end.compact
        attributes.empty? ? '' : " #{attributes * ' '}"
      end

      ##
      # Escape tag values to their HTML/XML entities.
      #
      def escape_value(string)
        string.to_s.gsub(ESCAPE_REGEXP) { |c| ESCAPE_VALUES[c] }
      end

      ##
      # Iterate through nested values.
      #
      def nested_values(attribute, hash)
        hash.map do |k, v|
          if v.is_a?(Hash)
            nested_values("#{attribute}-#{k.to_s.dasherize}", v)
          else
            %(#{attribute}-#{k.to_s.dasherize}="#{escape_value(v)}")
          end
        end * ' '
      end

      ##
      # Parses custom data attributes.
      #
      def parse_data_options(tag, options)
        return if options.nil?
        parsed_options = options.dup
        options.each do |k, v|
          next if !DATA_ATTRIBUTES.include?(k) || (tag.to_s == 'form' && k == :method)
          parsed_options["data-#{k}"] = parsed_options.delete(k)
          parsed_options[:rel] = 'nofollow' if k == :method
        end
        parsed_options
      end
    end
  end
end
