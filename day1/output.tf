output "Resalt" {
  value = <<EOF

  #########################################################################
  #     client with autoregistration in datadog!
  #
  #   you must set your vars with comman:"terraform apply -var "key_api=..."
  #   -var "key_app=..." to correct instlalation
  #
  # !!!!!IMPORTANT: terraform include preset Monitors datadog API
  #                 and preset Log Monitor (httpd)
  #
  #               -----S.Shevtsov,2020---
  #######################################################################

!!!! Atantion: you must wait some minutes before click the link!!!

Site here: http://${google_compute_instance.default.network_interface[0].access_config[0].nat_ip}:80

interntal datadog client ip: ${google_compute_instance.default.network_interface.0.network_ip}

EOF

}
