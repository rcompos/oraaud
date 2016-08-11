class oraaud::service (
) inherits oraaud {

  exec {'service_config':
    command     => "/home/oracle/system/audit/config_oraaud_OS_service.sh",
    path        => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
    refreshonly => true,
  }

}
