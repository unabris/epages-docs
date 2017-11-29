---
pagetitle:  Scheduler Options
author: Jens Fischer <j.fischer@epages.com>
date-meta:  30.11.2017
---

# CoP: Scheduler Options

An introduction to the Quartz framework

---

# Our Functional Requirements

* ensure custom domains always have a valid SSL certificate
    * regularly check for approaching expiry
    * renew expiring certificates in time

---

# Our Non-Functional Requirements

* rate limit: spread renewal jobs over 24h
* don't trigger renewal jobs on each cluster node
* track renewal job state for reliability

---

# Quartz Job Scheduler

* very popular [Open Source Java library](http://www.quartz-scheduler.org/)
* Custom [Spring Boot Starter](https://github.com/andrehertwig/spring-boot-starter-quartz) available

---

# Setup

* create a set of [DB tables](https://github.com/ePages-de/ng-certificate-management/blob/master/src/main/resources/db/migration/V00003__CREATE_QUARTZ_TABLES.sql)
* add dependency to `de.chandre.quartz:spring-boot-starter-quartz`
* customize [SchedulingConfiguration](https://github.com/ePages-de/ng-certificate-management/blob/master/src/main/java/com/epages/certificatemanagement/renewal/SchedulingConfiguration.java#L47)
    * enable clustered mode
    * configure DB access
    * configure thread pool (size depends on DB conn pool)
    * create `JobDetail` for [expiry check](https://github.com/ePages-de/ng-certificate-management/blob/master/src/main/java/com/epages/certificatemanagement/renewal/CertificateRenewalSchedulingJob.java#L31)
    * create `Trigger` based on [cron expression](https://github.com/ePages-de/ng-certificate-management/blob/master/src/main/resources/application.yml#L10)

---

# Implementing `Job` interface

* extend [`QuartzJobBean`](https://github.com/spring-projects/spring-framework/blob/master/spring-context-support/src/main/java/org/springframework/scheduling/quartz/QuartzJobBean.java#L56) to allow dependency injection
    * also for runtime properties via [`JobDataMap`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobDataMap.java#L63) state
* implement `void executeInternal(JobExecutionContext)`
    * access input data via [`JobDataMap getMergedJobDataMap()`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobExecutionContext.java#L139)
    * store output data via [`void setResult(Object)`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobExecutionContext.java#L222)
    * rethrow as [`JobExecutionException`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobExecutionException.java#L38) to control unscheduling or re-firing of failed job

---

# Programmatic scheduling

* prepare [`JobDetail`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobDetail.java#L49) via [`JobBuilder`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobBuilder.java#L59)
    * [`Job`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/Job.java#L47) class for job execution
    * durability and recovery
    * key/value pairs in [`JobDataMap`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobDataMap.java#L63)
* prepare [`Trigger`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/Trigger.java#L57) via [`TriggerBuilder`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/TriggerBuilder.java#L64)
    * choose [`ScheduleBuilder`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/ScheduleBuilder.java#L22)
        * [simple](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/SimpleScheduleBuilder.java#L58), [cron](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/CronScheduleBuilder.java#L62), [calendar interval](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/CalendarIntervalScheduleBuilder.java#L59), [daily time interval](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/DailyTimeIntervalScheduleBuilder.java#L68)
    * start/end date
    * key/value pairs in [`JobDataMap`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/JobDataMap.java#L63)
* schedule execution using [`Scheduler#scheduleJob(JobDetail, Trigger)`](https://github.com/quartz-scheduler/quartz/blob/master/quartz-core/src/main/java/org/quartz/Scheduler.java#L418)
