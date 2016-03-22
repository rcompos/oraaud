class oraaud::params {

  # params
  $aud_server           = 'fsxopsx9999.fdc.fs.usda.gov'

  # module params
  # src_dir             : path to install files
  $src_dir              = '/fslink/sysinfra/tivoli/itm630agent'
  $dir_tmp              = '/tmp'
  $itm_home             = '/opt/IBM/ITM'
  $tar_file             = 'nameoffile.tar'
  $tar_dir              = regsubst($tar_file, '\.tar$', '')
  $script_file          = 'itm630lnxagt.tgz'
  $script_dir           = regsubst($script_file, '\.tgz$', '')

}
