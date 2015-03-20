// Libs
//= require libs/fastclick.js
//= require libs/jquery.js
//= require libs/jquery.fitvids.js

// Src
//= require_tree ./src

// Init
//= require ./src/init.js

$(document).ready(function(){
  // Target your .container, .wrapper, .post, etc.
  $("body").fitVids();
});
