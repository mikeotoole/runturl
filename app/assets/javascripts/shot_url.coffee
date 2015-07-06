$(document).ready ->
  if $('.short-urls.new').length
    $text_input = $('#short_url_original_url')
    $text_input.focus()
    $text_input.select()

    $('#short_url_original_url').keyup ->
      $submit_button = $('#short-url-submit-button')
      $test_link = $('#short-url-test-link')
      $test_link.addClass('hidden')
      $submit_button.removeClass('hidden')
