
# Page options, layouts, aliases and proxies
# -------------------------------------------------------------------

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

with_layout :styleguide do
  page "/styleguide/*"
end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

require 'lib/extensions/pages_directory.rb'
activate :pages_directory

require 'lib/extensions/custom_urls.rb'
activate :custom_urls

activate :livereload
activate :directory_indexes
activate :automatic_image_sizes

set :css_dir,      'assets/scss'
set :js_dir,       'assets/js'
set :images_dir,   'assets/img'
set :data_dir,     'source/_templates/data'
set :partials_dir, '_templates/partials'
set :layouts_dir,  '_templates/layouts'
set :helpers_dir,  'lib/helpers'
# set :fonts_dir

# -------------------------------------------------------------------
# Build-specific config
# -------------------------------------------------------------------

configure :build do
  activate :minify_css
  activate :minify_javascript
  # activate :relative_assets
  # activate :cache_buster
  # activate :asset_hash

  # Alt image path
  # set :http_prefix, "/Content/images/"
end
