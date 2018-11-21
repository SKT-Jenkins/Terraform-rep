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
