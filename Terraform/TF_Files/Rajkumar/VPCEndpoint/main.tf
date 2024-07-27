resource "aws_vpc_endpoint" "default" {
  vpc_id             = "vpc-08744827561d99d91"
  vpc_endpoint_type  = "Interface"
  service_name       = "com.amazon.us-east-1.elasticache.com"
  subnet_ids         = ["subnet-0578a8f3deac90682"]
  security_group_ids = ["sg-0ddb46d962e7092a5"]
}
