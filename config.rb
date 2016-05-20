###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

set :haml, { :attr_wrapper => "\""} 

#set :default_encoding, "Shift_JIS"
#Encoding.default_external="Shift_JIS"

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

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end
set :relative_links, true

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'


configure :development do
  #開発中も確認する
  activate :relative_assets
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets

  # Or use a different image path
  # set :http_path, "/Content/images/"

  compass_config do |config|
    config.sass_options = {:line_comments => false}
  end

end

#bower init
after_configuration do
  bower_path=File.join(root, 'bower_components')
  {
    #bower install jquery=jquery#^1 --save
    'jquery/dist'=>[
      'jquery.js',
      'jquery.min.js',
    ],
    #bower install jquery.easing --save
    'jquery.easing/js'=>[
      'jquery.easing.js',
      'jquery.easing.min.js',
    ],
    #bower install velocity --save
    'velocity'=>[
      'velocity.js',
      'velocity.min.js',
    ],
    #bower install gsap --save
    'gsap/src/uncompressed'=>[
      'jquery.gsap.js',
      'TimelineLite.js',
      'TimelineMax.js',
      'TweenLite.js',
      'TweenMax.js',
    ],
    'gsap/src/minified'=>[
      'jquery.gsap.min.js',
      'TimelineLite.min.js',
      'TimelineMax.min.js',
      'TweenLite.min.js',
      'TweenMax.min.js',
    ],
    #bower install scrollmagic --save
    'scrollmagic/scrollmagic/uncompressed/plugins'=>[
      'debug.addIndicators.js',
      'jquery.ScrollMagic.js',
      'animation.gsap.js',
      'animation.velocity.js',
    ],
    'scrollmagic/scrollmagic/uncompressed'=>[
      'ScrollMagic.js',
    ],
    'scrollmagic/scrollmagic/minified/plugins'=>[
      'debug.addIndicators.min.js',
      'jquery.ScrollMagic.min.js',
      'animation.gsap.min.js',
      'animation.velocity.min.js',
    ],
    'scrollmagic/scrollmagic/minified'=>[
      'ScrollMagic.min.js',
    ],
  }.each_pair do|k,a|
    a.each do|v|
      import_file File.join(bower_path, k,v),File.join('/js',v)
    end
  end
end


helpers do
  def rel_root
    url=current_page.url
    if url=="/"
      "./"
    else
      "./"+"../"*(url.count("/")-1)
    end
  end
end

activate :livereload

ignore "/coffee/**"
activate :external_pipeline,
  name: :coffeefy,
  command: build? ? 'npm run build' : 'npm run watch',
  source: ".tmp/dist"
