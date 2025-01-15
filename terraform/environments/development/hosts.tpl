all:
  children:
    web_servers:
      hosts:
        cloud-lab-vm:
          ansible_host: "${vm_ip}"
          ansible_user: root
          ansible_ssh_private_key_file: "~/.ssh/id_rsa"
