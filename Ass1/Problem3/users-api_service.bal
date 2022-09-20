import ballerina/http;
import Problem3.types as Types;
import Problem3.datastore as Datastore;

listener http:Listener ep0 = new (8080, config = {host: "localhost"});

isolated service /vle/api/v1 on ep0 {
    //initialize the datastore
    //private table<Types:Student> key(username) student;
    //function init() {
    //    self.student = table [];
    // }
    //get all students in the system
    resource function get students() returns Types:Student[]|http:Response {
        lock {
            return Datastore:student.toArray();
        }
    }
    //post a new student to the system
    resource function post students(@http:Payload Types:Student payload) returns Types:CreatedInlineResponse201|Types:Error {
        string[] ConflictingUsernames = from var {username} in Datastore:student
            where username == payload.username
            select username;

        if (ConflictingUsernames.length() > 0) {
            return {message: "Username already exists"};
        }
else {
            lock {
                Datastore:student.put(payload);
            }
        }
    }

    //get a student by username from the system
    resource function get students/[string username]() returns Types:Student {
        Types:Student? student = Datastore:student.get(username);
        if student == () {
            return {username: "Not Found"};
        }
        else {
            return student;
        }
    }
    //update a student by username in the system
    resource function put students/[string username](@http:Payload Types:Student payload) returns Types:Student|Types:Error {
        Types:Student? student = Datastore:student.get(username);
        //check if the username is already taken
        if student == () {
            return <Types:Error>{
                errorType: "User not Found",
                message: string `User ${username} not found`
            };
        }
        else {
            lock {
                Datastore:student.put(payload);
            }
            return payload;
        }
        //update the student in the datastore
        //self.studentTable.update(payload);
        //return a 200 response
        //return {message: "Student updated successfully"};
    }
    //delete a student by username from the system
    resource function delete students/[string username]() returns Types:Error {
        Types:Student? student = Datastore:student.get(username);
        if student == () {
            return <Types:Error>{
                errorType: "User not Found",
                message: string `User ${username} not found`
            };
        }
        else {
            lock {
                Types:Student remove = Datastore:student.remove(username);
            }
        }
    }
    //get all courses in the system
    resource function get coursedetails() returns Types:Courseinfo[]|http:Response {
        lock {
            return Datastore:course.toArray();
        }

    }
    //post a new course to the system
    resource function post coursedetails(@http:Payload Types:Courseinfo payload) returns Types:CreatedInlineResponse2011|Types:Error {
        string[] ConflictingCourseCodes = from var {course_code} in Datastore:course
            where course_code == payload.course_code
            select course_code;

        if (ConflictingCourseCodes.length() > 0) {
            return <Types:Error>{
                errorType: "Course Code already exists",
                message: string `Course Code ${payload.course_code} already exists`
            };
    } else {
            lock {
                Datastore:course.put(payload);
            }
        }
    }
    //get a course by courseid from the system
    resource function get coursedetails/[string course_code]() returns Types:Courseinfo|Types:Error {
        Types:Courseinfo? course = Datastore:course.get(course_code);
        if course == () {
            return <Types:Error>{
                errorType: "Course Code not Found",
                message: string `Course Code ${course_code} not found`
            };
        }
        else {
            return course;
        }
    }
    //update a course by courseid in the system
    resource function put coursedetails/[string course_code](@http:Payload Types:Courseinfo payload) returns Types:Courseinfo|Types:Error {
        Types:Courseinfo? course = Datastore:course.get(course_code);
        //check if the courseid is already taken
        if course == () {
            return <Types:Error>{
                errorType: "Course Code not Found",
                message: string `Course Code ${course_code} not found`
            };
        }
        else {
            lock {
                Datastore:course.put(payload);
            }
            return payload;
        }
        //update the course in the datastore
        //self.courseTable.update(payload);
        //return a 200 response
        //return {message: "Course updated successfully"};
    }
    //delete a course by courseid from the system
    resource function delete coursedetails/[string course_code]() returns http:NoContent|Types:Error {
        Types:Courseinfo? course = Datastore:course.get(course_code);
        if course == () {
            return <Types:Error>{
                errorType: "Course Code not Found",
                message: string `Course Code ${course_code} not found`
            };
        }
        else {
            lock {
                Types:Courseinfo remove = Datastore:course.remove(course_code);
            }
        }
    }

}
