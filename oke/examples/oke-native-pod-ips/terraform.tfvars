user_ocid        = "ocid1.user.oc1..aaaaaaaafw7n6bqzqryemcgpxyy4flqchjdryoxfd4qjdgfg73ii26xumtoq"
tenancy_ocid     = "ocid1.tenancy.oc1..aaaaaaaahi5muhofjve5u2j3lyoecq4frsrciabm6y6mh5fnbvza7g4ht4ga"
tenancy_id       = "ocid1.tenancy.oc1..aaaaaaaahi5muhofjve5u2j3lyoecq4frsrciabm6y6mh5fnbvza7g4ht4ga"
compartment_ocid = "ocid1.compartment.oc1..aaaaaaaa2qa746lixx45yxqxzdqlsgdtl2bfkkip3bqbzhbbkcnuzhvee5rq"
fingerprint      = "3d:2a:c9:64:df:fa:9c:7d:fb:82:64:31:72:7b:04:5d"
private_key_path = "/root/.oci/oke-nirmata.pem"
region           = "us-phoenix-1"
token            = "DsmghHJ13w8sxjAtkK2Pp9taNQROJRjCzzc7L/osaewvQpFuJ7tjP2euNlvSKXaIXZc9lA7w6fYQZdxET8clZA=="
kms_key_id       = "ocid1.key.oc1.phx.bzsall64aabdy.abyhqljt4qhincla4m2rguxtdnrer4e6yho2fkcuzr5uxyhbawurp27xrzha"
#ssh_public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQFo0LiKY+N0RkUl/CJ7283LAO7ZuZOg7ejv6egJlztasSEZwSmyzqkSjjot4SnCxz7suyOXgN0Qy2NfUSy13E/m7vrMTt3xAHqpawZmrXHxinvIpHMv+oLFL/WMLi8115wBGHH0PPfLdojJATi4aCdpQjSgqggCzsxFMDqBvjmWQwo8Dwy0AkeQil+6MJwFyL6su7UzD44xJwRGgHgtdJW89ef7lv+hGJAXF7NzvnBOrEGV1OERcj7EgdNdLiaBGvN6DPd7bAZAMucZPXpsyikAqft2DAlBJwb3zRjGUxjCS/lkt3AYk+6+ZM+26c38OciUHoIkWL298DJ7U0L8Ht"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDi6x79STNVzFHgFZi97XU9xu6PSju12uUjPd2CiL/lrJE4AcyB9dBGmoX3jeTsylotmipG+ieO4oxNOFNtAYuf4DpN0u3ienZByhAAqHMCfh2gqpSbbQsasD88EV8/mbTTzc1PfH9H9k32sL3cXWmE4sZZWXU9EbQkq24GWFvIJfs1VL2cg/R6bZRKdfMDec1yGTB29k/lZpiiQgeAWfG4bRVe+wubNgBktCqAbI5GaVD1fRzVA1VmcGbwDuink7WIWM66MK38Wfocg3Uj6/y6GMA/0w9K7whfD0xq283XcMfMqG6mG3T5i37z2t01/MtrwrhNAePBtQpR5FqivQFT"
label_prefix   = "dev"

#private-vcn-networks
vcn_ocid                     = "ocid1.vcn.oc1.phx.amaaaaaasuvunkaajcswntcx3wfexcojiz5bu3jlkeemuyf6ptr3gwtrujda"
my_api_endpoint_subnet_ocid  = "ocid1.subnet.oc1.phx.aaaaaaaahjvcikdfp2uizw3ctmjotzlc36r6sviuyl7snimfc4umfbzaf7mq"
my_pods_nodepool_subnet_ocid = "ocid1.subnet.oc1.phx.aaaaaaaava2yzipybfpvc6namb775wdnuwil3qomyrhwvtuew7kmzjlzqjua"
pods_subnet_ocid             = "ocid1.subnet.oc1.phx.aaaaaaaajmlslaxxlngoo432qvm46fnpvhrfc7tbr3nflhxihspowmavwn6q"

max_number_of_nodes = "3"
min_number_of_nodes = "2"


#nodepool count
#node_pool_size_np1 = "1"
#node_pool_size_np2 = "1"
#node_pool_size_np3 = "1"

np_k8s_version = "v1.25.4"
node_image_id  = "ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq"

node_pools = {
  # Basic node pool
  np1 = {
    #np_k8s_version          = "v1.26.2"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaayfy55o4cipfj4z6kmiys3jep4zcae5js5mks5cb2wfvjfneieuwq"
    #np_k8s_version          = "v1.25.4"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq"
    np_k8s_version          = "v1.24.1"
    node_image_id           = "ocid1.image.oc1.phx.aaaaaaaafhnymeqt5q3437wiuckekjodt3funyfz6hxuanchpfoqzq6nhxrq"
    shape                   = "VM.Standard.E4.Flex",
    ocpus                   = 3,
    memory                  = 5,
    node_pool_size          = 1,
    boot_volume_size        = 150,
    eviction_grace_duration = 0, //Grade duration in minutes. Service default is 60.
    force_node_delete       = true
  }
  # node pool with initial node labels
  np2 = {
    #np_k8s_version          = "v1.26.2"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaayfy55o4cipfj4z6kmiys3jep4zcae5js5mks5cb2wfvjfneieuwq"
    #np_k8s_version          = "v1.25.4"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq"
    np_k8s_version          = "v1.24.1"
    node_image_id           = "ocid1.image.oc1.phx.aaaaaaaafhnymeqt5q3437wiuckekjodt3funyfz6hxuanchpfoqzq6nhxrq"
    shape                   = "VM.Standard.E4.Flex",
    ocpus                   = 3,
    memory                  = 5,
    node_pool_size          = 1,
    boot_volume_size        = 150,
    label                   = { app = "frontend", pool = "np2" },
  }
  # node pool with freeform tags
  np3 = {
    #np_k8s_version          = "v1.26.2"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaayfy55o4cipfj4z6kmiys3jep4zcae5js5mks5cb2wfvjfneieuwq"
    #np_k8s_version          = "v1.25.4"
    #node_image_id           = "ocid1.image.oc1.phx.aaaaaaaas3s5ziwx2mvrrz6juwzqfck7u4m2sfgsiijp6qxh6ni4vasu5peq"
    np_k8s_version          = "v1.24.1"
    node_image_id           = "ocid1.image.oc1.phx.aaaaaaaafhnymeqt5q3437wiuckekjodt3funyfz6hxuanchpfoqzq6nhxrq"
    shape                   = "VM.Standard.E4.Flex",
    ocpus                   = 3,
    memory                  = 5,
    node_pool_size          = 1,
    boot_volume_size        = 150,
    nodepool_freeform_tags  = { app = "frontend", pool = "np3" },
    node_freeform_tags      = { app = "frontend", nodes = "np3" },
  }
}


cluster_name_key   = "cluster-name"
cluster_name_value = "dev-test"
cluster_role_key   = "role"
cluster_role_value = "control-plane"
cluster_env_key    = "cluster-environment"
cluster_env_value  = "dev"

#check_node_active = "all"
# upgrade of existing node pools
#upgrade_nodepool        = false
#node_pools_to_drain     = ["np1", "np2", "np3"]
#nodepool_upgrade_method = "out_of_place"

# service account
#create_service_account               = false
#service_account_name                 = ""
#service_account_namespace            = ""
#service_account_cluster_role_binding = ""

#debug_mode = false
