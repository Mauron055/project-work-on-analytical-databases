--шаг 6
CREATE TABLE IF NOT EXISTS STV2024050734__DWH.s_auth_history (
    hk_l_user_group_activity INT,
    user_id_from INT,
    event VARCHAR(255),
    event_dt TIMESTAMP,
    load_dt DATETIME,
    load_src VARCHAR(20)
);

INSERT INTO STV2024050734__DWH.s_auth_history(hk_l_user_group_activity, user_id_from, event, event_dt, load_dt, load_src)

select
    luga.hk_l_user_group_activity,
    gl.user_id_from,
    gl.event,
    gl.datetime,
    now() as load_dt,
    's3' as load_src
from STV2024050734__STAGING.group_log as gl
left join STV2024050734__DWH.h_groups as hg on gl.group_id = hg.group_id
left join STV2024050734__DWH.h_users as hu on gl.user_id = hu.user_id
left join STV2024050734__DWH.l_user_group_activity as luga on hg.hk_group_id = luga.hk_group_id and hu.hk_user_id = luga.hk_user_id;