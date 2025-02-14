$(document).ready(function() {
  var $tab_with_error = $(".form-control.is-invalid").first().closest('.tab-pane');

  if ($tab_with_error.length > 0) {
    $(".nav.nav-tabs").find("a[href^='#" + $tab_with_error.attr('id') + "']").tab('show');
  } else if (document.location.hash.length > 0) {
    var $tab_from_url = $(".nav.nav-tabs").find("a[href^='" + document.location.hash + "']");

    if ($tab_from_url.length > 0) {
      document.location.hash = ""; // This prevents scrolling to the wrong place in the page
      $tab_from_url.tab("show");
    }
  }
});

$(document).on('click', '[data-click-tab]', function(event) {
  event.preventDefault();

  var href = $(event.currentTarget).attr('href');
  $('.nav.nav-tabs').find("a[href^='" + href + "']").tab('show');
});
