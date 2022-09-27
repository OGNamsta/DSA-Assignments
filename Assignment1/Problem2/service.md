import ballerina/graphql;
import ballerina/http;
import Problem2.datastore as Datastore;
import Problem2.types as Types;

// distinct service class covidStatsService {
//     private string date;
//     private string region;
//     private int deaths;
//     private int confirmed_cases;
//     private int recovered;
//     private int tested;

//     function init(string date, string region, int deaths, int confirmed_cases, int recovered, int tested) returns error? {
//         self.date = date;
//         self.region = region;
//         self.deaths = deaths;
//         self.confirmed_cases = confirmed_cases;
//         self.recovered = recovered;
//         self.tested = tested;
//     }

//      resource function get COVID19() returns Types:COVID19[]|http:Response {
//         lock {
//             return Datastore:covid19.toArray();
//         }

//     }
//     remote function updateDate(string date) returns Types:COVID19 {
//         lock {
//             Types:COVID19 covid19 = Datastore:covid19.get(self.region);
//             covid19.date = date;
//             return covid19;
//         }

//     }
//     //remote function updateRegion(string region) returns Types:COVID19 {
//     //    lock {
//     //        Types:COVID19 covid19 = Datastore:covid19.get(region);
//     //        covid19.region = "Sri Lanka";
//     //        return covid19;
//     //    }
//     //}
//     remote function updateCases(int confirmed_cases) returns Types:COVID19 {
//         lock {
//             Types:COVID19 covid19 = Datastore:covid19.get(self.region);
//             covid19.confirmed_cases = confirmed_cases;
//             return covid19;
//         }
//     }
//     remote function updateRecovered(int recovered) returns Types:COVID19 {
//         lock {
//             Types:COVID19 covid19 = Datastore:covid19.get(self.region);
//             covid19.recovered = recovered;
//             return covid19;
//         }
//     }
//     remote function updateTests(int tested) returns Types:COVID19 {
//         lock {
//             Types:COVID19 covid19 = Datastore:covid19.get(self.region);
//             covid19.tested = tested;
//             return covid19;
//         }
//     }
// }

service /graphql on new graphql:Listener(4000) {
    private Types:covidStatsService covidStatsService;

    function init() returns error? {
        Datastore:covid19 = table[
            {date: "2021-05-01", region: "Sri Lanka", deaths: 0, confirmed_cases: 0, recovered: 0, tested: 0}
        ];
    }

    resource function get COVID19() returns Types:covidStatsService[]|http:Response {
        lock {
            return Datastore:covid19.toArray();
        }

    }

    isolated resource function get .() returns string {
        return "Visit https://ballerina.io/learn for information on Ballerina";
    }

    
}
