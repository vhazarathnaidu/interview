
#Define the API Gateway

resource "aws_api_gateway_rest_api" "example" {
  name        = "example-api"
  description = "Example API"
}

#Create a Resource and Method

resource "aws_api_gateway_resource" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part    = "example"
}

resource "aws_api_gateway_method" "example" {
  rest_api_id   = aws_api_gateway_rest_api.example.id
  resource_id   = aws_api_gateway_resource.example.id
  http_method   = "GET"
  authorization = "NONE"
}


#Set Up Method Throttling
resource "aws_api_gateway_method_settings" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = aws_api_gateway_stage.example.stage_name
  method_path = "example/GET"

  settings {
    throttling {
      burst_limit = 100
      rate_limit  = 50
    }
  }
}


#Create a Stage

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  stage_name  = "prod"
}

resource "aws_api_gateway_stage" "example" {
  stage_name    = "prod"
  deployment_id = aws_api_gateway_deployment.example.id
  rest_api_id   = aws_api_gateway_rest_api.example.id
  # Attach method settings for the stage
}


#Configuring Rate Limiting with Usage Plans
resource "aws_api_gateway_usage_plan" "example" {
  name        = "example-usage-plan"
  description = "Example Usage Plan"
  api_stages {
    api_id   = aws_api_gateway_rest_api.example.id
    stage    = aws_api_gateway_stage.example.stage_name
  }
  throttle {
    burst_limit = 200
    rate_limit  = 100
  }
  quota {
    limit  = 10000
    period = "MONTH"
  }
}

#Create an API Key and Associate with the Usage Plan

resource "aws_api_gateway_api_key" "example" {
  name        = "example-api-key"
  description = "Example API Key"
  enabled     = true
}

resource "aws_api_gateway_usage_plan_key" "example" {
  usage_plan_id = aws_api_gateway_usage_plan.example.id
  key_id         = aws_api_gateway_api_key.example.id
  key_type       = "API_KEY"
}







