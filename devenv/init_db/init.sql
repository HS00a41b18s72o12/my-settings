CREATE TABLE IF NOT EXISTS test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO test_table (user_name) VALUES ('Alice');
INSERT INTO test_table (user_name) VALUES ('Bob');