# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.8.1"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure("2") do |config|

  config.vm.hostname = "ie-0521"
  config.vm.provider "docker" do |d|
    d.image = "jsdanielh/ie-0521:0.0.2"
    d.has_ssh = true
#    d.pull = true
  end
  config.vm.network :forwarded_port, host: 9090, guest: 8080, auto_correct: true
  config.ssh.username = "ie0521"
  config.ssh.forward_agent = true
  config.ssh.pty = true
  config.vm.synced_folder ".", "/home/ie0521/ws"
  config.vm.provision "file",
    source: "~/.gitconfig",
    destination: "/home/ie0521/.gitconfig" if File.exist?(ENV["HOME"] + "/.gitconfig")
end
