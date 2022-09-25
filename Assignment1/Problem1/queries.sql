
-- create database
CREATE DATABASE AssessMgntSys;
CREATE TABLE Users(
    userID INT NOT NULL,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    userProfile VARCHAR(50) NOT NULL,
    PRIMARY KEY (userID)
);

CREATE TABLE Course(
 courseID INT NOT NULL,
 courseName VARCHAR(50) NOT NULL,
 courseAssignmentNumber INT NOT NULL,
 courseAssignmentWeight INT NOT NULL,
 courseAssignmnetID INT NOT NULL,
 PRIMARY KEY (courseID),
 FOREIGN KEY (courseAssignmnetID) REFERENCES SubmittedAssignments(AssignmentID)
);

CREATE TABLE Marks(
    markID INT NOT NULL,
    courseMarkID INT NOT NULL,
    Mark FLOAT NOT NULL,
    AssignmentID INT NOT NULL,
    PRIMARY KEY (markID),
    FOREIGN KEY (markID) REFERENCES Users(userID),
    FOREIGN KEY (courseMarkID) REFERENCES Course(courseID)
    FOREIGN KEY (AssignmentID) REFERENCES SubmittedAssignments(AssignmentID)
);

CREATE TABLE SubmittedAssignments(
    subAssID INT NOT NULL,
    CourseID INT NOT NULL,
    AssignmentID INT NOT NULL,
    SubmissionDate DATE NOT NULL,
    PRIMARY KEY (subAssID),
    FOREIGN KEY (subAssID) REFERENCES Users(userID),
    FOREIGN KEY (CourseID) REFERENCES Course(courseID)
);