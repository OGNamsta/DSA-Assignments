import ballerina/http;
import Problem3.types as Types;
// import Problem3.datastore as Datastore;

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
    # Get all students added to the application Types:Types:Student[]
    #
    # + return - A list of students 
    remote isolated function getAllStudents() returns Types:Student[]|error {
        string resourcePath = string `/students`;
        Types:Student[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Insert a new Student
    #
    # + payload - Parameter Description
    # + return - Student successfully created
    remote isolated function insert(Types:Student payload) returns Types:InlineResponse201|error {
        string resourcePath = string `/students`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:InlineResponse201 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a single upser
    #
    # + username - username of the Student 
    # + return - Student response 
    remote isolated function getStudent(string username) returns Types:Student|error {
        string resourcePath = string `/students/${getEncodedUri(username)}`;
        Types:Student response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing Student
    #
    # + username - username of the Student  
    # + payload - Parameter Description
    # + return - Student was successfully updated
    remote isolated function updateStudent(string username, Types:Student payload) returns Types:Student|error {
        string resourcePath = string `/students/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:Student response = check self.clientEp->put(resourcePath, request);
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
    remote isolated function getAllCourses() returns Types:Courseinfo[]|error {
        string resourcePath = string `/coursedetails`;
        Types:Courseinfo[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Insert a new course
    #
    # + payload - Parameter Description
    # + return - Course successfully created
    remote isolated function insertCourse(Types:Courseinfo payload) returns Types:InlineResponse2011|error {
        string resourcePath = string `/coursedetails`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:InlineResponse2011 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a single course
    #
    # + courseCode - course code of the Course 
    # + return - Course response 
    remote isolated function getCourse(string courseCode) returns Types:Courseinfo|error {
        string resourcePath = string `/coursedetails/${getEncodedUri(courseCode)}`;
        Types:Courseinfo response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing Course
    #
    # + courseCode - course code of the Course  
    # + payload - Parameter Description
    # + return - Course was successfully updated
    remote isolated function updateCourse(string courseCode, Types:Courseinfo payload) returns Types:Courseinfo|error {
        string resourcePath = string `/coursedetails/${getEncodedUri(courseCode)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        Types:Courseinfo response = check self.clientEp->put(resourcePath, request);
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
