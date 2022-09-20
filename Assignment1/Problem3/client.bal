import ballerina/http;
import Problem3.types as Types;
import Problem3.datastore as Datastore;

public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "http://localhost:8080/vle/api/v1") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Get all students added to the application
    #
    # + return - A list of students 
    remote isolated function getAllStudents() returns Student[]|error {
        string resourcePath = string `/students`;
        Student[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Insert a new Student
    #
    # + return - Student successfully created 
    remote isolated function insert(Student payload) returns InlineResponse201|error {
        string resourcePath = string `/students`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        InlineResponse201 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a single upser
    #
    # + username - username of the Student 
    # + return - Student response 
    remote isolated function getStudent(string username) returns Student|error {
        string resourcePath = string `/students/${getEncodedUri(username)}`;
        Student response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing Student
    #
    # + username - username of the Student 
    # + return - Student was successfully updated 
    remote isolated function updateStudent(string username, Student payload) returns Student|error {
        string resourcePath = string `/students/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Student response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an existing Student
    #
    # + username - username of the Student 
    # + return - Student was successfully deleted 
    remote isolated function deleteStudent(string username) returns http:Response|error {
        string resourcePath = string `/students/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
    # Get all course details added to the application
    #
    # + return - A list of courses 
    remote isolated function getAllCourses() returns Courseinfo[]|error {
        string resourcePath = string `/coursedetails`;
        Courseinfo[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Insert a new course
    #
    # + return - Course successfully created 
    remote isolated function insertCourse(Courseinfo payload) returns InlineResponse2011|error {
        string resourcePath = string `/coursedetails`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        InlineResponse2011 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a single course
    #
    # + courseCode - course code of the Course 
    # + return - Course response 
    remote isolated function getCourse(string courseCode) returns Courseinfo|error {
        string resourcePath = string `/coursedetails/${getEncodedUri(courseCode)}`;
        Courseinfo response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing Course
    #
    # + courseCode - course code of the Course 
    # + return - Course was successfully updated 
    remote isolated function updateCourse(string courseCode, Courseinfo payload) returns Courseinfo|error {
        string resourcePath = string `/coursedetails/${getEncodedUri(courseCode)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Courseinfo response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an existing Course
    #
    # + courseCode - course code of the Course 
    # + return - Course was successfully deleted 
    remote isolated function deleteCourse(string courseCode) returns http:Response|error {
        string resourcePath = string `/coursedetails/${getEncodedUri(courseCode)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
}
