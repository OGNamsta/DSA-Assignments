import ballerina/grpc;
// import ballerina/sql;
import ballerina/log;
import ballerina/io;
//import ballerinax/jdbc;

// type User record {|
//     int userID;
//     string firstName;
//     string lastName;
//     string email;
//     string profile;
// |};
// type Course record {|
//     int courseID;
//     string courseName;
//     int courseAssignmentNumber;
//     float courseAssignmentWeight;
//     int courseAsssignmentID;
// |};

// type Marks record {|
//     int markID;
//     int courseMarkID;
//     float Mark;
//     int marksAssignmentID;
// |};

// type Assignment record {|
//     int assignmentID;
//     string assignmentName;
//     string assignmentDescription;
//     string assignmentDueDate;
//     int assignmentCourseID;
// |};

// type SubmittedAssignment record {|
//     int subAssID;
//     int CourseID;
//     int subAssIDAssignmentID;
//     string SubmissionDate;
//     int submittedAssignmentCourseID;
// |};

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_USER_INFO, descMap: getDescriptorMapUserInfo()}



service "courseservice" on ep {
    private table<User> key(userId) users;
    private table<Course> key(courseCode) courses;
    private table<Mark> key(userId) marks;
    private table<SubmitedAssignment> key(userId) submitedAssignments;
    function init() {
        self.users = table [
                {userId: "JOHN123", firstname: "John", lastname: "Doe", email: "johndoe@gmail.com", profile: "LEARNER"},
                {userId: "JANE123", firstname: "Jane", lastname: "Doe", email: "janedoe@gmail.com", profile: "ADMINISTRATOR"},
                {userId: "DANE123", firstname: "Dane", lastname: "Doe", email: "danedoe@gmail.com", profile: "ASSESSOR"}
                
            ];
        self.courses = table [];
        self.marks = table [];
        self.submitedAssignments = table [];
    }
    // sql:Client sqlClient = check new (database = "assesmgntsys", user = "root", password = "toor");

//jdbc:Client mysqlClient = check new (user = "root", password = "Test@123", database = "CUSTOMER");



    remote function assign_courses(stream<CourseAssessor, grpc:Error?> clientStream) returns error? {
    }
    remote function create_users(stream<User, grpc:Error?> clientStream) returns error? {
    }
    remote function submit_assignments(stream<SubmitedAssignment, grpc:Error?> clientStream) returns error? {
    }
    remote function submit_marks(stream<Mark, grpc:Error?> clientStream) returns error? {
    }
    remote function register(stream<string, grpc:Error?> clientStream) returns error? {//stream<CourseCodeRecord,
        _ = check clientStream.forEach(function (string userId) {
            self.users.add({userId: userId, firstname: "", lastname: "", email: "", profile: ""});
        });
        return clientStream.map(function (string userId) returns string {
            return string `User ${userId} registered successfully`;
        });
    }
    remote function request_assignments(string value) returns stream<Assignment, error?>|error {//CourseCodeRecord value
        //request_assignments, where an assessor requests submitted assignments for a course he/she has been allocated. 
        //Note that an assignment can be marked only once. The function should stream back all assignments that have not been marked yet;
        return self.submitedAssignments.map(function (SubmitedAssignment submitedAssignment) returns Assignment {
            return {assignmentCode: submitedAssignment.course.courseCode, weight: 0.0};
        });
        
    }
    //remote function create_courses(stream<Course, grpc:Error?> clientStream) returns error?<CourseCodeRecord, error?>|error {
    remote function create_courses(CourseServiceStringCaller caller, stream<Course, error?> clientStream) returns error? {
        _ = check clientStream.forEach(function (Course course) {
            self.courses.add(course);
            checkpanic  caller->sendString(string `Course ${course.courseCode} created successfully`);
        });
        _ = check caller->complete();
    }
}

