terraform {
  required_providers {
    opensearch = {
      source = "opensearch-project/opensearch"
      version = "2.3.1"
    }
  }
}

provider "opensearch" {
  url                = "http://opensearch:9200"
  healthcheck        = false
  sign_aws_requests  = false
  opensearch_version = "2.19.0"
}

resource "opensearch_ism_policy" "hot_warm_delete" {
  policy_id = "hot_warm_delete"
  body      = file("./hot_warm_delete.json")
}
