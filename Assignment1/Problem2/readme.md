# Problem 2

Marks: 20/100

## Problem

We wish to query and update COVID-19 statistics using a GraphQL API in this problem. The example below shows a single statistic with the date, the region, and the total number of deaths, confirmed_cases, recoveries and tested cases.

```json
{
    "date"": "12/09/2021",
    "region": "Khomas",
    "deaths": 39,
    "confirmed_cases": 465,
    "recoveries": 67,
    "tested": 1200
}
```
An update changes the statistics to the latest for a given region, while a query returns the latest statistics for that region.

Your task is to write a Graphql service in the Ballerina Language to query and update the COVID-19 statistics.

## Assessment criteria

* Correct definition of the required object types. (15%)
* Correct Implementation of the service. (60%)
* Correct business logic in the API implementation. (25%)