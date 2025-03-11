variable "domain_data" {
  type = object({
    domain       = string
    username     = string
    password     = string
    create_zone  = optional(bool, false)
    private_zone = optional(bool, false)
  })
  sensitive   = true
  description = "The domain data to be used for the dynamic DNS update"
}
