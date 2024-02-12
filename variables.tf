# Define users
variable "users" {
  type = map(object({
    role = string
  }))
  default = {
    user1 = { role = "Contributor" }
    user2 = { role = "Reader" }
  }
}