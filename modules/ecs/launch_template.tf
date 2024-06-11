########################################################################################################################
## Get most recent AMI for an ECS-optimized Amazon Linux 2 instance
########################################################################################################################

data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

########################################################################################################################
## Launch template for all EC2 instances that are part of the ECS cluster
########################################################################################################################

resource "aws_launch_template" "ecs_launch_template" {
  name                   = "${var.namespace}_EC2_LaunchTemplate"
  image_id               = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type          = var.instance_type
  key_name               = var.keypair# Replace with your key pair name
  user_data              = base64encode(data.template_file.user_data.rendered)
  vpc_security_group_ids = [aws_security_group.ec2.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_instance_role_profile.arn
  }

  monitoring {
    enabled = true
  }

  tags = {
    name = var.environment
  }
}


data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    ecs_cluster_name = aws_ecs_cluster.default.name
  }
}
