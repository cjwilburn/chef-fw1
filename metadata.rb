maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "wilburnc@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs ColdFusion Framework One"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

supports 'ubuntu', '= 10.04'
supports 'ubuntu', '>= 11.04'



recipe "default", "default recipe"
recipe "fw1", "pulls repo from github and places it in top-level frameworks directory"