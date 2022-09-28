import ballerina/io;

courseServiceClient ep = check new ("http://localhost:9090");

public function courseServiceMgnt() returns error? {

    Create_coursesStreamingClient create_coursesStreamingClient = check ep->create_courses();

    future<error?> f1 = start readCreateCoursesResponse(create_coursesStreamingClient);

    Course[] create_courses = [
        {
            courseCode: "DSA621S",
            assignments: [
                {assignmentCode: "DSA621S-1", weight: 50.0},
                {assignmentCode: "DSA621S-2", weight: 25.0},
                {assignmentCode: "DSA621S-3", weight: 25.0}
            ],
            number_of_assignments: 3,
            assessorId: "A001"
        }
    ];

    foreach var item in create_courses {
        check create_coursesStreamingClient->sendCourse(item);
    }

    check create_coursesStreamingClient->complete();

    check wait f1;
        
    }

function readCreateCoursesResponse(Create_coursesStreamingClient create_coursesStreamingClient) returns error? {
    string? result = check create_coursesStreamingClient->receiveString();
    while !(result is ()) {
        io:println(result);
        result = check create_coursesStreamingClient->receiveString();
    }
    // return error ("");
}