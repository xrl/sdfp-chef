Vagrant::Config.run do |config|
  config.vm.provision :chef_solo do |chef|
    # This path will be expanded relative to the project directory
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("haskell")
    chef.add_recipe("clojure")

    chef.json = File.read(File.join(File.dirname(__FILE__),("config/server.json")))
  end
end