drop table if exists employee;
CREATE TABLE EMPLOYEE (
    empId INT,
    name VARCHAR(15),
    dept VARCHAR(10)
);

INSERT INTO EMPLOYEE (empId, name, dept)
VALUES (1, 'Manthan', 'Sales'), (2, 'Sashwat', 'Accounting');
SELECT * FROM EMPLOYEE;