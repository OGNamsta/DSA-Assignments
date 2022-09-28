import ballerina/http;
import ballerina/log;
import Problem3.types as Types;
import Problem3.datastore as Datastore;

listener http:Listener ep0 = new (8080, config = {host: "localhost"});

isolated service /vle/api/v1 on ep0 {
    //get all students in the system
    resource function get students() returns Types:Student[]|http:Response {
        log:printDebug("Getting all students");
        return Datastore:student.toArray();
    }

    //get a student by username from the system
    resource function get students/[string username]() returns Types:Student|Types:Error {
        Types:Student? student = Datastore:student.get(username);
        if student == () {
            return {
                errorType: "Not Found",
                errorMessage: string `User ${username} not found`
            };
        }
        else {
            log:printDebug("Student " + username + " retrieved successfully");
            return student;
        }
    }

    //post a new student to the system
    resource function post students(@http:Payload Types:Student payload) returns Types:CreatedInlineResponse201|Types:Error|string {
        string[] ConflictingUsernames = from var {username} in Datastore:student
            where username == payload.username
            select username;

        if (ConflictingUsernames.length() > 0) {
            return {
                errorType: "Error",
                errorMessage: "Username already exists"
            };
        }
else {
            Datastore:student.put(payload);
            return "Student " + payload.username + " added successfully";
        }
    }

    //update a student by username in the system
    resource function put students/[string username](@http:Payload Types:Student payload) returns Types:Student|Types:Error {
        Types:Student? student = Datastore:student.get(username);
        //check if the username is already taken
        if student == () {
            return {
                errorType: "User not Found",
                errorMessage: string `User ${username} not found`
            };
        }
        else {
            Datastore:student.put(payload);
            log:printDebug("Student " + username + " updated successfully");

            return payload;
        }

    }
    //delete a student by username from the system
    resource function delete students/[string username]() returns Types:Student|Types:Error {
        Types:Student? student = Datastore:student.get(username);
        if student == () {
            return {
                errorType: "NotFound",
                errorMessage: string `User ${username} not found`
            };
        }
        else {
            Types:Student removeStudent = Datastore:student.remove(username);
            log:printDebug("Student " + username + " deleted");
            return removeStudent;
        }
    }
    //get all courses in the system
    resource function get coursedetails() returns Types:Courseinfo[]|http:Response {
        
        return Datastore:course.toArray();
    }

//get a course by courseid from the system
    resource function get coursedetails/[string course_code]() returns Types:Courseinfo|Types:Error {
        Types:Courseinfo? course = Datastore:course.get(course_code);
        if course == () {
            return {
                errorType: "NotFound",
                errorMessage: string `Course Code ${course_code} not found`
            };
        }
        else {
            log:printDebug("Course " + course_code + " retrieved successfully");
            return course;
        }
    }

    //post a new course to the system
    resource function post coursedetails(@http:Payload Types:Courseinfo payload) returns Types:CreatedInlineResponse2011|Types:Error|string {
        string[] ConflictingCourseCodes = from var {course_code} in Datastore:course
            where course_code == payload.course_code
            select course_code;

        if (ConflictingCourseCodes.length() > 0) {
            return {
                errorType: "AlreadyExists",
                errorMessage: string `Course Code ${payload.course_code} already exists`
            };
        } else {
            log:printDebug("Course " + payload.course_code + " added successfully");
            Datastore:course.put(payload);
            return "Course " +payload.course_code+ " added successfully";    
        }
    }
    
    //update a course by courseid in the system
    resource function put coursedetails/[string course_code](@http:Payload Types:Courseinfo payload) returns Types:Courseinfo|Types:Error {
        Types:Courseinfo? course = Datastore:course.get(course_code);
        //check if the courseid is already taken
        if course == () {
            return {
                errorType: "NotFound",
                errorMessage: string `Course Code ${course_code} not found`
            };
        }
        else {
            Datastore:course.put(payload);
            log:printDebug("Course " + course_code + " updated successfully");
            return payload;
        }
    }

    //delete a course by courseid from the system
    resource function delete coursedetails/[string course_code]() returns Types:Courseinfo|Types:Error|string { 
        Types:Courseinfo? course = Datastore:course.get(course_code);
        if course == () {
            return {
                errorType: "NotFound",
                errorMessage: string `Course Code ${course_code} not found`
            };
        }
        else {
            Types:Courseinfo removeCourse = Datastore:course.remove(course_code);
            log:printDebug("Course " + course_code + " deleted");
            return removeCourse;
        }
    }
}