#!/bin/bash
sudo mkdir -p /tmp/startup
echo "${name}-${surname}-${ext_ip}-${int_ip}"
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo setenforce 0

DD_AGENT_MAJOR_VERSION=7 DD_API_KEY=${key_api} DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
sudo sed -e 's/# logs_enabled: false/logs_enabled: true/' -i /etc/datadog-agent/datadog.yaml
sudo systemctl restart datadog-agent

sudo yum install -y httpd
cat > /var/www/html/index.html << EOF
Hello from Sergei Shevtsov!!!
EOF

sudo systemctl start httpd
sudo systemctl enable httpd
chmod 777 /etc/httpd/logs
chmod 777 /etc/httpd/logs/access_log
sudo mkdir -p /etc/datadog-agent/conf.d/httpd.d
cat > /etc/datadog-agent/conf.d/httpd.d/conf.yaml << EOF
#Log section
logs:

    # - type : (mandatory) type of log input source (tcp / udp / file)
    #   port / path : (mandatory) Set port if type is tcp or udp. Set path if type is file
    #   service : (mandatory) name of the service owning the log
    #   source : (mandatory) attribute that defines which integration is sending the log
    #   sourcecategory : (optional) Multiple value attribute. Can be used to refine the source attribute
    #   tags: (optional) add tags to each log collected

  - type: file
    path: /etc/httpd/logs/access_log
    source: httpd
    service: httpd
EOF

sudo yum install -y java-1.8.0-openjdk-devel
sudo mkdir -p /opt/tomcat
cd /opt/tomcat/
sudo yum install -y wget
sudo wget https://mirror.datacenter.by/pub/apache.org/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz
sudo tar -zxvf apache-tomcat-8.5.57.tar.gz
#sudo chown -R tomcat:tomcat /opt/tomcat/*
sudo /opt/tomcat/apache-tomcat-8.5.57/bin/startup.sh

chmod 777 /opt/tomcat/apache-tomcat-8.5.57/logs
chmod 777 /opt/tomcat/apache-tomcat-8.5.57/logs/*

cat > /etc/datadog-agent/conf.d/tomcat.d/conf.yam << EOF
logs:

    # - type : (mandatory) type of log input source (tcp / udp / file)
    #   port / path : (mandatory) Set port if type is tcp or udp. Set path if type is file
    #   service : (mandatory) name of the service owning the log
    #   source : (mandatory) attribute that defines which integration is sending the log
    #   sourcecategory : (optional) Multiple value attribute. Can be used to refine the source attribute
    #   tags: (optional) add tags to each log collected

  - type: file
    path: /opt/tomcat/apache-tomcat-8.5.57/logs/*.log
    source: tomcat
    service: myapp
EOF

cat > /etc/datadog-agent/conf.d/http_check.d/conf.yaml << EOF
instances:
  - name: my_site
    url: http://${int_ip}
EOF

sudo systemctl restart datadog-agent

sudo touch /opt/tomcat/apache-tomcat-8.5.57/webapps/my.war

#
