#get instance IP
output "public_ip_address-1" {
  value = aws_eip.ip-test-env[0].public_ip
}
#get instance IP
output "public_ip_address-2" {
  value = aws_eip.ip-test-env[1].public_ip
}

resource "null_resource" "hosts_file" {
  provisioner "local-exec" {
    command = "echo '[ec2_build]\n${aws_eip.ip-test-env[0].public_ip}\n[ec2_prod]\n${aws_eip.ip-test-env[1].public_ip}' > hosts.txt"
  }
}
