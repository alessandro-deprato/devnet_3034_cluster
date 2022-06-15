provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {

  source  = "terraform-cisco-modules/iks/intersight//"
  version = "2.2.1"

  # Kubernetes Cluster Profile  Adjust the values as needed.
  cluster = {
    name                = "iks_terraform_cluster"
    action              = "Unassign"
    wait_for_completion = false
    worker_nodes        = 1
    load_balancers      = 5
    worker_max          = 2
    control_nodes       = 1
    ssh_user            = var.ssh_user
    ssh_public_key      = var.ssh_key
  }

  # IP Pool Information (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  ip_pool = {
    use_existing        = false
    name                = "iks_terraform_ip_pool"
    ip_starting_address = "192.168.100.5"
    ip_pool_size        = "90"
    ip_netmask          = "255.255.255.0"
    ip_gateway          = "192.168.100.1"
    dns_servers         = ["192.168.97.2"]
  }

  # Sysconfig Policy (UI Reference NODE OS Configuration) (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  sysconfig = {
    use_existing = false
    name         = "iks_terraform_syconfig"
    domain_name  = "depexp.local"
    timezone     = "Europe/Rome"
    ntp_servers  = ["192.168.97.2"]
    dns_servers  = ["192.168.97.2"]
  }

  # Kubernetes Network CIDR (To create new change "use_existing" to 'false' uncomment variables and modify them to meet your needs.)
  k8s_network = {
    use_existing = false
    name         = "iks_terraform_int_network_pool"
    pod_cidr     = "100.96.0.0/16"
    service_cidr = "100.97.0.0/22"
    cni          = "Calico"
  }

  # Version policy (To create new change "useExisting" to 'false' uncomment variables and modify them to meet your needs.)
  versionPolicy = {
    useExisting    = false
    policyName     = "iks_terraform_version"
    iksVersionName = "1.21.10-iks.0"
  }

  # Trusted Registry Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
  # Set both variables to 'false' if this policy is not needed.
  tr_policy = {
    use_existing = false
    create_new   = false
    name         = "trusted-registry"
  }

  # Runtime Policy (To create new change "use_existing" to 'false' and set "create_new' to 'true' uncomment variables and modify them to meet your needs.)
  # Set both variables to 'false' if this policy is not needed.
  runtime_policy = {
    use_existing = false
    create_new   = false
  }

  # Infrastructure Configuration Policy (To create new change "use_existing" to 'false' and uncomment variables and modify them to meet your needs.)
  infraConfigPolicy = {
    use_existing = false
    platformType = "esxi"
    targetName   = var.vcenter
    policyName   = "iks_terraform_infra"
    description  = "On-Prem Lab"
    interfaces   = ["202_Lab_Cisco"]
    # In my case I am not using any Resource Pool, but the variable must be defined anyway with an empty value.
    vcResourcePoolName = ""
    vcClusterName      = "ADP_Cluster"
    vcDatastoreName    = "WD_DS_1TB"
    vcPassword         = var.vcenter_password
  }

  # Worker Node Instance Type (To create new change "use_existing" to 'false' and uncomment variables and modify them to meet your needs.)
  instance_type = {
    use_existing = false
    name         = "iks_terraform_vm"
    cpu          = 4
    memory       = 8192
    disk_size    = 30
  }

  # Organization and Tag Information
  organization = var.organization
  tags         = var.tags
}



