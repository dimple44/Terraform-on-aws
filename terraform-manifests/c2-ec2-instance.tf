# resource :ec2 instance
resource "aws_instance" "awsec2Demo" {
    ami = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    user_data = file("${path.module}/bash-script.sh")
    tags = {
      "Name" = "ec2-demo"
    }
}
