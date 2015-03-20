// -------------------------------------------------------------------
// Init
// -------------------------------------------------------------------

(function ($) {

  // Svg fallback
  //
  // if(!Modernizr.svg) {
  //   $('img[src*="svg"]').attr('src', function() {
  //       return $(this).attr('src').replace('.svg', '.png');
  //   });
  // }

  // Fastclick
  //
  window.addEventListener('load', function() {
    FastClick.attach(document.body);
  }, false);

})(jQuery);
