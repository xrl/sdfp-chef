San Diego Functional Programming Multiuser Server
=================================================

We've setup a server so that our users can try things out on a preconfigured, ready-to-go server. All you'll need is an SSH client.

The entire server configuration can be found in this repository and users the chef-solo provisioning system.

You will need to install ruby from source and then gem install chef. This will provide you with the chef-solo executable. Check out this repository in to /var/chef and then run

    chef-solo -c solo.rb -o "recipe[build-essential],recipe[haskell],recipe[java]"

Xavier is still getting a handle on how to do these things the 'right way' so feel free to shoot him a message.