terraform {
  backend "s3" {
    bucket   = "tf_store"
    #key      = "jenkins/terraform.tfstate"
    region   = "eu-marseille-1"
    endpoint = "https://frrudica1wgd.compat.objectstorage.eu-marseille-1.oraclecloud.com"
    #shared_credentials_file     = "keys/terraform-states_bucket_credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}