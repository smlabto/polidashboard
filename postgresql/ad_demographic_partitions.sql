CREATE TABLE ad_demographic_al PARTITION OF ad_demographic 
    FOR VALUES IN ('al');

CREATE INDEX idx_ad_demographic_al_i ON ad_demographic_al (id);

CREATE INDEX idx_ad_demographic_al_i_g_ar ON ad_demographic_al (id, gender, age_range);

CREATE INDEX idx_ad_demographic_al_bn ON ad_demographic_al (bylines_name);

CREATE INDEX idx_ad_demographic_al_adst_adst_g_ar ON ad_demographic_al (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_al_bn_adst_adst ON ad_demographic_al (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_am PARTITION OF ad_demographic 
    FOR VALUES IN ('am');

CREATE INDEX idx_ad_demographic_am_i ON ad_demographic_am (id);

CREATE INDEX idx_ad_demographic_am_i_g_ar ON ad_demographic_am (id, gender, age_range);

CREATE INDEX idx_ad_demographic_am_bn ON ad_demographic_am (bylines_name);

CREATE INDEX idx_ad_demographic_am_adst_adst_g_ar ON ad_demographic_am (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_am_bn_adst_adst ON ad_demographic_am (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_at PARTITION OF ad_demographic 
    FOR VALUES IN ('at');

CREATE INDEX idx_ad_demographic_at_i ON ad_demographic_at (id);

CREATE INDEX idx_ad_demographic_at_i_g_ar ON ad_demographic_at (id, gender, age_range);

CREATE INDEX idx_ad_demographic_at_bn ON ad_demographic_at (bylines_name);

CREATE INDEX idx_ad_demographic_at_adst_adst_g_ar ON ad_demographic_at (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_at_bn_adst_adst ON ad_demographic_at (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_au PARTITION OF ad_demographic 
    FOR VALUES IN ('au');

CREATE INDEX idx_ad_demographic_au_i ON ad_demographic_au (id);

CREATE INDEX idx_ad_demographic_au_i_g_ar ON ad_demographic_au (id, gender, age_range);

CREATE INDEX idx_ad_demographic_au_bn ON ad_demographic_au (bylines_name);

CREATE INDEX idx_ad_demographic_au_adst_adst_g_ar ON ad_demographic_au (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_au_bn_adst_adst ON ad_demographic_au (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_az PARTITION OF ad_demographic 
    FOR VALUES IN ('az');

CREATE INDEX idx_ad_demographic_az_i ON ad_demographic_az (id);

CREATE INDEX idx_ad_demographic_az_i_g_ar ON ad_demographic_az (id, gender, age_range);

CREATE INDEX idx_ad_demographic_az_bn ON ad_demographic_az (bylines_name);

CREATE INDEX idx_ad_demographic_az_adst_adst_g_ar ON ad_demographic_az (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_az_bn_adst_adst ON ad_demographic_az (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_bd PARTITION OF ad_demographic 
    FOR VALUES IN ('bd');

CREATE INDEX idx_ad_demographic_bd_i ON ad_demographic_bd (id);

CREATE INDEX idx_ad_demographic_bd_i_g_ar ON ad_demographic_bd (id, gender, age_range);

CREATE INDEX idx_ad_demographic_bd_bn ON ad_demographic_bd (bylines_name);

CREATE INDEX idx_ad_demographic_bd_adst_adst_g_ar ON ad_demographic_bd (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_bd_bn_adst_adst ON ad_demographic_bd (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_be PARTITION OF ad_demographic 
    FOR VALUES IN ('be');

CREATE INDEX idx_ad_demographic_be_i ON ad_demographic_be (id);

CREATE INDEX idx_ad_demographic_be_i_g_ar ON ad_demographic_be (id, gender, age_range);

CREATE INDEX idx_ad_demographic_be_bn ON ad_demographic_be (bylines_name);

CREATE INDEX idx_ad_demographic_be_adst_adst_g_ar ON ad_demographic_be (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_be_bn_adst_adst ON ad_demographic_be (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_bg PARTITION OF ad_demographic 
    FOR VALUES IN ('bg');

CREATE INDEX idx_ad_demographic_bg_i ON ad_demographic_bg (id);

CREATE INDEX idx_ad_demographic_bg_i_g_ar ON ad_demographic_bg (id, gender, age_range);

CREATE INDEX idx_ad_demographic_bg_bn ON ad_demographic_bg (bylines_name);

CREATE INDEX idx_ad_demographic_bg_adst_adst_g_ar ON ad_demographic_bg (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_bg_bn_adst_adst ON ad_demographic_bg (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_br PARTITION OF ad_demographic 
    FOR VALUES IN ('br');

CREATE INDEX idx_ad_demographic_br_i ON ad_demographic_br (id);

CREATE INDEX idx_ad_demographic_br_i_g_ar ON ad_demographic_br (id, gender, age_range);

CREATE INDEX idx_ad_demographic_br_bn ON ad_demographic_br (bylines_name);

CREATE INDEX idx_ad_demographic_br_adst_adst_g_ar ON ad_demographic_br (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_br_bn_adst_adst ON ad_demographic_br (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ca PARTITION OF ad_demographic 
    FOR VALUES IN ('ca');

CREATE INDEX idx_ad_demographic_ca_i ON ad_demographic_ca (id);

CREATE INDEX idx_ad_demographic_ca_i_g_ar ON ad_demographic_ca (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ca_bn ON ad_demographic_ca (bylines_name);

CREATE INDEX idx_ad_demographic_ca_adst_adst_g_ar ON ad_demographic_ca (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ca_bn_adst_adst ON ad_demographic_ca (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_cd PARTITION OF ad_demographic 
    FOR VALUES IN ('cd');

CREATE INDEX idx_ad_demographic_cd_i ON ad_demographic_cd (id);

CREATE INDEX idx_ad_demographic_cd_i_g_ar ON ad_demographic_cd (id, gender, age_range);

CREATE INDEX idx_ad_demographic_cd_bn ON ad_demographic_cd (bylines_name);

CREATE INDEX idx_ad_demographic_cd_adst_adst_g_ar ON ad_demographic_cd (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_cd_bn_adst_adst ON ad_demographic_cd (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ch PARTITION OF ad_demographic 
    FOR VALUES IN ('ch');

CREATE INDEX idx_ad_demographic_ch_i ON ad_demographic_ch (id);

CREATE INDEX idx_ad_demographic_ch_i_g_ar ON ad_demographic_ch (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ch_bn ON ad_demographic_ch (bylines_name);

CREATE INDEX idx_ad_demographic_ch_adst_adst_g_ar ON ad_demographic_ch (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ch_bn_adst_adst ON ad_demographic_ch (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_co PARTITION OF ad_demographic 
    FOR VALUES IN ('co');

CREATE INDEX idx_ad_demographic_co_i ON ad_demographic_co (id);

CREATE INDEX idx_ad_demographic_co_i_g_ar ON ad_demographic_co (id, gender, age_range);

CREATE INDEX idx_ad_demographic_co_bn ON ad_demographic_co (bylines_name);

CREATE INDEX idx_ad_demographic_co_adst_adst_g_ar ON ad_demographic_co (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_co_bn_adst_adst ON ad_demographic_co (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_cr PARTITION OF ad_demographic 
    FOR VALUES IN ('cr');

CREATE INDEX idx_ad_demographic_cr_i ON ad_demographic_cr (id);

CREATE INDEX idx_ad_demographic_cr_i_g_ar ON ad_demographic_cr (id, gender, age_range);

CREATE INDEX idx_ad_demographic_cr_bn ON ad_demographic_cr (bylines_name);

CREATE INDEX idx_ad_demographic_cr_adst_adst_g_ar ON ad_demographic_cr (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_cr_bn_adst_adst ON ad_demographic_cr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_cy PARTITION OF ad_demographic 
    FOR VALUES IN ('cy');

CREATE INDEX idx_ad_demographic_cy_i ON ad_demographic_cy (id);

CREATE INDEX idx_ad_demographic_cy_i_g_ar ON ad_demographic_cy (id, gender, age_range);

CREATE INDEX idx_ad_demographic_cy_bn ON ad_demographic_cy (bylines_name);

CREATE INDEX idx_ad_demographic_cy_adst_adst_g_ar ON ad_demographic_cy (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_cy_bn_adst_adst ON ad_demographic_cy (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_cz PARTITION OF ad_demographic 
    FOR VALUES IN ('cz');

CREATE INDEX idx_ad_demographic_cz_i ON ad_demographic_cz (id);

CREATE INDEX idx_ad_demographic_cz_i_g_ar ON ad_demographic_cz (id, gender, age_range);

CREATE INDEX idx_ad_demographic_cz_bn ON ad_demographic_cz (bylines_name);

CREATE INDEX idx_ad_demographic_cz_adst_adst_g_ar ON ad_demographic_cz (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_cz_bn_adst_adst ON ad_demographic_cz (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_de PARTITION OF ad_demographic 
    FOR VALUES IN ('de');

CREATE INDEX idx_ad_demographic_de_i ON ad_demographic_de (id);

CREATE INDEX idx_ad_demographic_de_i_g_ar ON ad_demographic_de (id, gender, age_range);

CREATE INDEX idx_ad_demographic_de_bn ON ad_demographic_de (bylines_name);

CREATE INDEX idx_ad_demographic_de_adst_adst_g_ar ON ad_demographic_de (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_de_bn_adst_adst ON ad_demographic_de (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_dk PARTITION OF ad_demographic 
    FOR VALUES IN ('dk');

CREATE INDEX idx_ad_demographic_dk_i ON ad_demographic_dk (id);

CREATE INDEX idx_ad_demographic_dk_i_g_ar ON ad_demographic_dk (id, gender, age_range);

CREATE INDEX idx_ad_demographic_dk_bn ON ad_demographic_dk (bylines_name);

CREATE INDEX idx_ad_demographic_dk_adst_adst_g_ar ON ad_demographic_dk (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_dk_bn_adst_adst ON ad_demographic_dk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_dz PARTITION OF ad_demographic 
    FOR VALUES IN ('dz');

CREATE INDEX idx_ad_demographic_dz_i ON ad_demographic_dz (id);

CREATE INDEX idx_ad_demographic_dz_i_g_ar ON ad_demographic_dz (id, gender, age_range);

CREATE INDEX idx_ad_demographic_dz_bn ON ad_demographic_dz (bylines_name);

CREATE INDEX idx_ad_demographic_dz_adst_adst_g_ar ON ad_demographic_dz (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_dz_bn_adst_adst ON ad_demographic_dz (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ee PARTITION OF ad_demographic 
    FOR VALUES IN ('ee');

CREATE INDEX idx_ad_demographic_ee_i ON ad_demographic_ee (id);

CREATE INDEX idx_ad_demographic_ee_i_g_ar ON ad_demographic_ee (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ee_bn ON ad_demographic_ee (bylines_name);

CREATE INDEX idx_ad_demographic_ee_adst_adst_g_ar ON ad_demographic_ee (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ee_bn_adst_adst ON ad_demographic_ee (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_eg PARTITION OF ad_demographic 
    FOR VALUES IN ('eg');

CREATE INDEX idx_ad_demographic_eg_i ON ad_demographic_eg (id);

CREATE INDEX idx_ad_demographic_eg_i_g_ar ON ad_demographic_eg (id, gender, age_range);

CREATE INDEX idx_ad_demographic_eg_bn ON ad_demographic_eg (bylines_name);

CREATE INDEX idx_ad_demographic_eg_adst_adst_g_ar ON ad_demographic_eg (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_eg_bn_adst_adst ON ad_demographic_eg (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_es PARTITION OF ad_demographic 
    FOR VALUES IN ('es');

CREATE INDEX idx_ad_demographic_es_i ON ad_demographic_es (id);

CREATE INDEX idx_ad_demographic_es_i_g_ar ON ad_demographic_es (id, gender, age_range);

CREATE INDEX idx_ad_demographic_es_bn ON ad_demographic_es (bylines_name);

CREATE INDEX idx_ad_demographic_es_adst_adst_g_ar ON ad_demographic_es (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_es_bn_adst_adst ON ad_demographic_es (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_fi PARTITION OF ad_demographic 
    FOR VALUES IN ('fi');

CREATE INDEX idx_ad_demographic_fi_i ON ad_demographic_fi (id);

CREATE INDEX idx_ad_demographic_fi_i_g_ar ON ad_demographic_fi (id, gender, age_range);

CREATE INDEX idx_ad_demographic_fi_bn ON ad_demographic_fi (bylines_name);

CREATE INDEX idx_ad_demographic_fi_adst_adst_g_ar ON ad_demographic_fi (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_fi_bn_adst_adst ON ad_demographic_fi (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_fr PARTITION OF ad_demographic 
    FOR VALUES IN ('fr');

CREATE INDEX idx_ad_demographic_fr_i ON ad_demographic_fr (id);

CREATE INDEX idx_ad_demographic_fr_i_g_ar ON ad_demographic_fr (id, gender, age_range);

CREATE INDEX idx_ad_demographic_fr_bn ON ad_demographic_fr (bylines_name);

CREATE INDEX idx_ad_demographic_fr_adst_adst_g_ar ON ad_demographic_fr (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_fr_bn_adst_adst ON ad_demographic_fr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_gb PARTITION OF ad_demographic 
    FOR VALUES IN ('gb');

CREATE INDEX idx_ad_demographic_gb_i ON ad_demographic_gb (id);

CREATE INDEX idx_ad_demographic_gb_i_g_ar ON ad_demographic_gb (id, gender, age_range);

CREATE INDEX idx_ad_demographic_gb_bn ON ad_demographic_gb (bylines_name);

CREATE INDEX idx_ad_demographic_gb_adst_adst_g_ar ON ad_demographic_gb (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_gb_bn_adst_adst ON ad_demographic_gb (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ge PARTITION OF ad_demographic 
    FOR VALUES IN ('ge');

CREATE INDEX idx_ad_demographic_ge_i ON ad_demographic_ge (id);

CREATE INDEX idx_ad_demographic_ge_i_g_ar ON ad_demographic_ge (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ge_bn ON ad_demographic_ge (bylines_name);

CREATE INDEX idx_ad_demographic_ge_adst_adst_g_ar ON ad_demographic_ge (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ge_bn_adst_adst ON ad_demographic_ge (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_gr PARTITION OF ad_demographic 
    FOR VALUES IN ('gr');

CREATE INDEX idx_ad_demographic_gr_i ON ad_demographic_gr (id);

CREATE INDEX idx_ad_demographic_gr_i_g_ar ON ad_demographic_gr (id, gender, age_range);

CREATE INDEX idx_ad_demographic_gr_bn ON ad_demographic_gr (bylines_name);

CREATE INDEX idx_ad_demographic_gr_adst_adst_g_ar ON ad_demographic_gr (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_gr_bn_adst_adst ON ad_demographic_gr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_gt PARTITION OF ad_demographic 
    FOR VALUES IN ('gt');

CREATE INDEX idx_ad_demographic_gt_i ON ad_demographic_gt (id);

CREATE INDEX idx_ad_demographic_gt_i_g_ar ON ad_demographic_gt (id, gender, age_range);

CREATE INDEX idx_ad_demographic_gt_bn ON ad_demographic_gt (bylines_name);

CREATE INDEX idx_ad_demographic_gt_adst_adst_g_ar ON ad_demographic_gt (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_gt_bn_adst_adst ON ad_demographic_gt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_hr PARTITION OF ad_demographic 
    FOR VALUES IN ('hr');

CREATE INDEX idx_ad_demographic_hr_i ON ad_demographic_hr (id);

CREATE INDEX idx_ad_demographic_hr_i_g_ar ON ad_demographic_hr (id, gender, age_range);

CREATE INDEX idx_ad_demographic_hr_bn ON ad_demographic_hr (bylines_name);

CREATE INDEX idx_ad_demographic_hr_adst_adst_g_ar ON ad_demographic_hr (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_hr_bn_adst_adst ON ad_demographic_hr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_hu PARTITION OF ad_demographic 
    FOR VALUES IN ('hu');

CREATE INDEX idx_ad_demographic_hu_i ON ad_demographic_hu (id);

CREATE INDEX idx_ad_demographic_hu_i_g_ar ON ad_demographic_hu (id, gender, age_range);

CREATE INDEX idx_ad_demographic_hu_bn ON ad_demographic_hu (bylines_name);

CREATE INDEX idx_ad_demographic_hu_adst_adst_g_ar ON ad_demographic_hu (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_hu_bn_adst_adst ON ad_demographic_hu (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_id PARTITION OF ad_demographic 
    FOR VALUES IN ('id');

CREATE INDEX idx_ad_demographic_id_i ON ad_demographic_id (id);

CREATE INDEX idx_ad_demographic_id_i_g_ar ON ad_demographic_id (id, gender, age_range);

CREATE INDEX idx_ad_demographic_id_bn ON ad_demographic_id (bylines_name);

CREATE INDEX idx_ad_demographic_id_adst_adst_g_ar ON ad_demographic_id (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_id_bn_adst_adst ON ad_demographic_id (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ie PARTITION OF ad_demographic 
    FOR VALUES IN ('ie');

CREATE INDEX idx_ad_demographic_ie_i ON ad_demographic_ie (id);

CREATE INDEX idx_ad_demographic_ie_i_g_ar ON ad_demographic_ie (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ie_bn ON ad_demographic_ie (bylines_name);

CREATE INDEX idx_ad_demographic_ie_adst_adst_g_ar ON ad_demographic_ie (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ie_bn_adst_adst ON ad_demographic_ie (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_il PARTITION OF ad_demographic 
    FOR VALUES IN ('il');

CREATE INDEX idx_ad_demographic_il_i ON ad_demographic_il (id);

CREATE INDEX idx_ad_demographic_il_i_g_ar ON ad_demographic_il (id, gender, age_range);

CREATE INDEX idx_ad_demographic_il_bn ON ad_demographic_il (bylines_name);

CREATE INDEX idx_ad_demographic_il_adst_adst_g_ar ON ad_demographic_il (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_il_bn_adst_adst ON ad_demographic_il (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_in PARTITION OF ad_demographic 
    FOR VALUES IN ('in');

CREATE INDEX idx_ad_demographic_in_i ON ad_demographic_in (id);

CREATE INDEX idx_ad_demographic_in_i_g_ar ON ad_demographic_in (id, gender, age_range);

CREATE INDEX idx_ad_demographic_in_bn ON ad_demographic_in (bylines_name);

CREATE INDEX idx_ad_demographic_in_adst_adst_g_ar ON ad_demographic_in (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_in_bn_adst_adst ON ad_demographic_in (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_it PARTITION OF ad_demographic 
    FOR VALUES IN ('it');

CREATE INDEX idx_ad_demographic_it_i ON ad_demographic_it (id);

CREATE INDEX idx_ad_demographic_it_i_g_ar ON ad_demographic_it (id, gender, age_range);

CREATE INDEX idx_ad_demographic_it_bn ON ad_demographic_it (bylines_name);

CREATE INDEX idx_ad_demographic_it_adst_adst_g_ar ON ad_demographic_it (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_it_bn_adst_adst ON ad_demographic_it (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_jp PARTITION OF ad_demographic 
    FOR VALUES IN ('jp');

CREATE INDEX idx_ad_demographic_jp_i ON ad_demographic_jp (id);

CREATE INDEX idx_ad_demographic_jp_i_g_ar ON ad_demographic_jp (id, gender, age_range);

CREATE INDEX idx_ad_demographic_jp_bn ON ad_demographic_jp (bylines_name);

CREATE INDEX idx_ad_demographic_jp_adst_adst_g_ar ON ad_demographic_jp (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_jp_bn_adst_adst ON ad_demographic_jp (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_lt PARTITION OF ad_demographic 
    FOR VALUES IN ('lt');

CREATE INDEX idx_ad_demographic_lt_i ON ad_demographic_lt (id);

CREATE INDEX idx_ad_demographic_lt_i_g_ar ON ad_demographic_lt (id, gender, age_range);

CREATE INDEX idx_ad_demographic_lt_bn ON ad_demographic_lt (bylines_name);

CREATE INDEX idx_ad_demographic_lt_adst_adst_g_ar ON ad_demographic_lt (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_lt_bn_adst_adst ON ad_demographic_lt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_lu PARTITION OF ad_demographic 
    FOR VALUES IN ('lu');

CREATE INDEX idx_ad_demographic_lu_i ON ad_demographic_lu (id);

CREATE INDEX idx_ad_demographic_lu_i_g_ar ON ad_demographic_lu (id, gender, age_range);

CREATE INDEX idx_ad_demographic_lu_bn ON ad_demographic_lu (bylines_name);

CREATE INDEX idx_ad_demographic_lu_adst_adst_g_ar ON ad_demographic_lu (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_lu_bn_adst_adst ON ad_demographic_lu (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_lv PARTITION OF ad_demographic 
    FOR VALUES IN ('lv');

CREATE INDEX idx_ad_demographic_lv_i ON ad_demographic_lv (id);

CREATE INDEX idx_ad_demographic_lv_i_g_ar ON ad_demographic_lv (id, gender, age_range);

CREATE INDEX idx_ad_demographic_lv_bn ON ad_demographic_lv (bylines_name);

CREATE INDEX idx_ad_demographic_lv_adst_adst_g_ar ON ad_demographic_lv (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_lv_bn_adst_adst ON ad_demographic_lv (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_me PARTITION OF ad_demographic 
    FOR VALUES IN ('me');

CREATE INDEX idx_ad_demographic_me_i ON ad_demographic_me (id);

CREATE INDEX idx_ad_demographic_me_i_g_ar ON ad_demographic_me (id, gender, age_range);

CREATE INDEX idx_ad_demographic_me_bn ON ad_demographic_me (bylines_name);

CREATE INDEX idx_ad_demographic_me_adst_adst_g_ar ON ad_demographic_me (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_me_bn_adst_adst ON ad_demographic_me (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_mk PARTITION OF ad_demographic 
    FOR VALUES IN ('mk');

CREATE INDEX idx_ad_demographic_mk_i ON ad_demographic_mk (id);

CREATE INDEX idx_ad_demographic_mk_i_g_ar ON ad_demographic_mk (id, gender, age_range);

CREATE INDEX idx_ad_demographic_mk_bn ON ad_demographic_mk (bylines_name);

CREATE INDEX idx_ad_demographic_mk_adst_adst_g_ar ON ad_demographic_mk (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_mk_bn_adst_adst ON ad_demographic_mk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_mt PARTITION OF ad_demographic 
    FOR VALUES IN ('mt');

CREATE INDEX idx_ad_demographic_mt_i ON ad_demographic_mt (id);

CREATE INDEX idx_ad_demographic_mt_i_g_ar ON ad_demographic_mt (id, gender, age_range);

CREATE INDEX idx_ad_demographic_mt_bn ON ad_demographic_mt (bylines_name);

CREATE INDEX idx_ad_demographic_mt_adst_adst_g_ar ON ad_demographic_mt (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_mt_bn_adst_adst ON ad_demographic_mt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_mx PARTITION OF ad_demographic 
    FOR VALUES IN ('mx');

CREATE INDEX idx_ad_demographic_mx_i ON ad_demographic_mx (id);

CREATE INDEX idx_ad_demographic_mx_i_g_ar ON ad_demographic_mx (id, gender, age_range);

CREATE INDEX idx_ad_demographic_mx_bn ON ad_demographic_mx (bylines_name);

CREATE INDEX idx_ad_demographic_mx_adst_adst_g_ar ON ad_demographic_mx (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_mx_bn_adst_adst ON ad_demographic_mx (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ng PARTITION OF ad_demographic 
    FOR VALUES IN ('ng');

CREATE INDEX idx_ad_demographic_ng_i ON ad_demographic_ng (id);

CREATE INDEX idx_ad_demographic_ng_i_g_ar ON ad_demographic_ng (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ng_bn ON ad_demographic_ng (bylines_name);

CREATE INDEX idx_ad_demographic_ng_adst_adst_g_ar ON ad_demographic_ng (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ng_bn_adst_adst ON ad_demographic_ng (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_nl PARTITION OF ad_demographic 
    FOR VALUES IN ('nl');

CREATE INDEX idx_ad_demographic_nl_i ON ad_demographic_nl (id);

CREATE INDEX idx_ad_demographic_nl_i_g_ar ON ad_demographic_nl (id, gender, age_range);

CREATE INDEX idx_ad_demographic_nl_bn ON ad_demographic_nl (bylines_name);

CREATE INDEX idx_ad_demographic_nl_adst_adst_g_ar ON ad_demographic_nl (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_nl_bn_adst_adst ON ad_demographic_nl (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_no PARTITION OF ad_demographic 
    FOR VALUES IN ('no');

CREATE INDEX idx_ad_demographic_no_i ON ad_demographic_no (id);

CREATE INDEX idx_ad_demographic_no_i_g_ar ON ad_demographic_no (id, gender, age_range);

CREATE INDEX idx_ad_demographic_no_bn ON ad_demographic_no (bylines_name);

CREATE INDEX idx_ad_demographic_no_adst_adst_g_ar ON ad_demographic_no (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_no_bn_adst_adst ON ad_demographic_no (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_pa PARTITION OF ad_demographic 
    FOR VALUES IN ('pa');

CREATE INDEX idx_ad_demographic_pa_i ON ad_demographic_pa (id);

CREATE INDEX idx_ad_demographic_pa_i_g_ar ON ad_demographic_pa (id, gender, age_range);

CREATE INDEX idx_ad_demographic_pa_bn ON ad_demographic_pa (bylines_name);

CREATE INDEX idx_ad_demographic_pa_adst_adst_g_ar ON ad_demographic_pa (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_pa_bn_adst_adst ON ad_demographic_pa (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ph PARTITION OF ad_demographic 
    FOR VALUES IN ('ph');

CREATE INDEX idx_ad_demographic_ph_i ON ad_demographic_ph (id);

CREATE INDEX idx_ad_demographic_ph_i_g_ar ON ad_demographic_ph (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ph_bn ON ad_demographic_ph (bylines_name);

CREATE INDEX idx_ad_demographic_ph_adst_adst_g_ar ON ad_demographic_ph (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ph_bn_adst_adst ON ad_demographic_ph (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_pk PARTITION OF ad_demographic 
    FOR VALUES IN ('pk');

CREATE INDEX idx_ad_demographic_pk_i ON ad_demographic_pk (id);

CREATE INDEX idx_ad_demographic_pk_i_g_ar ON ad_demographic_pk (id, gender, age_range);

CREATE INDEX idx_ad_demographic_pk_bn ON ad_demographic_pk (bylines_name);

CREATE INDEX idx_ad_demographic_pk_adst_adst_g_ar ON ad_demographic_pk (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_pk_bn_adst_adst ON ad_demographic_pk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_pl PARTITION OF ad_demographic 
    FOR VALUES IN ('pl');

CREATE INDEX idx_ad_demographic_pl_i ON ad_demographic_pl (id);

CREATE INDEX idx_ad_demographic_pl_i_g_ar ON ad_demographic_pl (id, gender, age_range);

CREATE INDEX idx_ad_demographic_pl_bn ON ad_demographic_pl (bylines_name);

CREATE INDEX idx_ad_demographic_pl_adst_adst_g_ar ON ad_demographic_pl (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_pl_bn_adst_adst ON ad_demographic_pl (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_pt PARTITION OF ad_demographic 
    FOR VALUES IN ('pt');

CREATE INDEX idx_ad_demographic_pt_i ON ad_demographic_pt (id);

CREATE INDEX idx_ad_demographic_pt_i_g_ar ON ad_demographic_pt (id, gender, age_range);

CREATE INDEX idx_ad_demographic_pt_bn ON ad_demographic_pt (bylines_name);

CREATE INDEX idx_ad_demographic_pt_adst_adst_g_ar ON ad_demographic_pt (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_pt_bn_adst_adst ON ad_demographic_pt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ro PARTITION OF ad_demographic 
    FOR VALUES IN ('ro');

CREATE INDEX idx_ad_demographic_ro_i ON ad_demographic_ro (id);

CREATE INDEX idx_ad_demographic_ro_i_g_ar ON ad_demographic_ro (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ro_bn ON ad_demographic_ro (bylines_name);

CREATE INDEX idx_ad_demographic_ro_adst_adst_g_ar ON ad_demographic_ro (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ro_bn_adst_adst ON ad_demographic_ro (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_rs PARTITION OF ad_demographic 
    FOR VALUES IN ('rs');

CREATE INDEX idx_ad_demographic_rs_i ON ad_demographic_rs (id);

CREATE INDEX idx_ad_demographic_rs_i_g_ar ON ad_demographic_rs (id, gender, age_range);

CREATE INDEX idx_ad_demographic_rs_bn ON ad_demographic_rs (bylines_name);

CREATE INDEX idx_ad_demographic_rs_adst_adst_g_ar ON ad_demographic_rs (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_rs_bn_adst_adst ON ad_demographic_rs (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_sa PARTITION OF ad_demographic 
    FOR VALUES IN ('sa');

CREATE INDEX idx_ad_demographic_sa_i ON ad_demographic_sa (id);

CREATE INDEX idx_ad_demographic_sa_i_g_ar ON ad_demographic_sa (id, gender, age_range);

CREATE INDEX idx_ad_demographic_sa_bn ON ad_demographic_sa (bylines_name);

CREATE INDEX idx_ad_demographic_sa_adst_adst_g_ar ON ad_demographic_sa (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_sa_bn_adst_adst ON ad_demographic_sa (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_se PARTITION OF ad_demographic 
    FOR VALUES IN ('se');

CREATE INDEX idx_ad_demographic_se_i ON ad_demographic_se (id);

CREATE INDEX idx_ad_demographic_se_i_g_ar ON ad_demographic_se (id, gender, age_range);

CREATE INDEX idx_ad_demographic_se_bn ON ad_demographic_se (bylines_name);

CREATE INDEX idx_ad_demographic_se_adst_adst_g_ar ON ad_demographic_se (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_se_bn_adst_adst ON ad_demographic_se (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_si PARTITION OF ad_demographic 
    FOR VALUES IN ('si');

CREATE INDEX idx_ad_demographic_si_i ON ad_demographic_si (id);

CREATE INDEX idx_ad_demographic_si_i_g_ar ON ad_demographic_si (id, gender, age_range);

CREATE INDEX idx_ad_demographic_si_bn ON ad_demographic_si (bylines_name);

CREATE INDEX idx_ad_demographic_si_adst_adst_g_ar ON ad_demographic_si (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_si_bn_adst_adst ON ad_demographic_si (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_sk PARTITION OF ad_demographic 
    FOR VALUES IN ('sk');

CREATE INDEX idx_ad_demographic_sk_i ON ad_demographic_sk (id);

CREATE INDEX idx_ad_demographic_sk_i_g_ar ON ad_demographic_sk (id, gender, age_range);

CREATE INDEX idx_ad_demographic_sk_bn ON ad_demographic_sk (bylines_name);

CREATE INDEX idx_ad_demographic_sk_adst_adst_g_ar ON ad_demographic_sk (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_sk_bn_adst_adst ON ad_demographic_sk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_th PARTITION OF ad_demographic 
    FOR VALUES IN ('th');

CREATE INDEX idx_ad_demographic_th_i ON ad_demographic_th (id);

CREATE INDEX idx_ad_demographic_th_i_g_ar ON ad_demographic_th (id, gender, age_range);

CREATE INDEX idx_ad_demographic_th_bn ON ad_demographic_th (bylines_name);

CREATE INDEX idx_ad_demographic_th_adst_adst_g_ar ON ad_demographic_th (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_th_bn_adst_adst ON ad_demographic_th (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_tr PARTITION OF ad_demographic 
    FOR VALUES IN ('tr');

CREATE INDEX idx_ad_demographic_tr_i ON ad_demographic_tr (id);

CREATE INDEX idx_ad_demographic_tr_i_g_ar ON ad_demographic_tr (id, gender, age_range);

CREATE INDEX idx_ad_demographic_tr_bn ON ad_demographic_tr (bylines_name);

CREATE INDEX idx_ad_demographic_tr_adst_adst_g_ar ON ad_demographic_tr (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_tr_bn_adst_adst ON ad_demographic_tr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_ua PARTITION OF ad_demographic 
    FOR VALUES IN ('ua');

CREATE INDEX idx_ad_demographic_ua_i ON ad_demographic_ua (id);

CREATE INDEX idx_ad_demographic_ua_i_g_ar ON ad_demographic_ua (id, gender, age_range);

CREATE INDEX idx_ad_demographic_ua_bn ON ad_demographic_ua (bylines_name);

CREATE INDEX idx_ad_demographic_ua_adst_adst_g_ar ON ad_demographic_ua (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_ua_bn_adst_adst ON ad_demographic_ua (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_us PARTITION OF ad_demographic 
    FOR VALUES IN ('us');

CREATE INDEX idx_ad_demographic_us_i ON ad_demographic_us (id);

CREATE INDEX idx_ad_demographic_us_i_g_ar ON ad_demographic_us (id, gender, age_range);

CREATE INDEX idx_ad_demographic_us_bn ON ad_demographic_us (bylines_name);

CREATE INDEX idx_ad_demographic_us_adst_adst_g_ar ON ad_demographic_us (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_us_bn_adst_adst ON ad_demographic_us (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_vn PARTITION OF ad_demographic 
    FOR VALUES IN ('vn');

CREATE INDEX idx_ad_demographic_vn_i ON ad_demographic_vn (id);

CREATE INDEX idx_ad_demographic_vn_i_g_ar ON ad_demographic_vn (id, gender, age_range);

CREATE INDEX idx_ad_demographic_vn_bn ON ad_demographic_vn (bylines_name);

CREATE INDEX idx_ad_demographic_vn_adst_adst_g_ar ON ad_demographic_vn (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_vn_bn_adst_adst ON ad_demographic_vn (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_xk PARTITION OF ad_demographic 
    FOR VALUES IN ('xk');

CREATE INDEX idx_ad_demographic_xk_i ON ad_demographic_xk (id);

CREATE INDEX idx_ad_demographic_xk_i_g_ar ON ad_demographic_xk (id, gender, age_range);

CREATE INDEX idx_ad_demographic_xk_bn ON ad_demographic_xk (bylines_name);

CREATE INDEX idx_ad_demographic_xk_adst_adst_g_ar ON ad_demographic_xk (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_xk_bn_adst_adst ON ad_demographic_xk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_za PARTITION OF ad_demographic 
    FOR VALUES IN ('za');

CREATE INDEX idx_ad_demographic_za_i ON ad_demographic_za (id);

CREATE INDEX idx_ad_demographic_za_i_g_ar ON ad_demographic_za (id, gender, age_range);

CREATE INDEX idx_ad_demographic_za_bn ON ad_demographic_za (bylines_name);

CREATE INDEX idx_ad_demographic_za_adst_adst_g_ar ON ad_demographic_za (ad_delivery_start_time, ad_delivery_stop_time, gender, age_range);

CREATE INDEX idx_ad_demographic_za_bn_adst_adst ON ad_demographic_za (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_demographic_default PARTITION OF ad_demographic DEFAULT;
