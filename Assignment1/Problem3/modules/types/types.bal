import ballerina/http;

public type CreatedStudent record {|//CreatedUser
    *http:Created;
    Student body;
|};

public type CreatedStudentId record {
    # the username of the user newly created
    string studentid?;
};

public type ConflictingUsername record {|//Conflict error
    *http:Conflict;
    Error body;
|};

public type Error record {//Error record
    string errorType?;
    string errorMessage?;
};

public type CreatedInlineResponse201 record {|//CreatedUser response
    *http:Created;
    InlineResponse201 body;
|};
public type CreatedInlineResponse2011 record {|//CreatedUser response
    *http:Created;
    InlineResponse2011 body;
|};
public type InlineResponse2011 record {//CreatedCourse response
    # the username of the Course newly created
    string Courseid;
};



public type StudentArr Student[];//Student array type

public type CourseinfoArr Courseinfo[];//Courseinfo array type

public type InlineResponse201 record {//CreatedStudent response
    # the username of the Student newly created
    string Studentid?;
};



public type Courseinfo record {//Courseinfo record type
    # the course code of the student
    readonly string course_code;
    # the course name of the student
    string course_name?;
    # the course mark of the student
    string course_mark?;
};

public type Student record {//Student record type
    # the Student name of the Student
    readonly string username;
    # the first name of the Student
    string firstname?;
    # the last name of the Student
    string lastname?;
    # the email address of the Student
    string email?;
};
