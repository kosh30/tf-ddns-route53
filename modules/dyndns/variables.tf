variable "domain_data" {
  type = object({
    domain            = string
    create_r53_zone   = optional(bool, false) // Create a new Route53 zone
    api_domain_prefix = optional(string, "ddns")
  })
  description = "The domain data to be used for the dynamic DNS update"
}
variable "domain_secrets" {
  type = object({
    username = optional(string, "ddns")
    password = optional(string, "")
  })
  sensitive   = true
  description = "The domain secrets to be used for the dynamic DNS update"
}
