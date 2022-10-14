import ballerina/grpc;
import ballerina/protobuf.types.wrappers;

public isolated client class CourseClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR_COURSE, getDescriptorMapCourse());
    }

    isolated remote function assign_courses(AssignCoursesMessage|ContextAssignCoursesMessage req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        AssignCoursesMessage message;
        if req is ContextAssignCoursesMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Course/assign_courses", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function assign_coursesContext(AssignCoursesMessage|ContextAssignCoursesMessage req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        AssignCoursesMessage message;
        if req is ContextAssignCoursesMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Course/assign_courses", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function submit_marks(SubmitMarksMessage|ContextSubmitMarksMessage req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        SubmitMarksMessage message;
        if req is ContextSubmitMarksMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Course/submit_marks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function submit_marksContext(SubmitMarksMessage|ContextSubmitMarksMessage req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        SubmitMarksMessage message;
        if req is ContextSubmitMarksMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Course/submit_marks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function create_users() returns Create_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Course/create_users");
        return new Create_usersStreamingClient(sClient);
    }

    isolated remote function submit_assignments() returns Submit_assignmentsStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Course/submit_assignments");
        return new Submit_assignmentsStreamingClient(sClient);
    }

    isolated remote function request_assignments(string|wrappers:ContextString req) returns stream<SubmittedAssignmentMessage, grpc:Error?>|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("Course/request_assignments", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        SubmittedAssignmentMessageStream outputStream = new SubmittedAssignmentMessageStream(result);
        return new stream<SubmittedAssignmentMessage, grpc:Error?>(outputStream);
    }

    isolated remote function request_assignmentsContext(string|wrappers:ContextString req) returns ContextSubmittedAssignmentMessageStream|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeServerStreaming("Course/request_assignments", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        SubmittedAssignmentMessageStream outputStream = new SubmittedAssignmentMessageStream(result);
        return {content: new stream<SubmittedAssignmentMessage, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function create_courses() returns Create_coursesStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("Course/create_courses");
        return new Create_coursesStreamingClient(sClient);
    }

    isolated remote function register() returns RegisterStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("Course/register");
        return new RegisterStreamingClient(sClient);
    }
}

public client class Create_usersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUserMessage(UserMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUserMessage(ContextUserMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
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

    isolated remote function sendSubmitAssignmentMessage(SubmitAssignmentMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextSubmitAssignmentMessage(ContextSubmitAssignmentMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
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

public class SubmittedAssignmentMessageStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|SubmittedAssignmentMessage value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|SubmittedAssignmentMessage value;|} nextRecord = {value: <SubmittedAssignmentMessage>streamValue.value};
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

    isolated remote function sendCourseMessage(CourseMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCourseMessage(ContextCourseMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
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

    isolated remote function sendRegisterMessage(RegisterMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextRegisterMessage(ContextRegisterMessage message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveString() returns string|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
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

public client class CourseStringCaller {
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

public client class CourseSubmittedAssignmentMessageCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSubmittedAssignmentMessage(SubmittedAssignmentMessage response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSubmittedAssignmentMessage(ContextSubmittedAssignmentMessage response) returns grpc:Error? {
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

public type ContextSubmitAssignmentMessageStream record {|
    stream<SubmitAssignmentMessage, error?> content;
    map<string|string[]> headers;
|};

public type ContextSubmittedAssignmentMessageStream record {|
    stream<SubmittedAssignmentMessage, error?> content;
    map<string|string[]> headers;
|};

public type ContextUserMessageStream record {|
    stream<UserMessage, error?> content;
    map<string|string[]> headers;
|};

public type ContextRegisterMessageStream record {|
    stream<RegisterMessage, error?> content;
    map<string|string[]> headers;
|};

public type ContextCourseMessageStream record {|
    stream<CourseMessage, error?> content;
    map<string|string[]> headers;
|};

public type ContextSubmitMarksMessage record {|
    SubmitMarksMessage content;
    map<string|string[]> headers;
|};

public type ContextSubmitAssignmentMessage record {|
    SubmitAssignmentMessage content;
    map<string|string[]> headers;
|};

public type ContextSubmittedAssignmentMessage record {|
    SubmittedAssignmentMessage content;
    map<string|string[]> headers;
|};

public type ContextAssignCoursesMessage record {|
    AssignCoursesMessage content;
    map<string|string[]> headers;
|};

public type ContextUserMessage record {|
    UserMessage content;
    map<string|string[]> headers;
|};

public type ContextRegisterMessage record {|
    RegisterMessage content;
    map<string|string[]> headers;
|};

public type ContextCourseMessage record {|
    CourseMessage content;
    map<string|string[]> headers;
|};

public type AssignmentMessage record {|
    readonly string assignmentCode;// = "";
    string content;// = "";
    boolean marked = false;
|};

public type Assignment record {|
    readonly string assignmentCode;// = "";
    float weight;// = 0.0;
|};

public type SubmitMarksMessage record {|
    readonly string submissionId;// = "";
    float marks;// = 0.0;
|};

public type SubmitAssignmentMessage record {|
    readonly string submissionId;// = "";
    string userId;// = "";
    string courseCode;// = "";
    string content;// = "";
    boolean marked = false;
|};

public type SubmittedAssignmentMessage record {|
    SubmitAssignmentMessage subass;// = {};
|};

public type AssignCoursesMessage record {|
    readonly string courseCode;// = "";
    string assessorId;// = "";
|};

public type CourseSelection record {|
    string[] courseCode;// = [];
    string courseName;// = "";
|};

public type UserMessage record {|
    readonly string userId;// = "";
    string firstName;// = "";
    string lastName;// = "";
    string email;// = "";
    string profile;// = "";
|};

public type RegisterMessage record {|
    readonly string userId;// = "";
    string courses;// = "";
|};

public type CourseMessage record {|
    readonly string courseCode;// = "";
    int numberOfAssignments;// = 0;
    string assignmentCode;// = "";
    float weight;// = 0.0;
|};

public enum Profile {
    ADMINISTRATOR,
    ASSESSOR,
    LEARNER
}

const string ROOT_DESCRIPTOR_COURSE = "0A0C636F757273652E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22A1010A0D436F757273654D657373616765121E0A0A636F75727365436F6465180120012809520A636F75727365436F646512300A136E756D6265724F6641737369676E6D656E747318022001280552136E756D6265724F6641737369676E6D656E747312260A0E61737369676E6D656E74436F6465180320012809520E61737369676E6D656E74436F646512160A067765696768741804200128025206776569676874228F010A0B557365724D65737361676512160A067573657249641801200128095206757365724964121C0A0966697273744E616D65180220012809520966697273744E616D65121A0A086C6173744E616D6518032001280952086C6173744E616D6512140A05656D61696C1804200128095205656D61696C12180A0770726F66696C65180520012809520770726F66696C6522A7010A175375626D697441737369676E6D656E744D65737361676512220A0C7375626D697373696F6E4964180120012809520C7375626D697373696F6E496412160A067573657249641802200128095206757365724964121E0A0A636F75727365436F6465180320012809520A636F75727365436F646512180A07636F6E74656E741804200128095207636F6E74656E7412160A066D61726B656418052001280852066D61726B6564224E0A1A5375626D697474656441737369676E6D656E744D65737361676512300A0673756261737318012001280B32182E5375626D697441737369676E6D656E744D657373616765520673756261737322560A1441737369676E436F75727365734D657373616765121E0A0A636F75727365436F6465180120012809520A636F75727365436F6465121E0A0A6173736573736F724964180220012809520A6173736573736F724964224E0A125375626D69744D61726B734D65737361676512220A0C7375626D697373696F6E4964180120012809520C7375626D697373696F6E496412140A056D61726B7318022001280252056D61726B7322510A0F436F7572736553656C656374696F6E121E0A0A636F75727365436F6465180120032809520A636F75727365436F6465121E0A0A636F757273654E616D65180220012809520A636F757273654E616D6522430A0F52656769737465724D65737361676512160A06757365724964180120012809520675736572496412180A07636F75727365731802200128095207636F7572736573226D0A1141737369676E6D656E744D65737361676512260A0E61737369676E6D656E74436F6465180120012809520E61737369676E6D656E74436F646512180A07636F6E74656E741802200128095207636F6E74656E7412160A066D61726B656418032001280852066D61726B6564224C0A0A41737369676E6D656E7412260A0E61737369676E6D656E74436F6465180120012809520E61737369676E6D656E74436F646512160A0677656967687418022001280252067765696768742A370A0750726F66696C6512110A0D41444D494E4953545241544F521000120C0A084153534553534F521001120B0A074C4541524E4552100232F8030A06436F7572736512420A0E6372656174655F636F7572736573120E2E436F757273654D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801300112450A0E61737369676E5F636F757273657312152E41737369676E436F75727365734D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123C0A0C6372656174655F7573657273120C2E557365724D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801124E0A127375626D69745F61737369676E6D656E747312182E5375626D697441737369676E6D656E744D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112520A13726571756573745F61737369676E6D656E7473121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1B2E5375626D697474656441737369676E6D656E744D657373616765300112410A0C7375626D69745F6D61726B7312132E5375626D69744D61726B734D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123E0A08726567697374657212102E52656769737465724D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756528013001620670726F746F33";

public isolated function getDescriptorMapCourse() returns map<string> {
    return {"course.proto": "0A0C636F757273652E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22A1010A0D436F757273654D657373616765121E0A0A636F75727365436F6465180120012809520A636F75727365436F646512300A136E756D6265724F6641737369676E6D656E747318022001280552136E756D6265724F6641737369676E6D656E747312260A0E61737369676E6D656E74436F6465180320012809520E61737369676E6D656E74436F646512160A067765696768741804200128025206776569676874228F010A0B557365724D65737361676512160A067573657249641801200128095206757365724964121C0A0966697273744E616D65180220012809520966697273744E616D65121A0A086C6173744E616D6518032001280952086C6173744E616D6512140A05656D61696C1804200128095205656D61696C12180A0770726F66696C65180520012809520770726F66696C6522A7010A175375626D697441737369676E6D656E744D65737361676512220A0C7375626D697373696F6E4964180120012809520C7375626D697373696F6E496412160A067573657249641802200128095206757365724964121E0A0A636F75727365436F6465180320012809520A636F75727365436F646512180A07636F6E74656E741804200128095207636F6E74656E7412160A066D61726B656418052001280852066D61726B6564224E0A1A5375626D697474656441737369676E6D656E744D65737361676512300A0673756261737318012001280B32182E5375626D697441737369676E6D656E744D657373616765520673756261737322560A1441737369676E436F75727365734D657373616765121E0A0A636F75727365436F6465180120012809520A636F75727365436F6465121E0A0A6173736573736F724964180220012809520A6173736573736F724964224E0A125375626D69744D61726B734D65737361676512220A0C7375626D697373696F6E4964180120012809520C7375626D697373696F6E496412140A056D61726B7318022001280252056D61726B7322510A0F436F7572736553656C656374696F6E121E0A0A636F75727365436F6465180120032809520A636F75727365436F6465121E0A0A636F757273654E616D65180220012809520A636F757273654E616D6522430A0F52656769737465724D65737361676512160A06757365724964180120012809520675736572496412180A07636F75727365731802200128095207636F7572736573226D0A1141737369676E6D656E744D65737361676512260A0E61737369676E6D656E74436F6465180120012809520E61737369676E6D656E74436F646512180A07636F6E74656E741802200128095207636F6E74656E7412160A066D61726B656418032001280852066D61726B6564224C0A0A41737369676E6D656E7412260A0E61737369676E6D656E74436F6465180120012809520E61737369676E6D656E74436F646512160A0677656967687418022001280252067765696768742A370A0750726F66696C6512110A0D41444D494E4953545241544F521000120C0A084153534553534F521001120B0A074C4541524E4552100232F8030A06436F7572736512420A0E6372656174655F636F7572736573120E2E436F757273654D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801300112450A0E61737369676E5F636F757273657312152E41737369676E436F75727365734D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123C0A0C6372656174655F7573657273120C2E557365724D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C75652801124E0A127375626D69745F61737369676E6D656E747312182E5375626D697441737369676E6D656E744D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565280112520A13726571756573745F61737369676E6D656E7473121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1B2E5375626D697474656441737369676E6D656E744D657373616765300112410A0C7375626D69745F6D61726B7312132E5375626D69744D61726B734D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123E0A08726567697374657212102E52656769737465724D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C756528013001620670726F746F33", "google/protobuf/wrappers.proto": "0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"};
}

