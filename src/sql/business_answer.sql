--шаг 7
with user_group_log as (
    select 
        hg.hk_group_id,
        count(distinct s.hk_l_user_group_activity) as cnt_added_users
    from STV2024050734__DWH.h_groups as hg
    left join STV2024050734__DWH.s_auth_history as s on hg.hk_group_id = s.hk_l_user_group_activity
    where s.event = 'add'
    group by hg.hk_group_id
),
user_group_messages as (
    select 
        hg.hk_group_id,
        count(distinct lum.hk_user_id) as cnt_users_in_group_with_messages
    from STV2024050734__DWH.h_groups as hg
    left join STV2024050734__DWH.l_user_message as lum on hg.hk_group_id = lum.hk_message_id
    group by hg.hk_group_id
)
select  
    ugl.hk_group_id,
    ugl.cnt_added_users,
    ugm.cnt_users_in_group_with_messages,
    ugm.cnt_users_in_group_with_messages / ugl.cnt_added_users as group_conversion
from user_group_log as ugl
left join user_group_messages as ugm on ugl.hk_group_id = ugm.hk_group_id
order by ugm.cnt_users_in_group_with_messages / ugl.cnt_added_users desc
limit 10;
