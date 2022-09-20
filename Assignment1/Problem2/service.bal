//import ballerina/io;
//import ballerina/http;
import ballerina/graphql;

# A service representing a network-accessible API
# bound to port `9090`.
service graphql:Service /graphql on new graphql:Listener(4000) {

    resource function get greeting(string name) returns string|error {
        return "Hello, " + name + "!";
    }
}
