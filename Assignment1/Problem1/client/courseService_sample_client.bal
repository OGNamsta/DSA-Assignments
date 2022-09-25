import ballerina/io;
courseServiceClient ep = check new ("http://localhost:9090");

public function main() {
    mysql:Client|sql:Error dbClient = new ("localhost", "root", "toor", "assessmgntsys", 3306);

    Create_coursesStreamingClient createCoursesStreamingClient = check ep->create_courses();

   
    future<error?> f1 = start readCreateCourseResponse(createCoursesStreamingClient);

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
        check createCoursesStreamingClient->sendCourse(item);
    }

    
    check createCoursesStreamingClient->complete();

     check wait f1;

}

function readCreateCourseResponse(Create_coursesStreamingClient create_coursesStreamingClient) returns error? {
    string? result = check create_coursesStreamingClient->receiveString();
    while !(result is ()) {
        io:print(result);
        result = check create_coursesStreamingClient->receiveString();
    }
}

