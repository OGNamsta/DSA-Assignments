import ballerina/io;
// import ballerina/sql;
// import ballerinax/mysql;

courseserviceClient ep = check new ("http://localhost:9090");
 
public function main() returns error? {
    // mysql:Client|sql:Error dbClient = new ("localhost", "root", "toor", "assessmgntsys", 3306);
    // if (dbClient is mysql:Client) {
    //     io:println("Database connected");
    // } else {
    //     io:println("Error in database connection");
    // }
    Create_coursesStreamingClient create_coursesStreamingClient = check ep->create_courses();

   
    future<error?> f1 = start readCreateCourseResponse(create_coursesStreamingClient);

    Course[] create_course = [
        {
        courseCode: "DSA621S",
        assignments: [
            {assignmentCode: "ASS1", weight: 0.3}
        ]
    },
    {
        courseCode: "DSA622S",
        assignments: [
            {assignmentCode: "ASS2", weight: 0.3}
        ]
    }
    ];

    foreach var item in create_course {
        check create_coursesStreamingClient->sendCourse(item);
    }

    
    check create_coursesStreamingClient->complete();

     check wait f1;

}

function readCreateCourseResponse(Create_coursesStreamingClient create_coursesStreamingClient) returns error? {
    string? result = check create_coursesStreamingClient->receiveString();
    while !(result is ()) {
        io:print(result);
        result = check create_coursesStreamingClient->receiveString();
    }
}