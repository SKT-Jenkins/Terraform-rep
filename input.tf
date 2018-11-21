variable "client_id" {
    default = "<azure client id>"
}

variable "tenant_id" {
    type = "string"
    default = "<azure tenant id>"
}

variable "subscription_id" {
    type = "string"
    default = "<azure tenant id>"
}

variable "infoblox_username" {
    type = "string"
}

variable "infoblox_password" {
    type = "string"
}

variable "linux_machine_image" {
    type = "string"
    default = "<machine image name>"
}

variable "windows_machine_image" {
    type = "string"
    default = "<machine image name>"
}

# dynamic tags

variable "build_tag" {
    default = ""
    description = "Jenkins build id"
}

variable "build_user" {
    default = ""
    description = "the user started Jenkins job"
}

variable "git_url" {
    default = ""
    description = "git url"
}

variable "git_commit_hash" {
    default = ""
    description = "git commit id"
}