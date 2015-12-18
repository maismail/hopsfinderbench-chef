include_attribute "ndb"
include_attribute "elastic"

default[:hopsfindbench][:user]                = "root"
node.override[:download_url] = "file:///home/maism/hopsdownloads" 
