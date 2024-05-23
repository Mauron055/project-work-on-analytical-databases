--шаг 2
CREATE TABLE IF NOT EXISTS STV2024050734__STAGING.group_log (
    group_id INT,
    user_id INT,
    user_id_from INT,
    event VARCHAR(255),
    datetime TIMESTAMP
);