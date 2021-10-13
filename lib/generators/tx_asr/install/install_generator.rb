class TxAsr::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  def install
    copy_file "initializer.rb", "config/initializers/tx_asr.rb"
  end
end
