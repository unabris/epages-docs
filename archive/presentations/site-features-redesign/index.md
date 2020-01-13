---
pagetitle:  Site Features redesign
author: Oleksandr Vynogradov <ovynogradov@epages.com>
date-meta:  17.11.2017
---

# Site Features Redesign

<img src="img/team-amber-logo.png" width="15%">

## Beyond Get Together. November 2017

---

# Agenda

|                                         |
| --------------------------------------- |
| Motivation                              |
| Status Quo                              |
| Updated Requirements                    |
| Redesign proposal                       |
| Delivery plan                           |

------------------

# Get away motivation
 - The implementation were mainly copied from old system

 - Supports requirements which do not exist

 - Confusing for new team members

 - Contains contradicting implementation details

------------------

# Status Quo: Requirements
 - ... were not well thought in details back then

 - Assumed, that we need to store the __historical information__ about the feature assignment

 - Feature __activation__ concept requires enhancement

 - Feature __marketing__ concept requires enhancement

# Status Quo: Implementation details

## ng-site
 - is global the __feature registry__

 - knows which __feature__ assigned to which site

 - knows how the global __feature configuration__ was overridden for a site

## ng-shop
 - duplicate all the global feature definition information

 - contains __counters__ current values

## ng-googleshopping
 - defines which features will it bring to the __feature registry__

 - interested feature supported by the service enabled for a particular tenant

------------------

# Updated Requirements

 - __historical information__ about the feature assignment will not be tracked in Beyond

 - __feature marketing__ concept will be enhanced ... someday

 - For now we only __two features__, they were enabled for __every tenant__

------------------

# Redesign proposal

 - Remove __visibility__ concept until it is refined
 - Feature __assigned__ == Feature __enabled__
 - Distinguish feature types more intelligently, use separate data structures
 - Features are managed by MATe, not the merchant, so __counter__ tracking functionality can be moved to __ng-site__
 - Make Feature API more convenient for the client

# More details

 See more details in [Features redesign proposal document](https://epages.atlassian.net/wiki/spaces/~xajuste/pages/187143647/Features+redesign+proposal)

------------------

# Delivery plan
 - Support Zero Downtime & backward compatibility is too expensive
 - Since we only __two features__,
 - They were enabled for __every tenant__
 - We can use approach: __DROP ALL, rewrite__

------------------

# Delivery & Implementation plan:
 - Update __ng-googleshopping__ to assume its feature always enabled & cleanup
 - Update __ng-checkout__ to assume its feature always enabled & cleanup
 - Update __MBO__ to assume 2 mentioned feature are enabled
 - Drop old Features related stuff from __ng-shop__, __ng-site__
 - Write Site Features from scratch
 - Enable feature validation in __ng-googleshopping__, __ng-checkout__, __MBO__

------------------

# Questions?

------------------
