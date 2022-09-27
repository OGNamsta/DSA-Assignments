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
        

    }
    remote function updatecovStat(string region, string date, int deaths, int confirmed_cases, int recoveries, int tested) returns Types:covidStat|error {
        Types:covidStat? covStat = Datastore:covidTable.get(region);
        if covStat is Types:covidStat {
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