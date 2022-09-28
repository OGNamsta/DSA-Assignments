import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_USER_INFO, descMap: getDescriptorMapUserInfo()}

service "courseService" on ep {
    private table<User> key(userId) users;
    private table<Course> key(courseCode) course;
    private table<Assignment> key(assignmentCode) assignment;
    private table<Mark> key(userId) mark;
    private table<SubmitedAssignment> key(userId) submitedAssignment;

    function init() {
        self.users = table [
                {userId: "JOHN123", firstName: "John", lastName: "Doe", email: "johndoe123@gmail.com", profile: "LEARNER"},
                {userId: "JAKE123", firstName: "Jake", lastName: "Smitch", email: "jakesmith123@gmail.com", profile: "ADMINISTRATOR"},
                {userId: "JACK123", firstName: "Jack", lastName: "Anderson", email: "jackanderson123@gmail.com", profile: "ASSESSOR"}
            ];

        self.course = table [
                {courseCode: "COURSE1", number_of_assignments: 1, assignments: [], assessorId: "JANE123"},
                {courseCode: "COURSE2", number_of_assignments: 2, assignments: [], assessorId: "JANE123"},
                {courseCode: "COURSE3", number_of_assignments: 3, assignments: [], assessorId: "JANE123"}
            ];

        self.assignment = table [
                {assignmentCode: "ASSIGNMENT1", weight: 100.0},
                {assignmentCode: "ASSIGNMENT2", weight: 25.0},
                {assignmentCode: "ASSIGNMENT3", weight: 25.0}
            ];

        self.mark = table [
                {
                    userId: "JOHN123",
                    course: {
                        courseCode: "COURSE1",
                        number_of_assignments: 1,
                        assignments: [
                            {assignmentCode: "ASSIGNMENT1", weight: 100.0}
                        ],
                        assessorId: "JOHN1234"
                    },
                    mark: 100
                },
                {
                    userId: "JAKE123",
                    course: {
                        courseCode: "COURSE2",
                        number_of_assignments: 2,
                        assignments: [
                            {assignmentCode: "ASSIGNMENT1", weight: 50.0},
                            {assignmentCode: "ASSIGNMENT2", weight: 50.0}
                        ],
                        assessorId: "JAKE1234"
                    },
                    mark: 100
                },
                {
                    userId: "JACK123",
                    course: {
                        courseCode: "COURSE3",
                        number_of_assignments: 3,
                        assignments: [
                            {assignmentCode: "ASSIGNMENT1", weight: 100.0},
                            {assignmentCode: "ASSIGNMENT2", weight: 25.0},
                            {assignmentCode: "ASSIGNMENT3", weight: 25.0}
                        ],
                        assessorId: "JACK1234"
                    },
                    mark: 100
                }
            ];

        self.submitedAssignment = table [
    {
                    userId: "JOHN123",
                    course: {
                        courseCode: "COURSE1",
                        number_of_assignments: 1,
                        assignments: [
                            {assignmentCode: "ASSIGNMENT1", weight: 50.0},
                            {assignmentCode: "ASSIGNMENT2", weight: 50.0}
                        ],
                        assessorId: "JOHN1234"
                    },
                    content: " ",
                    marked: false
                }
];
    }

    remote function assign_courses(stream<CourseAssessor, grpc:Error?> clientStream) returns string|error {
        _ = check clientStream.forEach(function (CourseAssessor courseAssessor) {
            log:printInfo("Assigning course " + courseAssessor.courseCode + " to assessor " + courseAssessor.assessorId);
            var course = self.course.get(courseAssessor.courseCode);
            if (course is Course) {
                course.assessorId = courseAssessor.assessorId;
                // self.course.update(course);
            }
        });
        return "Course assigned successfully";
    }
    remote function create_users(stream<string, grpc:Error?> clientStream) returns stream<string, error?>|error {
        _ = check clientStream.forEach(function(string userId) {
            self.users.add({userId: userId, firstName: "", lastName: "", email: "", profile: ""});
        });
        return clientStream.map(function(string userId) returns string {
            return string `User ${userId} registered successfully`;
        });
    }
    remote function submit_assignments(stream<SubmitedAssignment, grpc:Error?> clientStream) returns stream<string, grpc:Error?>|error {
        _ = check clientStream.forEach(function(SubmitedAssignment submitedAssignment) {
            self.submitedAssignment.add(submitedAssignment);
        });
        return clientStream.'map(function(SubmitedAssignment submitedAssignment) returns string {
            return string `SubmitedAssignment ${submitedAssignment.userId} ${submitedAssignment.course.courseCode} ${submitedAssignment.content} ${submitedAssignment.marked}`;
        });
    }
    remote function submit_marks(stream<Mark, grpc:Error?> clientStream) returns string|error {
        _ = check clientStream.forEach(function(Mark mark) {
            self.mark.add(mark);
            });
            return "accessor submitted marks";
    }
    remote function request_assignments(string value) returns table<Assignment> key<error> {
        //request_assignments, where an assessor requests submitted assignments for a course he/she has been allocated. 
        //Note that an assignment can be marked only once. The function should stream back all assignments that have not been marked yet;
        return self.submitedAssignment.map(function (SubmitedAssignment submitedAssignment) returns Assignment {
            return {assignmentCode: submitedAssignment.course.courseCode, weight: 0.0};
        });
    }
    remote function create_courses(CourseServiceStringCaller caller, stream<Course, error?> clientStream) returns error? {
        _ = check clientStream.forEach(function (Course course) {
            self.course.add(course);
            checkpanic  caller->sendString(string `Course ${course.courseCode} created successfully`);
        });
        _ = check caller->complete();
    }
    remote function register(stream<string, grpc:Error?> clientStream) returns stream<string, error?>|error {
        _ = check clientStream.forEach(function(string userId) {
            self.users.add({userId: userId, firstName: "", lastName: "", email: "", profile: ""});
        });
        return clientStream.map(function(string userId) returns string {
            return string `User ${userId} registered successfully`;
        });
    }
}