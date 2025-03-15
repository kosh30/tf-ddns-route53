variable "domain_data" {
  type = object({
    domain            = string
    username          = string
    password          = string
    create_r53_zone   = optional(bool, false) // Create a new Route53 zone
    api_domain_prefix = optional(string, "ddns")
  })
  sensitive   = true
  description = "The domain data to be used for the dynamic DNS update"
}
