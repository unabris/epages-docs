---
pagetitle:  BEYOND Status Quo through the eyes of AM
author: Jens Fischer <j.fischer@epages.com>
date-meta:  20.12.2017
---

# BEYOND Status Quo

<h2>through the eyes of AM</h2>
---

## Infrastructure
* [Google Cloud Platform](https://cloud.google.com/)
    * [Compute Engine](https://cloud.google.com/compute/)
    * [Kubernetes Engine](https://cloud.google.com/kubernetes-engine/)
* dnsimple.com (<code style="font-size: 80%;">[*.epages.works](https://dnsimple.com/a/51209/domains/epages.works/records)</code> & <code style="font-size: 80%;">*.beyondshop.cloud</code>)
* MySQL ([GCP Cloud SQL](https://cloud.google.com/sql/) vs. [custom Docker image](https://github.com/ePages-de/ng-docker-images/tree/master/ng-mysql-microservices))
* RabbitMQ ([CloudAMQP](https://artistic-duckbill.rmq.cloudamqp.com) vs. [custom Docker image](https://github.com/ePages-de/ng-docker-images/tree/master/ng-rabbitmq))
* Storage ([GCP Cloud Storage](https://cloud.google.com/storage/) vs. <code style="font-size: 80%;">[emptyDir](https://github.com/ePages-de/ng-infra/blob/master/deploy/automated-gce/environments/_acceptance/manifest-overrides/product/deployments/product-elasticsearch-statefulset.override.yaml))</code>
* Outbound emailing ([Mailgun REST API](https://documentation.mailgun.com/en/latest/api_reference.html))
* ElasticSearch ([self-managed](https://github.com/ePages-de/ng-infra/blob/master/deploy/automated-gce/_template/manifests/product/deployments/product-elasticsearch-statefulset.yaml) vs. [custom Docker image](https://github.com/ePages-de/ng-docker-images/tree/master/ng-elasticsearch) )

## Central components
* [ng-cluster-gateway](https://github.com/ePages-de/ng-cluster-gateway)
    * SSL termination & [dynamic lookup](img/clustergateway-custom-ssl-certificates-010.png)
    * [ng-certificate-management](https://github.com/ePages-de/ng-certificate-management) using Let's Encrypt
    * [management.beyondshop.cloud](https://management.beyondshop.cloud/shop/system) backdoor
* [ng-config-server](https://github.com/ePages-de/ng-config-server) & [ng-config-repo](https://github.com/ePages-de/ng-config-repo)
    * global Spring Boot [application.properties](https://github.com/ePages-de/ng-infra/blob/master/deploy/automated-gce/_template/manifests/infrastructure/configs/application-properties-configMap.yaml)
* [ng-api-proxy](https://github.com/ePages-de/ng-api-proxy) & [service routing config](https://github.com/ePages-de/ng-config-repo/blob/gce/api-proxy.yml)
* [ng-auth](https://github.com/ePages-de/ng-auth)
    * [OAuth2 flows](http://build.epages.works:8080/view/Build%20master/job/core_auth_build/REST_API_Documentation/index.html#_tokens) with [JWT](https://jwt.io/)
    * [scopes](https://github.com/ePages-de/ng-auth/blob/master/src/main/resources/application.yml) and clients/roles
* example of some regular business PODs
    * <code style="font-size: 80%;">[shop-deployment.yaml](https://github.com/ePages-de/ng-shop/blob/master/src/deploy/k8s/shopadmin/deployments/shop-deployment.yaml)</code>
    * <code style="font-size: 80%;">[checkout-deployment.yaml](https://github.com/ePages-de/ng-checkout/blob/master/src/deploy/k8s/order/deployments/checkout-deployment.yaml)</code>


## Differences between stages
* Kubernetes manifests and overrides
    * Hashicorp Vault
* High level CDP process
    * jenkins-build, artifactory, hub.docker.com, jenkins-cdp
    * debug environments

## Monitoring and Logging
* Spring Boot Actuators/Health Check
* GCP [Stackdriver](https://cloud.google.com/stackdriver/) logging
* Zipkin
* Prometheus & Grafana
* kubedash and readiness
* ElasticSearch kopf plugin
* sentry.io

## Clients
* storefront
* merchant-ui
* Apps
* signup form
* MATe 3.0

## Backup and Recovery (how to guarantee data integrity)
* Restore data completely
* Restore partial data
