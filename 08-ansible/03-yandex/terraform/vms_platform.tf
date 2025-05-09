variable "vm_image" {
  type        = string
  default     = "centos-stream-9-oslogin" # image_id: fd8ngppj050309pd6tpi
  description = "Image VM for platform" 
}

variable "vm_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform VM for platforms"
}

variable "each_vm" {
  type = list(object({
    vm_name=string, 
    cpu=number, 
    ram=number, 
    disk_volume=number, 
    core_fraction=number 
  }))
}