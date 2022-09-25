public type covidStat record {|
    readonly string region;
    string date;
    int deaths;
    int confirmed_cases;
    int recoveries;
    int tested;
    |};