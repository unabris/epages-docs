---
pagetitle:  BEYOND Status Quo through the eyes of AM
author: Jens Fischer <j.fischer@epages.com>
date-meta:  20.12.2017
---

# BEYOND Status Quo

<h2>through the eyes of AM</h2>

---

# Infrastructure

* [Google Cloud Platform](https://cloud.google.com/)
    * [Compute Engine](https://cloud.google.com/compute/), [Kubernetes Engine](https://cloud.google.com/kubernetes-engine/)
* dnsimple.com (<code style="font-size: 80%;">[*.epages.works](https://dnsimple.com/a/51209/domains/epages.works/records)</code> & <code style="font-size: 80%;">*.beyondshop.cloud</code>)
* MySQL ([GCP Cloud SQL](https://cloud.google.com/sql/) vs. [custom Docker image](https://github.com/ePages-de/ng-docker-images/tree/master/ng-mysql-microservices))
* RabbitMQ ([CloudAMQP](https://artistic-duckbill.rmq.cloudamqp.com) vs. [custom Docker image](https://github.com/ePages-de/ng-docker-images/tree/master/ng-rabbitmq))
* Storage ([GCP Cloud Storage](https://cloud.google.com/storage/) vs. <code style="font-size: 80%;">[emptyDir](https://github.com/ePages-de/ng-infra/blob/master/deploy/automated-gce/environments/_acceptance/manifest-overrides/product/deployments/product-elasticsearch-statefulset.override.yaml))</code>
* Outbound emailing ([Mailgun REST API](https://documentation.mailgun.com/en/latest/api_reference.html))
* ElasticSearch ([self-managed](https://github.com/ePages-de/ng-infra/blob/master/deploy/automated-gce/_template/manifests/product/deployments/product-elasticsearch-statefulset.yaml) vs. [custom Docker image](https://github.com/ePages-de/ng-docker-images/tree/master/ng-elasticsearch) )

---

# Central components

* [ng-cluster-gateway](https://github.com/ePages-de/ng-cluster-gateway)
    * SSL termination & [dynamic certificate lookup](img/clustergateway-custom-ssl-certificates-010.png)
    * [ng-certificate-management](https://github.com/ePages-de/ng-certificate-management) using Let's Encrypt
    * [management.beyondshop.cloud](https://management.beyondshop.cloud/shop/system) backdoor
* [ng-config-server](https://github.com/ePages-de/ng-config-server) & [ng-config-repo](https://github.com/ePages-de/ng-config-repo)
    * global Spring Boot [application.properties](https://github.com/ePages-de/ng-infra/blob/master/deploy/automated-gce/_template/manifests/infrastructure/configs/application-properties-configMap.yaml)
* [ng-api-proxy](https://github.com/ePages-de/ng-api-proxy) & [service routing config](https://github.com/ePages-de/ng-config-repo/blob/gce/api-proxy.yml)
* [ng-auth](https://github.com/ePages-de/ng-auth)
    * [OAuth2 flows](http://build.epages.works:8080/view/Build%20master/job/core_auth_build/REST_API_Documentation/index.html#_tokens) with [JWT](https://jwt.io/)
    * [scopes](https://github.com/ePages-de/ng-auth/blob/master/src/main/resources/application.yml) and clients/roles
* example of some regular business PODs
    * <code style="font-size: 80%;">[shop-deployment.yaml](https://github.com/ePages-de/ng-shop/blob/master/src/deploy/k8s/shopadmin/deployments/shop-deployment.yaml)</code>, <code style="font-size: 80%;">[checkout-deployment.yaml](https://github.com/ePages-de/ng-checkout/blob/master/src/deploy/k8s/order/deployments/checkout-deployment.yaml)</code>

---

# Differences between stages
* **prod**, **preprod**, **acceptance**, **debug**
* Kubernetes manifests and overrides
    * Hashicorp Vault
* High level CDP process
    * [jenkins-build](http://build.epages.works:8080/view/Build%20pull%20requests/), [Artifactory](https://epagesbeyond.jfrog.io/epagesbeyond/webapp/#/home), [Docker Hub](https://hub.docker.com/u/epages/dashboard/), [jenkins-cdp](https://cdp.epages.works/job/cdp/)
    * debug environments

---

# Monitoring and Logging
* Spring Boot [Actuators](https://management.beyondshop.cloud/shop/system)
    * [/info](https://management.beyondshop.cloud/shop/system/info), [/health](https://management.beyondshop.cloud/shop/system/health)
    * [/env](https://management.beyondshop.cloud/shop/system/env), [/configprops](https://management.beyondshop.cloud/shop/system/configprops)
    * [/metrics](https://management.beyondshop.cloud/shop/system/metrics), [/trace](https://management.beyondshop.cloud/shop/system/trace)
* GCP [Stackdriver](https://cloud.google.com/stackdriver/) logging
    * [beyond-live](https://console.cloud.google.com/logs/viewer?project=beyond-live&minLogLevel=200&expandAll=false&resource=container%2Fcluster_name%2Fbeyondshop-cloud%2Fnamespace_id%2Fdefault&advancedFilter=resource.type%3D%22container%22%0Aresource.labels.cluster_name%3D%22beyondshop-cloud%22%0Aresource.labels.namespace_id%3D%22default%22&interval=PT1H), [ePages-NG](https://console.cloud.google.com/logs/viewer?project=epages-ng&minLogLevel=0&expandAll=false&interval=PT1H&resource=container%2Fcluster_name%2Fpreprod%2Fnamespace_id%2Fdefault&advancedFilter=resource.type%3D%22container%22%0Aresource.labels.cluster_name%3D%22preprod%22%0Aresource.labels.namespace_id%3D%22default%22)
* [Zipkin](https://zipkin.beyondshop.cloud/)
* [Prometheus](https://prometheus.beyondshop.cloud/) & [Grafana](https://grafana.beyondshop.cloud/?orgId=1)
* kubedash ([prod](https://kubedash-prod.epages.works/#), [preprod](https://kubedash-preprod.epages.works/#))
* readiness ([prod](https://readiness-prod.epages.works/readiness.html?refresh=60))
* ElasticSearch [kopf plugin](https://management.beyondshop.cloud/product-elasticsearch/_plugin/kopf/#!/cluster)
* [sentry.io](https://sentry.io/epages/byd-prod/)

---

# Clients
* Storefront ([ng branch](https://github.com/ePages-de/epages-ui/tree/ng))
* [Cockpit](https://github.com/ePages-de/ng-merchant-ui)
* Apps, e.g. eSiteKic
* [signup form](https://signup.beyondshop.cloud)
* [MATe 3.0](https://github.com/ePages-de/mate)

---

# Backup and Recovery (how to guarantee data integrity)
* Restore data completely
* Restore partial data
