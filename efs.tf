resource "aws_efs_file_system" "efs" {
   creation_token = "efs"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
 tags = {
     Name = "EFS"
   }
 }


resource "aws_efs_mount_target" "efs-mt" {
   #count = length(data.aws_availability_zones.available.names)
   file_system_id  = aws_efs_file_system.efs.id
   subnet_id = var.subnet_id1d
   security_groups = [aws_security_group.vmsg.id]
 }
