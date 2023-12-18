# term-project-placeholder_name2
This is a shared directory for the term project. Please pull the project and create a different branch if you push your changes back to the repo. 

Here are a few things you might want to know: 
- this project is built with Java compiler 11 (right-click on the project name, select Properties, and select Java Compiler to see the current compiler)
- before running the application on your local server, change the "_PROP_FILENAME_OSX_LOCAL" to the location of the config.properties file of this project on your computer. (Right-click on the config file, select Properties and copy its location)  


database information
ec2-34-238-172-16.compute-1.amazonaws.com


CREATE TABLE user_info (
    username VARCHAR(30) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    fname VARCHAR(30) NOT NULL,
    lname VARCHAR(30) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    email VARCHAR(30) NOT NULL
);

CREATE TABLE machines (
    machine_id INT PRIMARY KEY AUTO_INCREMENT,
    makemodel VARCHAR(30) NOT NULL,
    runtime INT NOT NULL
);

CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    machine_id INT,
    username VARCHAR(30),
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (machine_id) REFERENCES machines(machine_id),
    FOREIGN KEY (username) REFERENCES user_info(username)
);

INSERT INTO user_info (username, password, fname, lname, phone, email) 
VALUES (‘test’, ‘pwd’, ‘test’, ‘test’, ‘000-000-0000’, ‘test@email.com’);

INSERT INTO user_info (username, password, fname, lname, phone, email)
    VALUES (‘jsmith’, ‘pwd’, ‘john’, ‘smith’, ‘000-000-0000’, ‘jsmith@email.com’);

INSERT INTO user_info (username, password, fname, lname, phone, email)
    VALUES (‘jdoe’, ‘pwd’, jane, doe, ‘000-000-0000’, jdoe@email.com’);

INSERT INTO machines (makemodel, runtime)
    VALUES (‘test-washer-1’, 30);

INSERT INTO machines (makemodel, runtime)
    VALUES (‘test-washer-2’, 30);

INSERT INTO machines (makemodel, runtime)
    VALUES (‘test-washer-3’, 30);

INSERT INTO machines (makemodel, runtime)
    VALUES (‘test-dryer-1’, 30);

INSERT INTO machines (makemodel, runtime)
    VALUES (‘test-dryer-2’, 30);

INSERT INTO machines (makemodel, runtime)
    VALUES (‘test-dryer-3’, 30);

INSERT INTO reservations(machine_id, username, start_time, end_time)
    VALUES (1, ‘jsmith’, ‘2023-11-16 9:00:00’, ‘2023-11-16 9:30:00’);

INSERT INTO reservations(machine_id, username, start_time, end_time)
    VALUES (1, ‘jdoe’, ‘2023-11-16 13:00:00’, ‘2023-11-16 13:30:00’);

INSERT INTO reservations(machine_id, username, start_time, end_time)
    VALUES (2, ‘jsmith’, ‘2023-11-16 13:00:00’, ‘2023-11-16-13:30:00’);

INSERT INTO reservations(machine_id, username, start_time, end_time)
    VALUES (3, ‘jdoe’, ‘2023-11-16 13:15:00’, ‘2023-11-16 13:45:00’);

INSERT INTO reservations(machine_id, username, start_time, end_time)
    VALUES (1, ‘jsmith’, ‘2023-11-17 9:15:00’, ‘2023-11-16 9:45:00’);
