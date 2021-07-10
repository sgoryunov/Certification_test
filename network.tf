//network.tf
resource "aws_vpc" "test-env" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
 tags = {
   Name = "test-env"
  }
}
resource "aws_eip" "ip-test-env" {
  count = var.instances_num 
  instance = "${aws_instance.ec2-instances[count.index].id}"
  vpc      = true
  depends_on = [aws_internet_gateway.test-env-gw]
}
