variable "vpc_config" {
  description = "to get the CIDR and Name from user"
  type = object({
    cidr_block = string
    name       = string
  })
  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR FORMAT - ${var.vpc_config.cidr_block}"
  }
}


variable "subnet_config" {
  # sub1={cidr= .. az..} sub2={} sub3={}
  description = "Get the CIDR and AZ for the subnets"
  type = map(object({
    cidr_block = string
    az         = string
    public     = optional(bool, false)
  }))
  #   sub1={cidr=} sub2={cidr=..} sub3={cidr=..}
  validation {
    condition     = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR FORMAT"
  }
}
