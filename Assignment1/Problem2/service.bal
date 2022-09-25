import ballerina/graphql;
import Problem2.datastore as Datastore;
import Problem2.types as Types;

# Description  
service /graphql on new graphql:Listener(9090) {
    function init() {
        Datastore:covidTable = table [
            {region: "Khomas", date: "2020-03-01", deaths: 10, confirmed_cases: 100, recoveries: 20, tested: 100},
            {region: "Hardap", date: "2020-03-02", deaths: 10, confirmed_cases: 100, recoveries: 20, tested: 100},
            {region: "Erongo", date: "2020-03-03", deaths: 10, confirmed_cases: 100, recoveries: 20, tested: 100}
        ];
    }

resource function get covStat() returns Types:covidStat[] {
        return Datastore:covidTable.toArray();
        // lock {
        //     return Datastore:covid19.toArray();
        // }

    }
    remote function updatecovStat(string region, string date, int deaths, int confirmed_cases, int recoveries, int tested) returns Types:covidStat|error {
        Types:covidStat? covStat = Datastore:covidTable.get(region);
        // Datastore:covidTable.update(covStat);
        if covStat is Types:covidStat {
            //covStat.region = region;
            covStat.deaths = deaths;
            covStat.confirmed_cases = confirmed_cases;
            covStat.recoveries = recoveries;
            covStat.tested = tested;
            return covStat;
        } else {
            error error1 = error("covStat not found");
            return error1;
        }
        
    }
    }


// service /graphql on new graphql:Listener(4000) {
//     //private Types:covidcovStatsService covidcovStatsService;

//     function init() returns error? {
//         Datastore:covidTable = table[
//             {region: "Khomas", date: "2020-03-01", deaths: 10} confirmed_cases: 100, recoveries: 20, tested: 100},
//             {region: "Hardap", date: "2020-03-02", deaths: 10, confirmed_cases: 100, recoveries: 20, tested: 100}
//             //{date: "2021-05-01", region: "Sri Lanka", deaths: 0, confirmed_cases: 0, recovered: 0, tested: 0}
//         ];
    

//     resource function get covStat() returns Types:covStat[]|http:Response {
//         return Datastore:covidTable.toArray();
//         // lock {
//         //     return Datastore:covid19.toArray();
//         // }

//     }

//     isolated resource function get .() returns string {
//         return "Visit https://ballerina.io/learn for information on Ballerina";
//     }

    
// }
