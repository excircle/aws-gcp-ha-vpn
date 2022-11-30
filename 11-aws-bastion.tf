resource "aws_key_pair" "access_key" {
  key_name   = "akalaj-ln-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDzTlP/85j4EKdA8F/K4tLBhHKmTIexnT2GZKiE2BnxOvlDRU42FK81Uuw223kW3XRuyTH+SFqH9Xzvm6eCjEVezZuroi3oYi4mAQKo4+NJrZDk+72zPV8MMl7kKcSYYh8vgc7eb6aH5n5wk6ZzSRnQYTyg7TVNb/PZmQ7Sb3pA3jr5Fgrl8hPXqkIPidT/jRzEC83/n6FcXQxzY3pKOCdCB9FvWI1k4xsLWbI0Z4ud26w/M6WCVLGvcuDiv/ON+TxpcSPmubGUv5/q3z17wvA+FtZ+yTXZCpTN/sz2iOGupKUU7TgdWruao3/ZvqWm5WlfgeepIZuBeiZJ8q69b6nXSpCa5nsuM1ZFS69+KxjkgD9Kk+T9UzExl9ca40URqAAGXzDdE2bNEOWH5k9xgyRqjflNWRb2x8iyWOM+63yCsXOh8VfkNXn3esBeMjeQ/nkifMuJ+MrPG7BTVW06RRP5xvlWDiXSCrv4endSDdsuNI975gdnumYeHDQ0SL5RrxbyHoAEn7VYe6y+IEgaDqL79LXi6pxoAkvHSrqgK8+POFKk8j3W3NpMqvYEUAE89WTQ4eD4GwOXbTPxUzXvUKjRoWW1isFoVS5VwPUckk2NY2wyrtl99zYf/CR72sAlepmSQoLXGLBicjCOsV3BW6137I3A5y3qtbQ/2OsVnE+0Tw== adkalaj@gmail.com"

  tags = {
    Name     = "oanda-bastion-ssh-key"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}

resource "aws_instance" "bastion_host" {
  ami                         = "ami-071e6cafc48327ca2"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.access_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.main_vpc_sg.id]
  subnet_id                   = aws_subnet.main_subnet.id

  tags = {
    Name     = "Oanda-Bastion"
    CreateBy = "Terraform"
    Owner    = "Alexander Kalaj"
    Team     = "ISE"
  }
}
