resource "null_resource" "ARESWebserver2HTTPD" {
 depends_on = [oci_core_instance.ARESWebserver2]
 provisioner "remote-exec" {
        connection {
                type     = "ssh"
                user     = "opc"
		        host     = data.oci_core_vnic.ARESWebserver2_VNIC1.public_ip_address
                private_key = file(var.private_key_oci)
                script_path = "/home/opc/myssh.sh"
                agent = false
                timeout = "10m"
        }
  inline = ["echo '== 1. Installing HTTPD package with yum'",
            "sudo -u root yum -y -q install httpd",

            "echo '== 2. Creating /var/www/html/index.html'",
            "sudo -u root touch /var/www/html/index.html", 
            "sudo /bin/su -c \"echo 'Welcome to ARES.com! This is WEBSERVER2...' > /var/www/html/index.html\"",

            "echo '== 3. Disabling firewall and starting HTTPD service'",
            "sudo -u root service firewalld stop",
            "sudo -u root service httpd start"]
  }
}
