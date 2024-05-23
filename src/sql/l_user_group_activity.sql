--шаг 4
CREATE TABLE STV2024050734__DWH.l_user_group_activity (
    hk_l_user_group_activity INT PRIMARY KEY,
    hk_user_id INT REFERENCES STV2024050734__DWH.h_users(hk_user_id),
    hk_group_id INT REFERENCES STV2024050734__DWH.h_groups(hk_group_id),
    load_dt DATETIME,
    load_src VARCHAR(20)
);