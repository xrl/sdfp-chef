Vagrant::Config.run do |config|
  config.vm.box = "precise32"
  
  config.vm.provision :chef_solo do |chef|
    # This path will be expanded relative to the project directory
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("build-essential")

    chef.json = JSON.parse(File.read(File.join(File.dirname(__FILE__),("nodes/sdfunctional.json"))))
  end
end
