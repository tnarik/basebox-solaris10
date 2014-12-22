cat <<EOF > Vagrantfile

ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|
  config.vm.box = "tnarik/solaris10-minimal"
  config.vm.provision :shell,
    :inline => "wget -O - https://www.getchef.com/chef/install.sh | sudo bash"
end
EOF

vagrant up && vagrant package && vagrant destroy -f
vagrant box add --name tnarik/solaris10-minimal-with-chef package.box
