terraform {
  backend "s3" {
    bucket         = "romia-project"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}