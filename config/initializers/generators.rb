#これから rails g ... で Model や Controller などを作成していきますが、不要なものを自動生成したくないので、
#下記のように設定します。config/initializers/generators.rb は自動生成されていないので、自分でファイルを作成します。
#config/initializers/ フォルダ内の初期設定用の Ruby ファイルは Rails 起動時に自動的に全てが読み込まれる仕組みになっています。

Rails.application.config.generators do |g|
  g.stylesheets false
  g.javascripts false
  g.helper false
  g.skip_routes true
end