class PasswordRevealInput < SimpleForm::Inputs::PasswordInput
  def input(wrapper_options)
    input_html_options[:value] = object.send(attribute_name)

    input = @builder.password_field(attribute_name, merge_wrapper_options(input_html_options, wrapper_options))
    link  = %{
      <a class = "password-reveal" id="#{input_class}_reveal" href="#">
        <div class="checkbox">
          <input type="checkbox" name="test" value="1" class="boolean optional">
          <label class="checkbox">reveal</label>
        </div>
      </a>
    }.html_safe
    js    = %{
      <script>
        $('a##{input_class}_reveal').click(function() {
          var input = $('##{input_class}');

          if (input.attr('type') == 'password') {
            input.attr('type', 'text');
            $(this).find('input').prop("checked", true);
          } else {
            input.attr('type', 'password');
            $(this).find('input').prop("checked", false);
          }

          return false;
        });
      </script>
    }.html_safe

    input + link + js
  end
end
