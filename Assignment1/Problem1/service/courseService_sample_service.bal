import ballerina/grpc;
import ballerina/sql;
import ballerina/log;
import ballerina/io;
//import ballerinax/jdbc;

type User record {|
    int userID;
    string firstName;
    string lastName;
    string email;
    string profile;
|};
type Course record {|
    int courseID;
    string courseName;
    int courseAssignmentNumber;
    float courseAssignmentWeight;
    int courseAsssignmentID;
|};

type Marks record {|
    int markID;
    int courseMarkID;
    float Mark;
    int marksAssignmentID;
|};

type Assignment record {|
    int assignmentID;
    string assignmentName;
    string assignmentDescription;
    string assignmentDueDate;
    int assignmentCourseID;
|};

type SubmittedAssignment record {|
    int subAssID;
    int CourseID;
    int subAssIDAssignmentID;
    string SubmissionDate;
    int submittedAssignmentCourseID;
|};

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_USER_INFO, descMap: getDescriptorMapUserInfo()}



service "courseService" on ep {
    sql:Client sqlClient = check new (database = "assesmgntsys", user = "root", password = "toor");

//jdbc:Client mysqlClient = check new (user = "root", password = "Test@123", database = "CUSTOMER");



    remote function assign_courses(stream<CourseAssessor, grpc:Error?> clientStream) returns error? {
    }
    remote function create_users(stream<User, grpc:Error?> clientStream) returns error? {
    }
    remote function submit_assignments(stream<SubmittedAssignment, grpc:Error?> clientStream) returns error? {
    }
    remote function submit_marks(stream<MarksRecord, grpc:Error?> clientStream) returns error? {
    }
    remote function register(stream<CourseCodeRecord, grpc:Error?> clientStream) returns error? {
    }
    remote function request_assignments(CourseCodeRecord value) returns stream<Assignment, error?>|error {
        
    }
    remote function create_courses(stream<Course, grpc:Error?> clientStream) returns stream<CourseCodeRecord, error?>|error {
    }
}

