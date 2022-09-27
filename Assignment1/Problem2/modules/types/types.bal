public type covidStat record {|
    // string name;
    readonly string region;
    string date;
    int deaths;
    int confirmed_cases;
    int recoveries;
    int tested;
    |};
// public service class covidStatsService {
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

     
//     remote function updateDate(string date) returns Types:COVID19 {
//         lock {
//             Types:COVID19 covid19 = Datastore:covid19.get(self.region);
//             covid19.date = date;
//             return covid19;
//         }

//     }
    //remote function updateRegion(string region) returns Types:COVID19 {
    //    lock {
    //        Types:COVID19 covid19 = Datastore:covid19.get(region);
    //        covid19.region = "Sri Lanka";
    //        return covid19;
    //    }
    //}
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