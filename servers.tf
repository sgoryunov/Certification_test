//servers.tf
resource "aws_key_pair" "my-key" {
  key_name   = "devops_key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "ec2-instances" {
  iam_instance_profile = var.iam_profile_name
  count = var.instances_num
  ami           = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my-key.key_name
  user_data = "${file("installations.sh")}"

  security_groups = ["${aws_security_group.ingress-all-test.id}"]
  associate_public_ip_address = true
  tags = {
    Name = "devops-${count.index + 1}"
  }
  subnet_id = "${aws_subnet.subnet-uno.id}"
  depends_on = [aws_vpc.test-env, aws_internet_gateway.test-env-gw ]
}
