---
title: Upload a Resource to a FHIR Server
author: ~
date: '2019-05-02'
slug: upload-a-resource-to-a-fhir-server
categories:
  - FHIR
  - HL7
  - Interoperability
tags:
  - FHIR
  - HL7
  - Interoperability
---

# Upload a Resource to a FHIR Server

In earlier posts I presented FHIR resources by uploading them to FHIR servers.
This post will explain how the process of uploading a FHIR resource works with postman.
In this context the correct terminology is post a resource rather than uploading since we are dealing with a RESTful API.


In this specific example I will show how to post a ValueSet I created to capture the location of a ulcer according to the "National Konsensus zur Dokumentation des Ulcus Cruris" which is a German specification of how to document and communicate the presence of foot ulcer (Ulcus Cruris). 
I used SNOMED CT codes to encode the location but since Germany is not a member of IHTSDO, the standard developing organization (SDO) of SNOMED, I only present the ValueSet without actually implementing it (A country can get a SNOMED CT licence when an national governmental agency is a member of IHTSDO).

# 6 Steps Posting the Resource

I created a ValueSet in [Snapper](http://ontoserver.csiro.au/snapper2-dev/index.html#/), an open source tool to create CodeSystems and ValueSets.

1. Get the base URL of the FHIR server we want to post the resource - `http://fhirtest.uhn.ca/baseDstu3`
2. Define the resource type and extend the base URL - `ValueSet`
3. Open a new request in Postman and change the RESTful operation to `POST`
4. Select `body` and copy the resource into the textfield below
5. Push `send`
6. If the post operation was successful the status of the operation will be `201 created`

# The final ValueSet

After the post operation postman will show you FHIR resource in the window below. 
Right there you find the `id` attribute of this ValueSet instance.
You can use this `id` to retrieve the posted resource with a GET operation.
This operation can be done using Postman or just a browser were you simply paste in the base URL, resource type and the id.

[http://fhirtest.uhn.ca/baseDstu3/ValueSet/1896831](http://fhirtest.uhn.ca/baseDstu3/ValueSet/1896831)



