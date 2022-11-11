variable "resource_group_name" {
  type    = string
  default = "sairg"
}
variable "target_region" {
  type    = string
  default = "centralindia"

}
variable "address_space" {
  type = list(string)
}
variable "virtual_network_name" {
  type = string


}
variable "linux_virtual_machine_name" {
  type = string

}
variable "address_prefixes" {
  type = list(string)
}
variable "subnet_name" {
  type = string


}