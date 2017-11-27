---
pagetitle:  Introduction meeting for MATe 3.0
author: Mats Andresen <m.andresen@epages.com>
date-meta:  27.11.2017
---

# Introduction meeting for MATe 3.0

## Purpose of MATe 3.0

* Create and manage shops
* Manage features assigned to shops
* Manage site attributes of shops

## Capabilities of MATe 3.0

* Search for shops
* List shops
* Filter shops
* Apply changes to one or multiple shops

------------------

# Shop vs Site

## Concept
In Beyond context we differenciate between a _Site_ and a _Shop_

## Site
* A __Site__ is a shop from the perspective of a _reseller_
* Holds properties that are configured by the _reseller_

__Example properties__:

* available feature set (e.g. `paypal-express: true`, `google-shopping: false`, `max-products: 100`)
* site level attributes (e.g. `isDeveloperShop`, `isClosed`)

## Shop
* A __Shop__ is a shop from the perspective of a _merchant_
* Holds properties that are configured by the _merchant_

__Example properties__:

* shop level attributes (e.g. `title`, `slogan`, `isClosedByMerchant`)

------------------

# Tenancy Concept

## Definition
> A __Tenant__ is a group of users who share a common access with specific privileges to the beyond instance. The main characteristic of a tenant is the __data isolation__ - a tenant does only see his own data.

## Different levels of tenancy in beyond
* A __system__ tenant is able to access data of the entire system
* A __merchant__ tenant is only able to access data belonging to his shop
* MATe 3.0 will require __system__ level tenancy in order to operate on site level

## How a tenant is resolved
* Each access token carries a `tenantId` to determine it's scope
* The hostname is a unique identifier for a specific tenant
* The hostname is translated to the `tenantId` internally

## Example

requesting
```
GET http://xavizon.beyondshop.cloud/api/categories
```
will translate __xavizon.beyondshop.cloud__ to a specific __tenantId__ and only show the data subset assosiated with this particular tenantId, in this case the categories of this shop


------------------

# Public Api vs. Private Api

## Concept

Some parts of our Api are for _internal_ purpose one. For instance managing shops and their respective feature set.

## What is the correct version of Api docs?
* Api Documentation is _generated from our integration-tests_
* On _each build_ we run those integration tests
* _Latest build docs will always be up to date_ with the latest changes

## Where to find?
* On [docs.beyondshop.cloud](http://docs.beyondshop.cloud) you will only find the __public__ part of our Api documented.
* On our [build jenkins](http://build.epages.works:8080/) you will find the latest version of documnetation for each microservice, those also contain __private__ parts of our Api.
* [Docs of ng-auth](http://build.epages.works:8080/job/core_auth_build/REST_API_Documentation/)
* [Docs of ng-provisioning](http://build.epages.works:8080/job/shopadmin_provisioning_build/REST_API_Documentation/)
* [Docs of ng-site](http://build.epages.works:8080/job/shopadmin_site_build/REST_API_Documentation/)

------------------

# Shop Creation

## Status Quo
* Provisioning of new shops is sole reposibility of [ng-provisioning](https://github.com/epages-de/ng-provisioning) microservice
* Right now the [ng-signup](https://github.com/epages-de/ng-signup) is used to trigger the shop provisioning
* ng-signup should be replaced by MATe 3.0

## Concept
![](img/shop-provisioning-concept.png)

------------------

# Provisioning Service

## Characteristics of ng-provisioning
* Accepts _JSON_ payload with all initial shop data
* Orchestrates the creation by exeucting subsequent steps
* Is of __asynchronous__ nature
* Is part of __private API__

## How to use ng-provisioning
* [Api Docuemtnation](http://build.epages.works:8080/job/shopadmin_provisioning_build/REST_API_Documentation/) describes its API
* Submit JSON payload of the shop you would like to create to
```
POST /provisionings
```
* Monitor the status of you provisioning with
```
GET /provisionings/{provisioningId}
```

## Different Status of shop provisioning
* `STARTED` - means provisioning proccess is still ongoing
* `COMPLETED` - means provisioning has been successful and shop is __ready to use__
* `FAILED` - mean provisioning failed during execution and shop is __not ready to use__

## Restarting a failed shop provisioning

With [EPNG-2079](https://epages.atlassian.net/browse/EPNG-2079) there will be the opportunity to restart failed provisionings.

```
// Restart a previously failed provisioning
POST /provisonings/{provisioningId}/restart
```

------------------

# Features

* Management of features is currently in process to be re-worked
* Introduction will follow with one of our upcoming sprint reviews