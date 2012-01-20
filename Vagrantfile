Vagrant::Config.run do |config|

  config.vm.box = "lucid32"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "chef/cookbooks"
    chef.add_recipe "simgrid::ruby"
  end
end
