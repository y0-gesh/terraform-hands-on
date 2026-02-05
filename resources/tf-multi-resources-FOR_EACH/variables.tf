variable "ec2_map" {
  # key=value (object{ami, instance})
  type = map(object({
    ami           = string
    instance_type = string
  }))
}

