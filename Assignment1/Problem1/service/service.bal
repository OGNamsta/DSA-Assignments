import ballerina/grpc;
import ballerina/log;
import ballerina/io;

listener grpc:Listener ep = new (9090);
@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_COURSE, descMap: getDescriptorMapCourse()}

service "Course" on ep {
    private table<CourseMessage> key(courseCode) courses;
    private table<UserMessage> key(userId) users;
    private table<SubmitMarksMessage> key(submissionId) markSubmit;
    private table<SubmitAssignmentMessage> key(submissionId) assignmentSubmit;
    private table<AssignCoursesMessage> key(courseCode) assignCourses;
    private table<RegisterMessage> key(userId) registerLearner;
    function init() {
        self.courses = table [
                {courseCode: "CSC101", numberOfAssignments: 1, assignmentCode: "101CSC", weight: 100.0},
                {courseCode: "CSC102", numberOfAssignments: 2, assignmentCode: "102CSC", weight: 50.0},
                {courseCode: "CSC103", numberOfAssignments: 3, assignmentCode: "103CSC", weight: 33.3},
                {courseCode: "DSA621S", numberOfAssignments: 1, assignmentCode: "621SDSA", weight: 100.0}
            ];

        self.users = table [
                {userId: "JOHN123", firstName: "John", lastName: "Doe", email: "johndoe123@gmail.com", profile: "LEARNER"},
                {userId: "JANE123", firstName: "Jane", lastName: "Smith", email: "janesmith123@gmail.com", profile: "ADMINISTRATOR"},
                {userId: "JACK123", firstName: "Jack", lastName: "Anderson", email: "jackanderson123@gmail.com", profile: "ASSESSOR"},
                {userId: "TENGEE123", firstName: "Tengee", lastName: "Katjiuongua", email: "tengeevandu@live.co.uk", profile: "LEARNER"}
            ];
        
        self.markSubmit = table [
                {submissionId: "SUB001", marks: 50.0},
                {submissionId: "SUB002", marks: 50.0},
                {submissionId: "SUB003", marks: 50.0},
                {submissionId: "SUB004", marks: 100.0}
            ];
    //     readonly string submissionId;// = "";
    // string userId;// = "";
    // string courseCode;// = "";
    // string content;// = "";
    // boolean marked = false;
        self.assignmentSubmit = table [
                {submissionId: "SUB001", userId: "JOHN123", courseCode: "CSC101", content: "CONTENT1",  marked: true},
                {submissionId: "SUB002", userId: "JANE123", courseCode: "CSC102", content: "CONTENT2",  marked: true},
                {submissionId: "SUB003", userId: "JACK123", courseCode: "CSC103", content: "CONTENT3",  marked: true},
                {submissionId: "SUB004", userId: "TENGEE123", courseCode: "DSA621S", content: "GRPC Assignment 1",  marked: false}
            ];
        
        self.assignCourses = table [
                {courseCode: "CSC101", assessorId: "JOHN123"},
                {courseCode: "CSC102", assessorId: "JANE123"},
                {courseCode: "CSC103", assessorId: "JACK123"},
                {courseCode: "DSA621S", assessorId: "TMK123"}
            ];
        
        self.registerLearner = table [
                {userId: "JOHN123", courses: "CSC101"},
                {userId: "JANE123", courses: "CSC102"},
                {userId: "JACK123", courses: "CSC103"},
                {userId: "TENGEE123", courses: "DSA621S"}
            ];
    }
//create_course

    remote function create_courses(stream<CourseMessage, grpc:Error?> clientStream) returns stream<string, error?>|error {
        log:printInfo("Client Connection Successful");
        log:printInfo("Create Course");
        string[] course_code = [];
        // Reads and processes each message in the client stream.
        check clientStream.forEach(function (CourseMessage course) {
            self.courses.add(course);
            io:println(`Course created successfully: ${course.courseCode}`);
            course_code.push(course.courseCode);
        });
        return course_code.toStream();
    }        
//assign_course
    remote function assign_courses(AssignCoursesMessage value) returns string|error {
        log:printInfo("Client connected successfully.");
        log:printInfo("Assign Course");
        self.assignCourses.add(value);
        return "Course assigned successfully.";
    }
//create_user
    remote function create_users(stream<UserMessage, grpc:Error?> clientStream) returns string|error {
        log:printInfo("Client connected successfully.");
        log:printInfo("Create User");
        // Reads and processes each message in the client stream.
        _ = check from UserMessage userMsg in clientStream
            do {
                log:printInfo("User info received: " + userMsg.toString());
                self.users.add(userMsg);
            };
        return "User added successfully.";
    }
    //submit_assignment
    remote function submit_assignments(stream<SubmitAssignmentMessage, grpc:Error?> clientStream) returns string|error {
        log:printInfo("Client connected successfully.");
        log:printInfo("Submit Assignment");
        // Reads and processes each message in the client stream.
        _ = check from SubmitAssignmentMessage assignmentMsg in clientStream
            do {
                log:printInfo("Assignment info received: " + assignmentMsg.toString());
                self.assignmentSubmit.add(assignmentMsg);
            };
        return "Assignment submitted successfully.";
    }
//request_assignment
    remote function request_assignments(string payload) returns stream<SubmittedAssignmentMessage, error?>|error {
        log:printInfo("Client connected successfully.");
        SubmittedAssignmentMessage[] assignment = [];

        foreach SubmitAssignmentMessage item in self.assignmentSubmit {
            if (item.courseCode == payload) {
                if (item.marked == false) {
                    SubmitAssignmentMessage assignmentMsg = item;
                    SubmittedAssignmentMessage submittedAssignment = {
                        subass: assignmentMsg
                    };
                    assignment.push(submittedAssignment);
                }
                else {
                    return error("No assignments available for marking");
                }
            }
        }
        return assignment.toStream();
    }
//submit_marks
    remote function submit_marks(SubmitMarksMessage marksMsg) returns string|error  {
        log:printInfo("Client connected successfully.");
        log:printInfo("Submit Marks");        
        log:printInfo("Marks info received: " + marksMsg.toString());
        self.markSubmit.add(marksMsg);

        return "Marks submitted successfully.";
    }
//register_learner
    remote function register(stream<RegisterMessage, grpc:Error?> clientStream) returns stream<string, error?>|error {
        log:printInfo("Client connected successfully.");
        log:printInfo("Register Learner");
        string[] userid = [];
        _ = check from RegisterMessage registerMsg in clientStream
            do {
                log:printInfo("Registration info received: " + registerMsg.toString());
                self.registerLearner.add(registerMsg);
            };
        return userid.toStream();
    }
}