-- Drop the table if it already exists so we can recreate it cleanly
DROP TABLE IF EXISTS RBU;

-- Create the table
CREATE TABLE RBU (
    empld INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    dept TEXT NOT NULL
);

-- Insert records (Note: leading zeros in integers are ignored by the database)
INSERT INTO RBU VALUES (1, 'Chaitanya Deo', 'Sales');
INSERT INTO RBU VALUES (2, 'Varun Gharote', 'INDUSTRY EXECUTIVE');
INSERT INTO RBU VALUES (3, 'Siddhi Narwade', 'EXECUTIVE');

-- Fetch records
SELECT * FROM RBU WHERE dept = 'SMART';