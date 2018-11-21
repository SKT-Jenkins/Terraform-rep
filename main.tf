resource "azurerm_resource_group" "stripathi_rg" {
  name = "M-${var.short_location}-${var.environment}-COMP-APP-STRIPATHI-RG"
  location = ${var.location}"
  
  tags {
    troux_id = "PE"
    resource_owner = "Sanjay Tripathi"
    cost_center = "123"
    Res_expiry_date = "2023-03-02"
    build_tag = "${var.build_tag}"
    git_url = "${var.build_tag}"
    git_commit_hash = "${var.build_tag}"
  }
}

module "stripathi_windows_server" {
  source = "git@github.com:SKT-Jenkins/Terraform-rep.git//az-compute/windows?ref=master"
  environment = "${var.environment}"
  subnet_id =
  resource_group =
  user_password =
  size =
  count =
  index_offset = app_id = 
  machine_image_rg 

# add tags here
}

module "stripathi_linux_server" {
  source = "git@github.com:SKT-Jenkins/Terraform-rep.git//az-compute/rhel?ref=master"
  environment = "${var.environment}"
  subnet_id =
  resource_group =
  user_password =
  size =
  count =
  index_offset = app_id = 
  machine_image_rg 

# add tags here
}