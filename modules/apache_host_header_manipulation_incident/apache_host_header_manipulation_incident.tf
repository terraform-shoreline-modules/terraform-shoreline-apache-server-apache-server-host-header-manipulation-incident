resource "shoreline_notebook" "apache_host_header_manipulation_incident" {
  name       = "apache_host_header_manipulation_incident"
  data       = file("${path.module}/data/apache_host_header_manipulation_incident.json")
  depends_on = [shoreline_action.invoke_apache_version_module,shoreline_action.invoke_update_upgrade_apache,shoreline_action.invoke_apache_conf_backup]
}

resource "shoreline_file" "apache_version_module" {
  name             = "apache_version_module"
  input_file       = "${path.module}/data/apache_version_module.sh"
  md5              = filemd5("${path.module}/data/apache_version_module.sh")
  description      = "Check the Apache version and installed modules"
  destination_path = "/agent/scripts/apache_version_module.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "update_upgrade_apache" {
  name             = "update_upgrade_apache"
  input_file       = "${path.module}/data/update_upgrade_apache.sh"
  md5              = filemd5("${path.module}/data/update_upgrade_apache.sh")
  description      = "Patch the Apache web server by installing the latest updates and security patches to prevent known vulnerabilities."
  destination_path = "/agent/scripts/update_upgrade_apache.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "apache_conf_backup" {
  name             = "apache_conf_backup"
  input_file       = "${path.module}/data/apache_conf_backup.sh"
  md5              = filemd5("${path.module}/data/apache_conf_backup.sh")
  description      = "Enable strict validation of the Host header in the web server configuration to prevent manipulation attempts."
  destination_path = "/agent/scripts/apache_conf_backup.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_version_module" {
  name        = "invoke_apache_version_module"
  description = "Check the Apache version and installed modules"
  command     = "`chmod +x /agent/scripts/apache_version_module.sh && /agent/scripts/apache_version_module.sh`"
  params      = []
  file_deps   = ["apache_version_module"]
  enabled     = true
  depends_on  = [shoreline_file.apache_version_module]
}

resource "shoreline_action" "invoke_update_upgrade_apache" {
  name        = "invoke_update_upgrade_apache"
  description = "Patch the Apache web server by installing the latest updates and security patches to prevent known vulnerabilities."
  command     = "`chmod +x /agent/scripts/update_upgrade_apache.sh && /agent/scripts/update_upgrade_apache.sh`"
  params      = []
  file_deps   = ["update_upgrade_apache"]
  enabled     = true
  depends_on  = [shoreline_file.update_upgrade_apache]
}

resource "shoreline_action" "invoke_apache_conf_backup" {
  name        = "invoke_apache_conf_backup"
  description = "Enable strict validation of the Host header in the web server configuration to prevent manipulation attempts."
  command     = "`chmod +x /agent/scripts/apache_conf_backup.sh && /agent/scripts/apache_conf_backup.sh`"
  params      = ["PATH_TO_APACHE_CONFIG_FILE"]
  file_deps   = ["apache_conf_backup"]
  enabled     = true
  depends_on  = [shoreline_file.apache_conf_backup]
}

