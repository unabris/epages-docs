---
title: "Sprint Review #46 | Team 42"
theme: css/team42.css
css: css/styles.css
scripts:
  - js/chart.min.js
  - js/chartjs_plugin_datalabels.min.js
  - js/utils.js
  - js/github_statistics.js
revealOptions:
  transition: slide
  slideNumber: false

# Configuration options: https://github.com/hakimel/reveal.js#configuration
---

![Team 42 Logo](img/team42-logo.png#main-logo)

### Review #46

_"Leftovers"_

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

## Agenda

|                        |
| ---------------------- |
| ePages Devportal       |
| Beyond Canvas          |
| CSV Import App         |
| Beyond Api Ruby Client |
| Shippo Connector App   |
| Krypton                |
| Misc. tasks            |
| Next Steps             |

---

## GitHub Statistics

<div class="container">
  <canvas id="chart"></canvas>
</div>

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# ePages Devportal

---

## Create sitemap.xml

<section>

</section>

---

## Add anchors to sidebar elements

<section>

  Poner ids para poder enviar los links a la gente

</section>

---

## Identify required cookies

<section>

</section>

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# Beyond Canvas

---

## Add gem installer

<section>

</section>

---

## Add custom style generator

<section>

</section>

---

## Other tasks

<section>

* Fix `.slim` files breaking the gem
* Fix requiting to create the `_head.html.*` on the project instead of using the gem's one

</section>

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# CSV Import Apps

---

## Create product validation page

<section>

[![marvin](img/demo.png)](https://epages.atlassian.net/wiki/x/IIASU?atlOrigin=eyJwIjoiYyIsImkiOiI1NDgyNzczRkUxMzU0QzQ0OEVDQzVGNjNGQTNDMjExQiJ9)

</section>

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# Beyond Api Ruby Client

---

## Automatically upload gem documentation to Rubydoc

<section>

[![marvin](img/demo.png)](https://rubydoc.info/github/ePages-de/beyond_api-ruby_client)

</section>

---

## Other tasks

<section>

* Add new endpoints
* Remove depredated endpoints
* Update outdated yard documentation

</section>

---


<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# Shippo Connector App

---

## Enhance Sign up page

<section>

* Add keys for registration steps

</section>

<section>

<!-- TODO: Update link -->
[![marvin](img/demo.png)](https://shippoconnector.apps.beyondshop.cloud/shops/new?access_token_url=https://team42.beyondshop.cloud/api/oauth/token&api_url=https://team42.beyondshop.cloud/api&code=ALGTqQ&return_url=https://team42.beyondshop.cloud/cockpit/apps/custom-apps/edit/1f0c62ea-ef09-40fd-8980-7bd16128a3b8&signature=KAc4OtY99OgwwBByKRA29Oht1NI%3D)

</section>

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# Krypton

---

## Display scopes on app detail page

<section>

<!-- TODO: Put production link -->
[![marvin](img/demo.png)](https://staging.admin.beyondshop.cloud/official_apps/52ad7985-4dba-4828-82ed-060f984ee7b6/edit)

</section>

---

## Allow a user to manage multiple resellers

<section>

[![marvin](img/demo.png)](https://staging.admin.beyondshop.cloud/users/ed5d7130-c85c-425d-9518-1025c1d5bba0/edit)

</section>

---

## Create a rake task to remove features/apps from shops

<section>

<!-- TODO: Prepare example  -->
[![marvin](img/demo.png)](https://staging.admin.beyondshop.cloud/official_apps/52ad7985-4dba-4828-82ed-060f984ee7b6/edit)

</section>

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# Misc. tasks

---

## Configure all projects

<section>

### VSCode

* Default editor configuration
* Recommended extensions
* VSCode tasks
* Debugger configuration

</section>

<section>

### Linters

* ESLint
* SassLint

</section>

<section>

#### Others

* Run ESLint and SassLint on pre-commit

</section>

---

### Other tasks

<section>

* Remove obsolete scopes from existing apps
* Move team's slides to reveal-md (markdown)

</section>

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# Questions?

---

<!-- .slide: data-background="./img/team42-logo.png" data-background-size="1300px" -->

# Next Steps

---

## Next Steps

|                                                            |
| ---------------------------------------------------------- |
| Refactor CSV Import app                                    |
| Display app data from feature-definitions call in app list |

---

![marvin](img/dont_panic.png)
