locals {
  vm_name = var.vm_name
}

resource "aws_instance" "vm" {
   depends_on = [aws_efs_file_system.efs]
   count = 2
   ami = data.aws_ami.ubuntu.id
   instance_type = var.instance_type
   key_name = var.key_name
   subnet_id = var.subnet_id1d
   security_groups = [aws_security_group.vmsg.id]
   #security_groups = [var.sg_id]
   #user_data = data.template_file.user_data.rendered
   user_data = <<EOF
mkdir /efs
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport "${aws_efs_file_system.efs.dns_name}":/ /efs
echo "${aws_efs_file_system.efs.dns_name}:/ /efs nfs4 defaults,_netdev 0 0" >> /etc/fstab
   EOF
   
   associate_public_ip_address = false

root_block_device {
   volume_type = "standard"
   volume_size = 100
   delete_on_termination = "false"
 }

tags = {
   Name = "${local.vm_name}${count.index + 1}"
 }
}

