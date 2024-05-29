# Create an Auto-Scaling Group to create instances that will scale based on traffic.

resource "aws_autoscaling_group" "asg_app" {
  name               = "Python-App-ASG"

  desired_capacity   = 2
  min_size           = 1
  max_size           = 3

  launch_template {
    id      = aws_launch_template.lt_app.id
    version = aws_launch_template.lt_app.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      auto_rollback = "true"
    }
  }

  target_group_arns = [ aws_lb_target_group.tg_app.arn ]

  vpc_zone_identifier  = [aws_subnet.prod-pvt-sub-1.id, aws_subnet.prod-pvt-sub-2.id]

    tag {
    key                 = "Name"
    value               = "ASG-Instance"
    propagate_at_launch = true
  }
}