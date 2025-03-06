locals {

    metadata = {
        serial-port-enable = 1,
        ssh-keys           = "ansible:${file("~/.ssh/id_ed25519.pub")}"
    }
}