import ballerina/grpc;
import ballerina/protobuf.types.wrappers;
import ballerina/protobuf.types.empty;

public isolated client class courseserviceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR_USER_INFO, getDescriptorMapUserInfo());
    }

    isolated remote function assign_courses() returns Assign_coursesStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseservice/assign_courses");//courseService to courseservice
        return new Assign_coursesStreamingClient(sClient);
    }

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseservice/create_users");//courseService to courseservice
        return new Create_usersStreamingClient(sClient);
    }

    isolated remote function submit_assignments() returns Submit_assignmentsStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseservice/submit_assignments");//courseService to courseservice
        return new Submit_assignmentsStreamingClient(sClient);
    }

    isolated remote function submit_marks() returns Submit_marksStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseservice/submit_marks");//courseService to courseservice
        return new Submit_marksStreamingClient(sClient);
    }

    isolated remote function register() returns RegisterStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseservice/register");//courseService to courseservice
        return new RegisterStreamingClient(sClient);
    }
    //isolated remote function request_assignments(CourseCodeRecord|ContextCourseCode req)
    isolated remote function request_assignments(string|wrappers:ContextString req) returns stream<Assignment, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        string message;//CourseCodeRecord message;
        if req is wrappers:ContextString {//ContextCourseCode
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("courseservice/request_assignments", message, headers);//courseService to courseservice
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        AssignmentStream outputStream = new AssignmentStream(result);
        return new stream<Assignment, grpc:Error?>(outputStream);
    }
    //isolated remote function request_assignmentsContext(CourseCodeRecord|ContextCourseCode req)
    isolated remote function request_assignmentsContext(string|wrappers:ContextString req) returns ContextAssignmentStream|grpc:Error {
        map<string|string[]> headers = {};
        string message;//CourseCodeRecord message
        if req is wrappers:ContextString {//ContextCourseCode to wrappers:ContextString
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("courseservice/request_assignments", message, headers);//courseService to courseservice
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        AssignmentStream outputStream = new AssignmentStream(result);
        return {content: new stream<Assignment, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function create_courses() returns Create_coursesStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("courseservice/create_courses");//courseService to courseservice
        return new Create_coursesStreamingClient(sClient);
    }
}

public client class Assign_coursesStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCourseAssessor(CourseAssessor message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCourseAssessor(ContextCourseAssessor message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {//receive to receiveString. returns grpc:Error? to returns string|grpc:Error?
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;//payload, headers to payload, _
            return payload.toString(); //previously blank
        }
    }
    //isolated remote function receiveContextNil() returns empty:ContextNil|grpc:Error? {
    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
            //return {headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class Create_usersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }


    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }
    //isolated remote function receive() returns grpc:Error? {
    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;//payload, headers to payload, _
            return payload.toString();//previously blank
        }
    }
    //isolated remote function receiveContextNil() returns empty:ContextNil|grpc:Error? {
    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
            //return {headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
} 

public client class Submit_assignmentsStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }
    //isolated remote function sendAssignment(Assignment message) returns grpc:Error? {
    isolated remote function sendSubmitedAssignment(SubmitedAssignment message) returns grpc:Error? {//Assignment to SubmitedAssignment
        return self.sClient->send(message);
    }
    //isolated remote function sendContextAssignment(ContextAssignment message) returns grpc:Error? {
    isolated remote function sendContextSubmitedAssignment(ContextSubmitedAssignment message) returns grpc:Error? {//ContextAssignment to ContextSubmitedAssignment
        return self.sClient->send(message);
    }
    //isolated remote function receive() returns grpc:Error? {
    isolated remote function receiveString() returns string|grpc:Error? {//receive to receiveString. returns grpc:Error? to returns string|grpc:Error?
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();//previously blank
        }
    }
    //isolated remote function receiveContextNil() returns empty:ContextNil|grpc:Error? {
    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
            //return {headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class Submit_marksStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendMark(Mark message) returns grpc:Error? {//MarksRecord to Mark
        return self.sClient->send(message);
    }

    isolated remote function sendContextMark(ContextMark message) returns grpc:Error? {
        return self.sClient->send(message);
    }
    //isolated remote function receive() returns grpc:Error? {
    isolated remote function receiveString() returns string|grpc:Error? {//receive to receiveString. returns grpc:Error? to returns string|grpc:Error?
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();//previously blank
        }
    }
    //isolated remote function receiveContextNil() returns empty:ContextNil|grpc:Error? {
    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
            //return {headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class RegisterStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }
    //isolated remote function sendCourseCode(CourseCodeRecord message) returns grpc:Error? {
    isolated remote function sendString(string message) returns grpc:Error? {
        return self.sClient->send(message);
    }
    //isolated remote function sendContextCourseCode(ContextCourseCode message) returns grpc:Error? {
    isolated remote function sendContextString(wrappers:ContextString message) returns grpc:Error? {
        return self.sClient->send(message);
    }
    //isolated remote function receive() returns grpc:Error? {
    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();//previously blank
        }
    }
    //isolated remote function receiveContextNil() returns empty:ContextNil|grpc:Error? {
    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
            //return {headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class AssignmentStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Assignment value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Assignment value;|} nextRecord = {value: <Assignment>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class Create_coursesStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCourse(Course message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCourse(ContextCourse message) returns grpc:Error? {
        return self.sClient->send(message);
    }
    //isolated remote function receiveCourseCode() returns CourseCodeRecord|grpc:Error? {
    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;//[payload, headers] = response to [payload, _] = response
            return payload.toString();
            //return <CourseCodeRecord>payload;
        }
    }
    //isolated remote function receiveContextCourseCode() returns ContextCourseCode|grpc:Error? {
    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
            //return {content: <CourseCodeRecord>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class CourseServiceCourseCodeCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    // isolated remote function sendCourseCode(CourseCodeRecord response) returns grpc:Error? {
    isolated remote function sendAssignment(Assignment response) returns grpc:Error? {    
        return self.caller->send(response);
    }

    // isolated remote function sendContextCourseCode(ContextCourseCode response) returns grpc:Error? {
    isolated remote function sendContextAssignment(ContextAssignment response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

// public client class CourseServiceNilCaller {
public client class CourseServiceStringCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendString(string response) returns grpc:Error? {//Added after
        return self.caller->send(response);
    }

    isolated remote function sendContextString(wrappers:ContextString response) returns grpc:Error? {//Added after
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class CourseServiceAssignmentCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAssignment(Assignment response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAssignment(ContextAssignment response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextAssignmentStream record {|
    stream<Assignment, error?> content;
    map<string|string[]> headers;
|};

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextSubmitedAssignmentStream record {|//ContextCourseCodeStream to ContextSubmitedAssignmentStream
    stream<SubmitedAssignment, error?> content;//CourseCodeRecord to SubmitedAssignment
    map<string|string[]> headers;
|};

public type ContextMarkStream record {|
    stream<Mark, error?> content;//MarksRecord to Mark
    map<string|string[]> headers;
|};

public type ContextCourseStream record {|
    stream<Course, error?> content;
    map<string|string[]> headers;
|};

public type ContextCourseAssessorStream record {|
    stream<CourseAssessor, error?> content;
    map<string|string[]> headers;
|};

public type ContextAssignment record {|
    Assignment content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextSubmitedAssignment record {|//ContextCourseCode to ContextSubmitedAssignment
    SubmitedAssignment content;//CourseCodeRecord to SubmitedAssignment
    map<string|string[]> headers;
|};

public type ContextMark record {|
    Mark content;
    // MarksRecord content;
    map<string|string[]> headers;
|};

public type ContextCourse record {|
    Course content;
    map<string|string[]> headers;
|};

public type ContextCourseAssessor record {|
    CourseAssessor content;
    map<string|string[]> headers;
|};

public type Assignment record {|
    readonly string assignmentCode;
    float weight;
    // string course_code;
    // string username;
    // string content;
|};

public type User record {|
    string firstname;
    string lastname;
    string email;
    string profile;
    // string username;
    // string password;
    // Profile profile;
|};

// public type AssignmentWeightRecord record {|
//     string name;
//     int weight;
// |};

public type SubmitedAssignment record {|//CourseCodeRecord to SubmitedAssignment
    Course course;
    readonly string userId;
    string content;
    boolean marked;
    
    //string code;
|};

public type Mark record {|//MarksRecord
    readonly string userId;
    Course course;
    int mark;
    // string course_code;
    // string username;
    // int mark;
|};

public type Course record {|
    readonly string courseCode;
    Assignment[] assignments;
    // string name;
    // int assignments;
    //float AssignmentWeight[] assignment_weights = [];
|};

public type CourseAssessor record {|
    string courseCode;
    // string code;
    string assessor;
|};

public enum Profile {
    ADMINISTRATOR,
    ASSESSOR,
    LEARNER
}

const string ROOT_DESCRIPTOR_USER_INFO = "0A0F757365725F696E666F2E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F2280010A06436F7572736512120A046E616D6518012001280952046E616D6512200A0B61737369676E6D656E7473180220012805520B61737369676E6D656E747312400A1261737369676E6D656E745F7765696768747318032003280B32112E41737369676E6D656E74576569676874521161737369676E6D656E745765696768747322200A0A436F75727365436F646512120A04636F64651801200128095204636F646522400A0E436F757273654173736573736F7212120A04636F64651801200128095204636F6465121A0A086173736573736F7218022001280952086173736573736F7222620A0455736572121A0A08757365726E616D651801200128095208757365726E616D65121A0A0870617373776F7264180220012809520870617373776F726412220A0770726F66696C6518032001280E32082E50726F66696C65520770726F66696C6522630A0A41737369676E6D656E74121F0A0B636F757273655F636F6465180120012809520A636F75727365436F6465121A0A08757365726E616D651802200128095208757365726E616D6512180A07636F6E74656E741803200128095207636F6E74656E74223E0A1041737369676E6D656E7457656967687412120A046E616D6518012001280952046E616D6512160A06776569676874180220012805520677656967687422570A044D61726B121F0A0B636F757273655F636F6465180120012809520A636F75727365436F6465121A0A08757365726E616D651802200128095208757365726E616D6512120A046D61726B18032001280552046D61726B2A370A0750726F66696C6512110A0D41444D494E4953545241544F521000120C0A084153534553534F521001120B0A074C4541524E4552100232FD020A0D636F7572736553657276696365122A0A0E6372656174655F636F757273657312072E436F757273651A0B2E436F75727365436F646528013001123B0A0E61737369676E5F636F7572736573120F2E436F757273654173736573736F721A162E676F6F676C652E70726F746F6275662E456D7074792801122F0A0C6372656174655F757365727312052E557365721A162E676F6F676C652E70726F746F6275662E456D7074792801123B0A127375626D69745F61737369676E6D656E7473120B2E41737369676E6D656E741A162E676F6F676C652E70726F746F6275662E456D707479280112310A13726571756573745F61737369676E6D656E7473120B2E436F75727365436F64651A0B2E41737369676E6D656E743001122F0A0C7375626D69745F6D61726B7312052E4D61726B1A162E676F6F676C652E70726F746F6275662E456D707479280112310A087265676973746572120B2E436F75727365436F64651A162E676F6F676C652E70726F746F6275662E456D7074792801620670726F746F33";

public isolated function getDescriptorMapUserInfo() returns map<string> {
    return {"google/protobuf/empty.proto": "0A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F120F676F6F676C652E70726F746F62756622070A05456D70747942540A13636F6D2E676F6F676C652E70726F746F627566420A456D70747950726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33", "user_info.proto": "0A0F757365725F696E666F2E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F2280010A06436F7572736512120A046E616D6518012001280952046E616D6512200A0B61737369676E6D656E7473180220012805520B61737369676E6D656E747312400A1261737369676E6D656E745F7765696768747318032003280B32112E41737369676E6D656E74576569676874521161737369676E6D656E745765696768747322200A0A436F75727365436F646512120A04636F64651801200128095204636F646522400A0E436F757273654173736573736F7212120A04636F64651801200128095204636F6465121A0A086173736573736F7218022001280952086173736573736F7222620A0455736572121A0A08757365726E616D651801200128095208757365726E616D65121A0A0870617373776F7264180220012809520870617373776F726412220A0770726F66696C6518032001280E32082E50726F66696C65520770726F66696C6522630A0A41737369676E6D656E74121F0A0B636F757273655F636F6465180120012809520A636F75727365436F6465121A0A08757365726E616D651802200128095208757365726E616D6512180A07636F6E74656E741803200128095207636F6E74656E74223E0A1041737369676E6D656E7457656967687412120A046E616D6518012001280952046E616D6512160A06776569676874180220012805520677656967687422570A044D61726B121F0A0B636F757273655F636F6465180120012809520A636F75727365436F6465121A0A08757365726E616D651802200128095208757365726E616D6512120A046D61726B18032001280552046D61726B2A370A0750726F66696C6512110A0D41444D494E4953545241544F521000120C0A084153534553534F521001120B0A074C4541524E4552100232FD020A0D636F7572736553657276696365122A0A0E6372656174655F636F757273657312072E436F757273651A0B2E436F75727365436F646528013001123B0A0E61737369676E5F636F7572736573120F2E436F757273654173736573736F721A162E676F6F676C652E70726F746F6275662E456D7074792801122F0A0C6372656174655F757365727312052E557365721A162E676F6F676C652E70726F746F6275662E456D7074792801123B0A127375626D69745F61737369676E6D656E7473120B2E41737369676E6D656E741A162E676F6F676C652E70726F746F6275662E456D707479280112310A13726571756573745F61737369676E6D656E7473120B2E436F75727365436F64651A0B2E41737369676E6D656E743001122F0A0C7375626D69745F6D61726B7312052E4D61726B1A162E676F6F676C652E70726F746F6275662E456D707479280112310A087265676973746572120B2E436F75727365436F64651A162E676F6F676C652E70726F746F6275662E456D7074792801620670726F746F33"};
}

