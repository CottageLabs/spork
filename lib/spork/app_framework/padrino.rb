class Spork::AppFramework::Padrino < Spork::AppFramework

  def preload(&block)
    STDERR.puts "Preloading Padrino environment"
    STDERR.flush
    ENV["RACK_ENV"] ||= "test"
    require boot_file
    # Make it so that we don't have to restart Spork if we change, say, a model or routes
    Spork.each_run { ::Padrino.reload! }
    yield
    # the Rails spork gem does this, not sure if we need to with Padrino and ActiveRecord
    # ActiveRecord::Base.remove_connection if defined?(ActiveRecord)
  end

  def entry_point
    @entry_point ||= File.expand_path("config/boot.rb", Dir.pwd)
  end
  alias :boot_file :entry_point

  def self.present?
    File.exist?("config/boot.rb") && File.read("config/boot.rb").include?('Padrino')
  end

end