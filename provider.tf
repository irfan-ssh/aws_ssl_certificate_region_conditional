provider "aws" {
  alias  = "us_east_1"
  region = var.cloudfront_region
  profile = "sajjadsso"
}

provider "aws" {
  alias  = "us_west_1"
  region = var.loadbalancer_region
  profile = "sajjadsso"
}

provider "aws" {
  region = var.loadbalancer_region
  profile = "sajjadsso"
}
