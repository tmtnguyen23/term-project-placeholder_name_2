# term-project-placeholder_name_2
This is a shared directory for the term project. Please pull the project and create a different branch if you push your changes back to the repo. 

Here are a few things you might want to know: 
- this project is built with Java compiler 17 (right-click on the project name, select Properties, and select Java Compiler to see the current compiler)
- before running the application on your local server, change the "_PROP_FILENAME_OSX_LOCAL" to the location of the config.properties file of this project on your computer. (Right-click on the config file, select Properties and copy its location)  


database information
ec2-34-238-172-16.compute-1.amazonaws.com
CREATE TABLE user_info (
  username VARCHAR(30) PRIMARY KEY,
  password VARCHAR(30),
  fname VARCHAR(30),
  lname VARCHAR(30),
  phone VARCHAR(10),
  address VARCHAR(50)
);

CREATE TABLE reservations (
  machinename VARCHAR(30) PRIMARY KEY,
  username VARCHAR(30),
  datetime_start DATETIME,
  datetime_end DATETIME,
  FOREIGN KEY (username) REFERENCES user_info(username)
);

CREATE TABLE washers_dryers (
  machinename VARCHAR(30),
  makemodel VARCHAR(30),
  yearbought VARCHAR(10),
  loadsize VARCHAR(30),
  availability BOOLEAN,
  FOREIGN KEY (machinename) REFERENCES reservations(machinename)
);
