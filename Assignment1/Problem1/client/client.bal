import ballerina/io;
import ballerina/grpc;

CourseClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    string keepRunning = "y";
    while keepRunning == "y" {

        // Get the user's choice.
        io:println("Enter choice \n1. Create courses \n2. Assign Courses \n3. Create Users \n4. Submit Assignments \n5. Request Assignments \n6. Submit Marks \n7. Register \n8. Exit");
        string decision = io:readln("Enter your choice (1 - 8): ");

        // Create courses.
        if decision == "1" {
            // io:println("Enter course details: ");
            createCourses();
        
        // Assign courses.
        } else if decision == "2" {
            // io:println("Assign courses: ");
            assignCourses();

        // Create users.
        } else if decision == "3" {
            // io:println("Create users: ");
            createUsers();
        
        // Submit assignments.
        } else if decision == "4" {
            // io:println("Submit assignments: ");
            submitAssignments();
        
        // Request assignments.
        } else if decision == "5" {
            // io:println("Request assignments: ");
            requestAssignments();
        
        // Submit marks.
        } else if decision == "6" {
            // io:println("Submit marks: ");
            submitMarks();
        
        // Register.
        } else if decision == "7" {
            // io:println("Register: ");
            register();
        
        // Exit.
        } else if decision == "8" {
            io:println("Exiting...");
            break;
        } else {
            io:println("Invalid choice");
        }
    }
}

function register() {
    do {
        RegisterStreamingClient|grpc:Error registerStreamingClient = check ep->register();
        grpc:Error? error1;
        grpc:Error? error2;
        RegisterMessage[] registeredCourses = [
            {
                userId: "MICHAEL123",
                courses: "DSA621S"
            }
        ];

        if (registerStreamingClient is error) {

        } else {

            foreach var item in registeredCourses {
                error1 = registerStreamingClient->sendRegisterMessage(item);
            }
            error2 = registerStreamingClient->complete();
            string|grpc:Error? response = registerStreamingClient->receiveString();

            io:println(error1);
            io:println(error2);
            io:println(response);
        }
    } on fail var e {
        io:println(`Error: ${e.message()}`);
    }
}

function submitMarks() {
    do {
        SubmitMarksMessage marks =
            {
            submissionId: "SUB005",
            marks: 90
        }
        ;
        string result = check ep->submit_marks(marks);
        io:println(result);

    } on fail var e {
        io:println(`Error: ${e.message()}`);
    }
}

function requestAssignments() {
    do {
        stream<SubmittedAssignmentMessage, grpc:Error?> result = check ep->request_assignments("DSA621S");
        check result.forEach(function(SubmittedAssignmentMessage assignment) {
            io:println(assignment);
        });
    } on fail var e {
        io:println(`Error: ${e.message()}`);
    }
}

function submitAssignments() {
    do {
        Submit_assignmentsStreamingClient|grpc:Error submitAssignmentsStreamingClient = check ep->submit_assignments();
        grpc:Error? error1;
        grpc:Error? error2;
        SubmitAssignmentMessage[] submittedAssignments = [
            {
                userId: "MICHAEL123",
                submissionId: "SUB005",
                courseCode: "CSC101",
                content: "CSC Assignment 1",
                marked: false
            },
            {
                userId: "MICHAEL123",
                submissionId: "SUB006",
                courseCode: "DSA621S",
                content: "GRPC Assignment 2",
                marked: true
            }

        ];

        if (submitAssignmentsStreamingClient is error) {

        } else {
            foreach var item in submittedAssignments {
                error1 = submitAssignmentsStreamingClient->sendSubmitAssignmentMessage(item);
            }
            error2 = submitAssignmentsStreamingClient->complete();
            string|grpc:Error? response = submitAssignmentsStreamingClient->receiveString();
            io:println(error1);
            io:println(error2);
            io:println(response);
        }
    } on fail var e {
        io:println(`Error: ${e.message()}`);
    }
}

function createUsers() {
    do {
        Create_usersStreamingClient|grpc:Error createUsersStreamingClient = check ep->create_users();
        grpc:Error? error1;
        grpc:Error? error2;
        UserMessage[] users = [
            {
                userId: "TENGEEVANDU123",
                firstName: "Tengeevandu",
                lastName: "Katjiuongua",
                email: "tengeevandukatjiuongua@gmail.com",
                profile: "ASSESSOR"
            },
            {
                userId: "MICHAEL123",
                firstName: "Michael",
                lastName: "Scott",
                email: "michaelscott@gmail.com",
                profile: "LEARNER"
            }

        ];

        if (createUsersStreamingClient is error) {

        } else {
            foreach var item in users {
                error1 = createUsersStreamingClient->sendUserMessage(item);
            }
            error2 = createUsersStreamingClient->complete();
            string|grpc:Error? response = createUsersStreamingClient->receiveString();
            io:println(error1);
            io:println(error2);
            io:println(response);
        }
    } on fail var e {
        io:println(`Error: ${e.message()}`);
    }
}

function assignCourses() {
    do {
        // string courseID = io:readln("Enter course ID: ");
        // string assessorID = io:readln("Enter assessor ID: ");
        AssignCoursesMessage assign_course =
            {
                courseCode: "PTM721S",
                assessorId: "TMK123"
            };

            string result = check ep->assign_courses(assign_course);
            io:println(result);
        
    } on fail var e {
        io:println(`Error: ${e.message()}`);
    }
}

function createCourses() {
    do {
        Create_coursesStreamingClient|grpc:Error createCoursesStreamingClient = check ep->create_courses();
        grpc:Error? error1;
        grpc:Error? error2;

        CourseMessage[] create_course = [

            {
                courseCode: "PTM721S",
                numberOfAssignments: 1,
                assignmentCode: "PTM721S1",
                weight: 100.0
            }
        ];

        if (createCoursesStreamingClient is error) {

        } else {
            foreach var item in create_course {
                error1 = createCoursesStreamingClient->sendCourseMessage(item);
            }
            error2 = createCoursesStreamingClient->complete();

            string|grpc:Error? response = createCoursesStreamingClient->receiveString();
            io:println(error1);
            io:println(error2);
            io:println(response);
        }

    } on fail var e {
        io:println(`Error: ${e.message()}`);
    }
}

