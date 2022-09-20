create project folder
create protocol buffer(structure of gRPC service)
generate the server service sample code
generate the client service sample code
run the server
run the client

* create_courses, where an administrator creates several courses, defines the number of assignments for each course and sets the weight for each assignment. This operation returns the code for each created course. It is bidirectional streaming;
* assign_courses, where an administrator assigns each created course to an assessor;
* create_users, where several users, each with a specific profile, are created. The users are streamed to the server, and the response is returned once the operation completes;
* submit_assignments, where a learner submits one or several assignments for one or multiple courses he/she registered for. The assignments are streamed to the server, and the response is received once the operation completes;
* request_assignments, where an assessor requests submitted assignments for a course he/she has been allocated. Note that an assignment can be marked only once. The function should stream back all assignments that have not been marked yet;
* submit_marks, where an assessor submits the marks for assignments;
* register, where a learner registers for one or several courses. All the courses are streamed to the server, and the result is returned once the operation completes;

Your task is to define a protocol buffer contract with the remote functions and implement both the client and the server in the **Ballerina Language**.