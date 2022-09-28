import ballerina/grpc;
import ballerina/protobuf.types.wrappers;

public isolated client class courseServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR_USER_INFO, getDescriptorMapUserInfo());
    }

    isolated remote function assign_courses() returns Assign_coursesStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseService/assign_courses");
        return new Assign_coursesStreamingClient(sClient);
    } 

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseService/create_users");
        return new Create_usersStreamingClient(sClient);
    }

    isolated remote function submit_assignments() returns Submit_assignmentsStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseService/submit_assignments");
        return new Submit_assignmentsStreamingClient(sClient);
    }

    isolated remote function submit_marks() returns Submit_marksStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("courseService/submit_marks");
        return new Submit_marksStreamingClient(sClient);
    }

    isolated remote function request_assignments(string|wrappers:ContextString req) returns stream<Assignment, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("courseService/request_assignments", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        AssignmentStream outputStream = new AssignmentStream(result);
        return new stream<Assignment, grpc:Error?>(outputStream);
    }

    isolated remote function request_assignmentsContext(string|wrappers:ContextString req) returns ContextAssignmentStream|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("courseService/request_assignments", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        AssignmentStream outputStream = new AssignmentStream(result);
        return {content: new stream<Assignment, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function create_courses() returns Create_coursesStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("courseService/create_courses");
        return new Create_coursesStreamingClient(sClient);
    }

    isolated remote function register() returns RegisterStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("courseService/register");
        return new RegisterStreamingClient(sClient);
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

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
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

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
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

    isolated remote function sendSubmitedAssignment(SubmitedAssignment message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextSubmitedAssignment(ContextSubmitedAssignment message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
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

    isolated remote function sendMark(Mark message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextMark(ContextMark message) returns grpc:Error? {
        return self.sClient->send(message);
    }
 
    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
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

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
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

    isolated remote function sendString(string message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextString(wrappers:ContextString message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return payload.toString();
        }
    }

    isolated remote function receiveContextString() returns wrappers:ContextString|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: payload.toString(), headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class CourseServiceStringCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendString(string response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextString(wrappers:ContextString response) returns grpc:Error? {
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

public type ContextSubmitedAssignmentStream record {|
    stream<SubmitedAssignment, error?> content;
    map<string|string[]> headers;
|};

public type ContextMarkStream record {|
    stream<Mark, error?> content;
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

public type ContextSubmitedAssignment record {|
    SubmitedAssignment content;
    map<string|string[]> headers;
|};

public type ContextMark record {|
    Mark content;
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
|};
// public type Course record {|
//     readonly string courseCode;
//     int number_of_assignments;
//     Assignment[] assignments;
// |};
public type User record {|
    readonly string userId;
    string firstName;
    string lastName;
    string email;
    string profile;
|};

public type SubmitedAssignment record {|
    readonly string userId;
    Course course;
    string content;
    boolean marked;
|};

public type Mark record {|
    readonly string userId;
    Course course;
    int mark;
|};

public type Course record {|
    readonly string courseCode;
    int number_of_assignments;
    Assignment[] assignments;
    string assessorId;//newly added
|};

public type CourseAssessor record {|
    readonly string assessorId;//newly added
    string courseCode;
    string assessor;
|};

public enum Profile {
    ADMINISTRATOR,
    ASSESSOR,
    LEARNER
}

const string ROOT_DESCRIPTOR_USER_INFO = "0A0F757365725F696E666F2E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F224C0A0A41737369676E6D656E7412260A0E61737369676E6D656E74436F6465180120012809520E61737369676E6D656E74436F646512160A0677656967687418022001280252067765696768742288010A045573657212160A067573657249641801200128095206757365724964121C0A0966697273744E616D65180220012809520966697273744E616D65121A0A086C6173744E616D6518032001280952086C6173744E616D6512140A05656D61696C1804200128095205656D61696C12180A0770726F66696C65180520012809520770726F66696C65227F0A125375626D6974656441737369676E6D656E74121F0A06636F7572736518012001280B32072E436F757273655206636F7572736512160A06757365724964180220032809520675736572496412180A07636F6E74656E741803200128095207636F6E74656E7412160A066D61726B656418042001280852066D61726B656422530A044D61726B12160A067573657249641801200328095206757365724964121F0A06636F7572736518022001280B32072E436F757273655206636F7572736512120A046D61726B18032001280552046D61726B228B010A06436F75727365121E0A0A636F75727365436F6465180120012809520A636F75727365436F646512320A156E756D6265725F6F665F61737369676E6D656E747318022001280552136E756D6265724F6641737369676E6D656E7473122D0A0B61737369676E6D656E747318032003280B320B2E41737369676E6D656E74520B61737369676E6D656E7473224C0A0E436F757273654173736573736F72121E0A0A636F75727365436F6465180120012809520A636F75727365436F6465121A0A086173736573736F7218022001280952086173736573736F722A370A0750726F66696C6512110A0D41444D494E4953545241544F521000120C0A084153534553534F521001120B0A074C4541524E4552100232D8030A0D636F7572736553657276696365123B0A0E6372656174655F636F757273657312072E436F757273651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801300112410A0E61737369676E5F636F7572736573120F2E436F757273654173736573736F721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112350A0C6372656174655F757365727312052E557365721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112490A127375626D69745F61737369676E6D656E747312132E5375626D6974656441737369676E6D656E741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112420A13726571756573745F61737369676E6D656E7473121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0B2E41737369676E6D656E74300112350A0C7375626D69745F6D61726B7312052E4D61726B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801124A0A087265676973746572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756528013001620670726F746F33";

public isolated function getDescriptorMapUserInfo() returns map<string> {
    return {"google/protobuf/wrappers.proto": "0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33", "user_info.proto": "0A0F757365725F696E666F2E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F224C0A0A41737369676E6D656E7412260A0E61737369676E6D656E74436F6465180120012809520E61737369676E6D656E74436F646512160A0677656967687418022001280252067765696768742288010A045573657212160A067573657249641801200128095206757365724964121C0A0966697273744E616D65180220012809520966697273744E616D65121A0A086C6173744E616D6518032001280952086C6173744E616D6512140A05656D61696C1804200128095205656D61696C12180A0770726F66696C65180520012809520770726F66696C65227F0A125375626D6974656441737369676E6D656E74121F0A06636F7572736518012001280B32072E436F757273655206636F7572736512160A06757365724964180220032809520675736572496412180A07636F6E74656E741803200128095207636F6E74656E7412160A066D61726B656418042001280852066D61726B656422530A044D61726B12160A067573657249641801200328095206757365724964121F0A06636F7572736518022001280B32072E436F757273655206636F7572736512120A046D61726B18032001280552046D61726B228B010A06436F75727365121E0A0A636F75727365436F6465180120012809520A636F75727365436F646512320A156E756D6265725F6F665F61737369676E6D656E747318022001280552136E756D6265724F6641737369676E6D656E7473122D0A0B61737369676E6D656E747318032003280B320B2E41737369676E6D656E74520B61737369676E6D656E7473224C0A0E436F757273654173736573736F72121E0A0A636F75727365436F6465180120012809520A636F75727365436F6465121A0A086173736573736F7218022001280952086173736573736F722A370A0750726F66696C6512110A0D41444D494E4953545241544F521000120C0A084153534553534F521001120B0A074C4541524E4552100232D8030A0D636F7572736553657276696365123B0A0E6372656174655F636F757273657312072E436F757273651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801300112410A0E61737369676E5F636F7572736573120F2E436F757273654173736573736F721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112350A0C6372656174655F757365727312052E557365721A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112490A127375626D69745F61737369676E6D656E747312132E5375626D6974656441737369676E6D656E741A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112420A13726571756573745F61737369676E6D656E7473121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A0B2E41737369676E6D656E74300112350A0C7375626D69745F6D61726B7312052E4D61726B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801124A0A087265676973746572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756528013001620670726F746F33"};
}

