CREATE TABLE ad_region_al PARTITION OF ad_region 
    FOR VALUES IN ('al');

CREATE INDEX idx_ad_region_al_i ON ad_region_al (id);

CREATE INDEX idx_ad_region_al_i_r ON ad_region_al (id, region);

CREATE INDEX idx_ad_region_al_bn ON ad_region_al (bylines_name);

CREATE INDEX idx_ad_region_al_adst_adst_r ON ad_region_al (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_al_bn_adst_adst ON ad_region_al (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_am PARTITION OF ad_region 
    FOR VALUES IN ('am');

CREATE INDEX idx_ad_region_am_i ON ad_region_am (id);

CREATE INDEX idx_ad_region_am_i_r ON ad_region_am (id, region);

CREATE INDEX idx_ad_region_am_bn ON ad_region_am (bylines_name);

CREATE INDEX idx_ad_region_am_adst_adst_r ON ad_region_am (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_am_bn_adst_adst ON ad_region_am (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_at PARTITION OF ad_region 
    FOR VALUES IN ('at');

CREATE INDEX idx_ad_region_at_i ON ad_region_at (id);

CREATE INDEX idx_ad_region_at_i_r ON ad_region_at (id, region);

CREATE INDEX idx_ad_region_at_bn ON ad_region_at (bylines_name);

CREATE INDEX idx_ad_region_at_adst_adst_r ON ad_region_at (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_at_bn_adst_adst ON ad_region_at (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_au PARTITION OF ad_region 
    FOR VALUES IN ('au');

CREATE INDEX idx_ad_region_au_i ON ad_region_au (id);

CREATE INDEX idx_ad_region_au_i_r ON ad_region_au (id, region);

CREATE INDEX idx_ad_region_au_bn ON ad_region_au (bylines_name);

CREATE INDEX idx_ad_region_au_adst_adst_r ON ad_region_au (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_au_bn_adst_adst ON ad_region_au (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_az PARTITION OF ad_region 
    FOR VALUES IN ('az');

CREATE INDEX idx_ad_region_az_i ON ad_region_az (id);

CREATE INDEX idx_ad_region_az_i_r ON ad_region_az (id, region);

CREATE INDEX idx_ad_region_az_bn ON ad_region_az (bylines_name);

CREATE INDEX idx_ad_region_az_adst_adst_r ON ad_region_az (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_az_bn_adst_adst ON ad_region_az (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_bd PARTITION OF ad_region 
    FOR VALUES IN ('bd');

CREATE INDEX idx_ad_region_bd_i ON ad_region_bd (id);

CREATE INDEX idx_ad_region_bd_i_r ON ad_region_bd (id, region);

CREATE INDEX idx_ad_region_bd_bn ON ad_region_bd (bylines_name);

CREATE INDEX idx_ad_region_bd_adst_adst_r ON ad_region_bd (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_bd_bn_adst_adst ON ad_region_bd (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_be PARTITION OF ad_region 
    FOR VALUES IN ('be');

CREATE INDEX idx_ad_region_be_i ON ad_region_be (id);

CREATE INDEX idx_ad_region_be_i_r ON ad_region_be (id, region);

CREATE INDEX idx_ad_region_be_bn ON ad_region_be (bylines_name);

CREATE INDEX idx_ad_region_be_adst_adst_r ON ad_region_be (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_be_bn_adst_adst ON ad_region_be (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_bg PARTITION OF ad_region 
    FOR VALUES IN ('bg');

CREATE INDEX idx_ad_region_bg_i ON ad_region_bg (id);

CREATE INDEX idx_ad_region_bg_i_r ON ad_region_bg (id, region);

CREATE INDEX idx_ad_region_bg_bn ON ad_region_bg (bylines_name);

CREATE INDEX idx_ad_region_bg_adst_adst_r ON ad_region_bg (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_bg_bn_adst_adst ON ad_region_bg (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_br PARTITION OF ad_region 
    FOR VALUES IN ('br');

CREATE INDEX idx_ad_region_br_i ON ad_region_br (id);

CREATE INDEX idx_ad_region_br_i_r ON ad_region_br (id, region);

CREATE INDEX idx_ad_region_br_bn ON ad_region_br (bylines_name);

CREATE INDEX idx_ad_region_br_adst_adst_r ON ad_region_br (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_br_bn_adst_adst ON ad_region_br (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ca PARTITION OF ad_region 
    FOR VALUES IN ('ca');

CREATE INDEX idx_ad_region_ca_i ON ad_region_ca (id);

CREATE INDEX idx_ad_region_ca_i_r ON ad_region_ca (id, region);

CREATE INDEX idx_ad_region_ca_bn ON ad_region_ca (bylines_name);

CREATE INDEX idx_ad_region_ca_adst_adst_r ON ad_region_ca (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ca_bn_adst_adst ON ad_region_ca (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_cd PARTITION OF ad_region 
    FOR VALUES IN ('cd');

CREATE INDEX idx_ad_region_cd_i ON ad_region_cd (id);

CREATE INDEX idx_ad_region_cd_i_r ON ad_region_cd (id, region);

CREATE INDEX idx_ad_region_cd_bn ON ad_region_cd (bylines_name);

CREATE INDEX idx_ad_region_cd_adst_adst_r ON ad_region_cd (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_cd_bn_adst_adst ON ad_region_cd (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ch PARTITION OF ad_region 
    FOR VALUES IN ('ch');

CREATE INDEX idx_ad_region_ch_i ON ad_region_ch (id);

CREATE INDEX idx_ad_region_ch_i_r ON ad_region_ch (id, region);

CREATE INDEX idx_ad_region_ch_bn ON ad_region_ch (bylines_name);

CREATE INDEX idx_ad_region_ch_adst_adst_r ON ad_region_ch (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ch_bn_adst_adst ON ad_region_ch (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_co PARTITION OF ad_region 
    FOR VALUES IN ('co');

CREATE INDEX idx_ad_region_co_i ON ad_region_co (id);

CREATE INDEX idx_ad_region_co_i_r ON ad_region_co (id, region);

CREATE INDEX idx_ad_region_co_bn ON ad_region_co (bylines_name);

CREATE INDEX idx_ad_region_co_adst_adst_r ON ad_region_co (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_co_bn_adst_adst ON ad_region_co (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_cr PARTITION OF ad_region 
    FOR VALUES IN ('cr');

CREATE INDEX idx_ad_region_cr_i ON ad_region_cr (id);

CREATE INDEX idx_ad_region_cr_i_r ON ad_region_cr (id, region);

CREATE INDEX idx_ad_region_cr_bn ON ad_region_cr (bylines_name);

CREATE INDEX idx_ad_region_cr_adst_adst_r ON ad_region_cr (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_cr_bn_adst_adst ON ad_region_cr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_cy PARTITION OF ad_region 
    FOR VALUES IN ('cy');

CREATE INDEX idx_ad_region_cy_i ON ad_region_cy (id);

CREATE INDEX idx_ad_region_cy_i_r ON ad_region_cy (id, region);

CREATE INDEX idx_ad_region_cy_bn ON ad_region_cy (bylines_name);

CREATE INDEX idx_ad_region_cy_adst_adst_r ON ad_region_cy (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_cy_bn_adst_adst ON ad_region_cy (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_cz PARTITION OF ad_region 
    FOR VALUES IN ('cz');

CREATE INDEX idx_ad_region_cz_i ON ad_region_cz (id);

CREATE INDEX idx_ad_region_cz_i_r ON ad_region_cz (id, region);

CREATE INDEX idx_ad_region_cz_bn ON ad_region_cz (bylines_name);

CREATE INDEX idx_ad_region_cz_adst_adst_r ON ad_region_cz (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_cz_bn_adst_adst ON ad_region_cz (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_de PARTITION OF ad_region 
    FOR VALUES IN ('de');

CREATE INDEX idx_ad_region_de_i ON ad_region_de (id);

CREATE INDEX idx_ad_region_de_i_r ON ad_region_de (id, region);

CREATE INDEX idx_ad_region_de_bn ON ad_region_de (bylines_name);

CREATE INDEX idx_ad_region_de_adst_adst_r ON ad_region_de (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_de_bn_adst_adst ON ad_region_de (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_dk PARTITION OF ad_region 
    FOR VALUES IN ('dk');

CREATE INDEX idx_ad_region_dk_i ON ad_region_dk (id);

CREATE INDEX idx_ad_region_dk_i_r ON ad_region_dk (id, region);

CREATE INDEX idx_ad_region_dk_bn ON ad_region_dk (bylines_name);

CREATE INDEX idx_ad_region_dk_adst_adst_r ON ad_region_dk (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_dk_bn_adst_adst ON ad_region_dk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_dz PARTITION OF ad_region 
    FOR VALUES IN ('dz');

CREATE INDEX idx_ad_region_dz_i ON ad_region_dz (id);

CREATE INDEX idx_ad_region_dz_i_r ON ad_region_dz (id, region);

CREATE INDEX idx_ad_region_dz_bn ON ad_region_dz (bylines_name);

CREATE INDEX idx_ad_region_dz_adst_adst_r ON ad_region_dz (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_dz_bn_adst_adst ON ad_region_dz (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ee PARTITION OF ad_region 
    FOR VALUES IN ('ee');

CREATE INDEX idx_ad_region_ee_i ON ad_region_ee (id);

CREATE INDEX idx_ad_region_ee_i_r ON ad_region_ee (id, region);

CREATE INDEX idx_ad_region_ee_bn ON ad_region_ee (bylines_name);

CREATE INDEX idx_ad_region_ee_adst_adst_r ON ad_region_ee (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ee_bn_adst_adst ON ad_region_ee (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_eg PARTITION OF ad_region 
    FOR VALUES IN ('eg');

CREATE INDEX idx_ad_region_eg_i ON ad_region_eg (id);

CREATE INDEX idx_ad_region_eg_i_r ON ad_region_eg (id, region);

CREATE INDEX idx_ad_region_eg_bn ON ad_region_eg (bylines_name);

CREATE INDEX idx_ad_region_eg_adst_adst_r ON ad_region_eg (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_eg_bn_adst_adst ON ad_region_eg (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_es PARTITION OF ad_region 
    FOR VALUES IN ('es');

CREATE INDEX idx_ad_region_es_i ON ad_region_es (id);

CREATE INDEX idx_ad_region_es_i_r ON ad_region_es (id, region);

CREATE INDEX idx_ad_region_es_bn ON ad_region_es (bylines_name);

CREATE INDEX idx_ad_region_es_adst_adst_r ON ad_region_es (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_es_bn_adst_adst ON ad_region_es (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_fi PARTITION OF ad_region 
    FOR VALUES IN ('fi');

CREATE INDEX idx_ad_region_fi_i ON ad_region_fi (id);

CREATE INDEX idx_ad_region_fi_i_r ON ad_region_fi (id, region);

CREATE INDEX idx_ad_region_fi_bn ON ad_region_fi (bylines_name);

CREATE INDEX idx_ad_region_fi_adst_adst_r ON ad_region_fi (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_fi_bn_adst_adst ON ad_region_fi (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_fr PARTITION OF ad_region 
    FOR VALUES IN ('fr');

CREATE INDEX idx_ad_region_fr_i ON ad_region_fr (id);

CREATE INDEX idx_ad_region_fr_i_r ON ad_region_fr (id, region);

CREATE INDEX idx_ad_region_fr_bn ON ad_region_fr (bylines_name);

CREATE INDEX idx_ad_region_fr_adst_adst_r ON ad_region_fr (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_fr_bn_adst_adst ON ad_region_fr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_gb PARTITION OF ad_region 
    FOR VALUES IN ('gb');

CREATE INDEX idx_ad_region_gb_i ON ad_region_gb (id);

CREATE INDEX idx_ad_region_gb_i_r ON ad_region_gb (id, region);

CREATE INDEX idx_ad_region_gb_bn ON ad_region_gb (bylines_name);

CREATE INDEX idx_ad_region_gb_adst_adst_r ON ad_region_gb (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_gb_bn_adst_adst ON ad_region_gb (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ge PARTITION OF ad_region 
    FOR VALUES IN ('ge');

CREATE INDEX idx_ad_region_ge_i ON ad_region_ge (id);

CREATE INDEX idx_ad_region_ge_i_r ON ad_region_ge (id, region);

CREATE INDEX idx_ad_region_ge_bn ON ad_region_ge (bylines_name);

CREATE INDEX idx_ad_region_ge_adst_adst_r ON ad_region_ge (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ge_bn_adst_adst ON ad_region_ge (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_gr PARTITION OF ad_region 
    FOR VALUES IN ('gr');

CREATE INDEX idx_ad_region_gr_i ON ad_region_gr (id);

CREATE INDEX idx_ad_region_gr_i_r ON ad_region_gr (id, region);

CREATE INDEX idx_ad_region_gr_bn ON ad_region_gr (bylines_name);

CREATE INDEX idx_ad_region_gr_adst_adst_r ON ad_region_gr (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_gr_bn_adst_adst ON ad_region_gr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_gt PARTITION OF ad_region 
    FOR VALUES IN ('gt');

CREATE INDEX idx_ad_region_gt_i ON ad_region_gt (id);

CREATE INDEX idx_ad_region_gt_i_r ON ad_region_gt (id, region);

CREATE INDEX idx_ad_region_gt_bn ON ad_region_gt (bylines_name);

CREATE INDEX idx_ad_region_gt_adst_adst_r ON ad_region_gt (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_gt_bn_adst_adst ON ad_region_gt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_hr PARTITION OF ad_region 
    FOR VALUES IN ('hr');

CREATE INDEX idx_ad_region_hr_i ON ad_region_hr (id);

CREATE INDEX idx_ad_region_hr_i_r ON ad_region_hr (id, region);

CREATE INDEX idx_ad_region_hr_bn ON ad_region_hr (bylines_name);

CREATE INDEX idx_ad_region_hr_adst_adst_r ON ad_region_hr (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_hr_bn_adst_adst ON ad_region_hr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_hu PARTITION OF ad_region 
    FOR VALUES IN ('hu');

CREATE INDEX idx_ad_region_hu_i ON ad_region_hu (id);

CREATE INDEX idx_ad_region_hu_i_r ON ad_region_hu (id, region);

CREATE INDEX idx_ad_region_hu_bn ON ad_region_hu (bylines_name);

CREATE INDEX idx_ad_region_hu_adst_adst_r ON ad_region_hu (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_hu_bn_adst_adst ON ad_region_hu (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_id PARTITION OF ad_region 
    FOR VALUES IN ('id');

CREATE INDEX idx_ad_region_id_i ON ad_region_id (id);

CREATE INDEX idx_ad_region_id_i_r ON ad_region_id (id, region);

CREATE INDEX idx_ad_region_id_bn ON ad_region_id (bylines_name);

CREATE INDEX idx_ad_region_id_adst_adst_r ON ad_region_id (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_id_bn_adst_adst ON ad_region_id (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ie PARTITION OF ad_region 
    FOR VALUES IN ('ie');

CREATE INDEX idx_ad_region_ie_i ON ad_region_ie (id);

CREATE INDEX idx_ad_region_ie_i_r ON ad_region_ie (id, region);

CREATE INDEX idx_ad_region_ie_bn ON ad_region_ie (bylines_name);

CREATE INDEX idx_ad_region_ie_adst_adst_r ON ad_region_ie (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ie_bn_adst_adst ON ad_region_ie (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_il PARTITION OF ad_region 
    FOR VALUES IN ('il');

CREATE INDEX idx_ad_region_il_i ON ad_region_il (id);

CREATE INDEX idx_ad_region_il_i_r ON ad_region_il (id, region);

CREATE INDEX idx_ad_region_il_bn ON ad_region_il (bylines_name);

CREATE INDEX idx_ad_region_il_adst_adst_r ON ad_region_il (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_il_bn_adst_adst ON ad_region_il (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_in PARTITION OF ad_region 
    FOR VALUES IN ('in');

CREATE INDEX idx_ad_region_in_i ON ad_region_in (id);

CREATE INDEX idx_ad_region_in_i_r ON ad_region_in (id, region);

CREATE INDEX idx_ad_region_in_bn ON ad_region_in (bylines_name);

CREATE INDEX idx_ad_region_in_adst_adst_r ON ad_region_in (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_in_bn_adst_adst ON ad_region_in (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_it PARTITION OF ad_region 
    FOR VALUES IN ('it');

CREATE INDEX idx_ad_region_it_i ON ad_region_it (id);

CREATE INDEX idx_ad_region_it_i_r ON ad_region_it (id, region);

CREATE INDEX idx_ad_region_it_bn ON ad_region_it (bylines_name);

CREATE INDEX idx_ad_region_it_adst_adst_r ON ad_region_it (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_it_bn_adst_adst ON ad_region_it (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_jp PARTITION OF ad_region 
    FOR VALUES IN ('jp');

CREATE INDEX idx_ad_region_jp_i ON ad_region_jp (id);

CREATE INDEX idx_ad_region_jp_i_r ON ad_region_jp (id, region);

CREATE INDEX idx_ad_region_jp_bn ON ad_region_jp (bylines_name);

CREATE INDEX idx_ad_region_jp_adst_adst_r ON ad_region_jp (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_jp_bn_adst_adst ON ad_region_jp (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_lt PARTITION OF ad_region 
    FOR VALUES IN ('lt');

CREATE INDEX idx_ad_region_lt_i ON ad_region_lt (id);

CREATE INDEX idx_ad_region_lt_i_r ON ad_region_lt (id, region);

CREATE INDEX idx_ad_region_lt_bn ON ad_region_lt (bylines_name);

CREATE INDEX idx_ad_region_lt_adst_adst_r ON ad_region_lt (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_lt_bn_adst_adst ON ad_region_lt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_lu PARTITION OF ad_region 
    FOR VALUES IN ('lu');

CREATE INDEX idx_ad_region_lu_i ON ad_region_lu (id);

CREATE INDEX idx_ad_region_lu_i_r ON ad_region_lu (id, region);

CREATE INDEX idx_ad_region_lu_bn ON ad_region_lu (bylines_name);

CREATE INDEX idx_ad_region_lu_adst_adst_r ON ad_region_lu (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_lu_bn_adst_adst ON ad_region_lu (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_lv PARTITION OF ad_region 
    FOR VALUES IN ('lv');

CREATE INDEX idx_ad_region_lv_i ON ad_region_lv (id);

CREATE INDEX idx_ad_region_lv_i_r ON ad_region_lv (id, region);

CREATE INDEX idx_ad_region_lv_bn ON ad_region_lv (bylines_name);

CREATE INDEX idx_ad_region_lv_adst_adst_r ON ad_region_lv (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_lv_bn_adst_adst ON ad_region_lv (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_me PARTITION OF ad_region 
    FOR VALUES IN ('me');

CREATE INDEX idx_ad_region_me_i ON ad_region_me (id);

CREATE INDEX idx_ad_region_me_i_r ON ad_region_me (id, region);

CREATE INDEX idx_ad_region_me_bn ON ad_region_me (bylines_name);

CREATE INDEX idx_ad_region_me_adst_adst_r ON ad_region_me (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_me_bn_adst_adst ON ad_region_me (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_mk PARTITION OF ad_region 
    FOR VALUES IN ('mk');

CREATE INDEX idx_ad_region_mk_i ON ad_region_mk (id);

CREATE INDEX idx_ad_region_mk_i_r ON ad_region_mk (id, region);

CREATE INDEX idx_ad_region_mk_bn ON ad_region_mk (bylines_name);

CREATE INDEX idx_ad_region_mk_adst_adst_r ON ad_region_mk (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_mk_bn_adst_adst ON ad_region_mk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_mt PARTITION OF ad_region 
    FOR VALUES IN ('mt');

CREATE INDEX idx_ad_region_mt_i ON ad_region_mt (id);

CREATE INDEX idx_ad_region_mt_i_r ON ad_region_mt (id, region);

CREATE INDEX idx_ad_region_mt_bn ON ad_region_mt (bylines_name);

CREATE INDEX idx_ad_region_mt_adst_adst_r ON ad_region_mt (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_mt_bn_adst_adst ON ad_region_mt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_mx PARTITION OF ad_region 
    FOR VALUES IN ('mx');

CREATE INDEX idx_ad_region_mx_i ON ad_region_mx (id);

CREATE INDEX idx_ad_region_mx_i_r ON ad_region_mx (id, region);

CREATE INDEX idx_ad_region_mx_bn ON ad_region_mx (bylines_name);

CREATE INDEX idx_ad_region_mx_adst_adst_r ON ad_region_mx (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_mx_bn_adst_adst ON ad_region_mx (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ng PARTITION OF ad_region 
    FOR VALUES IN ('ng');

CREATE INDEX idx_ad_region_ng_i ON ad_region_ng (id);

CREATE INDEX idx_ad_region_ng_i_r ON ad_region_ng (id, region);

CREATE INDEX idx_ad_region_ng_bn ON ad_region_ng (bylines_name);

CREATE INDEX idx_ad_region_ng_adst_adst_r ON ad_region_ng (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ng_bn_adst_adst ON ad_region_ng (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_nl PARTITION OF ad_region 
    FOR VALUES IN ('nl');

CREATE INDEX idx_ad_region_nl_i ON ad_region_nl (id);

CREATE INDEX idx_ad_region_nl_i_r ON ad_region_nl (id, region);

CREATE INDEX idx_ad_region_nl_bn ON ad_region_nl (bylines_name);

CREATE INDEX idx_ad_region_nl_adst_adst_r ON ad_region_nl (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_nl_bn_adst_adst ON ad_region_nl (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_no PARTITION OF ad_region 
    FOR VALUES IN ('no');

CREATE INDEX idx_ad_region_no_i ON ad_region_no (id);

CREATE INDEX idx_ad_region_no_i_r ON ad_region_no (id, region);

CREATE INDEX idx_ad_region_no_bn ON ad_region_no (bylines_name);

CREATE INDEX idx_ad_region_no_adst_adst_r ON ad_region_no (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_no_bn_adst_adst ON ad_region_no (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_pa PARTITION OF ad_region 
    FOR VALUES IN ('pa');

CREATE INDEX idx_ad_region_pa_i ON ad_region_pa (id);

CREATE INDEX idx_ad_region_pa_i_r ON ad_region_pa (id, region);

CREATE INDEX idx_ad_region_pa_bn ON ad_region_pa (bylines_name);

CREATE INDEX idx_ad_region_pa_adst_adst_r ON ad_region_pa (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_pa_bn_adst_adst ON ad_region_pa (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ph PARTITION OF ad_region 
    FOR VALUES IN ('ph');

CREATE INDEX idx_ad_region_ph_i ON ad_region_ph (id);

CREATE INDEX idx_ad_region_ph_i_r ON ad_region_ph (id, region);

CREATE INDEX idx_ad_region_ph_bn ON ad_region_ph (bylines_name);

CREATE INDEX idx_ad_region_ph_adst_adst_r ON ad_region_ph (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ph_bn_adst_adst ON ad_region_ph (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_pk PARTITION OF ad_region 
    FOR VALUES IN ('pk');

CREATE INDEX idx_ad_region_pk_i ON ad_region_pk (id);

CREATE INDEX idx_ad_region_pk_i_r ON ad_region_pk (id, region);

CREATE INDEX idx_ad_region_pk_bn ON ad_region_pk (bylines_name);

CREATE INDEX idx_ad_region_pk_adst_adst_r ON ad_region_pk (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_pk_bn_adst_adst ON ad_region_pk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_pl PARTITION OF ad_region 
    FOR VALUES IN ('pl');

CREATE INDEX idx_ad_region_pl_i ON ad_region_pl (id);

CREATE INDEX idx_ad_region_pl_i_r ON ad_region_pl (id, region);

CREATE INDEX idx_ad_region_pl_bn ON ad_region_pl (bylines_name);

CREATE INDEX idx_ad_region_pl_adst_adst_r ON ad_region_pl (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_pl_bn_adst_adst ON ad_region_pl (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_pt PARTITION OF ad_region 
    FOR VALUES IN ('pt');

CREATE INDEX idx_ad_region_pt_i ON ad_region_pt (id);

CREATE INDEX idx_ad_region_pt_i_r ON ad_region_pt (id, region);

CREATE INDEX idx_ad_region_pt_bn ON ad_region_pt (bylines_name);

CREATE INDEX idx_ad_region_pt_adst_adst_r ON ad_region_pt (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_pt_bn_adst_adst ON ad_region_pt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ro PARTITION OF ad_region 
    FOR VALUES IN ('ro');

CREATE INDEX idx_ad_region_ro_i ON ad_region_ro (id);

CREATE INDEX idx_ad_region_ro_i_r ON ad_region_ro (id, region);

CREATE INDEX idx_ad_region_ro_bn ON ad_region_ro (bylines_name);

CREATE INDEX idx_ad_region_ro_adst_adst_r ON ad_region_ro (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ro_bn_adst_adst ON ad_region_ro (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_rs PARTITION OF ad_region 
    FOR VALUES IN ('rs');

CREATE INDEX idx_ad_region_rs_i ON ad_region_rs (id);

CREATE INDEX idx_ad_region_rs_i_r ON ad_region_rs (id, region);

CREATE INDEX idx_ad_region_rs_bn ON ad_region_rs (bylines_name);

CREATE INDEX idx_ad_region_rs_adst_adst_r ON ad_region_rs (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_rs_bn_adst_adst ON ad_region_rs (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_sa PARTITION OF ad_region 
    FOR VALUES IN ('sa');

CREATE INDEX idx_ad_region_sa_i ON ad_region_sa (id);

CREATE INDEX idx_ad_region_sa_i_r ON ad_region_sa (id, region);

CREATE INDEX idx_ad_region_sa_bn ON ad_region_sa (bylines_name);

CREATE INDEX idx_ad_region_sa_adst_adst_r ON ad_region_sa (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_sa_bn_adst_adst ON ad_region_sa (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_se PARTITION OF ad_region 
    FOR VALUES IN ('se');

CREATE INDEX idx_ad_region_se_i ON ad_region_se (id);

CREATE INDEX idx_ad_region_se_i_r ON ad_region_se (id, region);

CREATE INDEX idx_ad_region_se_bn ON ad_region_se (bylines_name);

CREATE INDEX idx_ad_region_se_adst_adst_r ON ad_region_se (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_se_bn_adst_adst ON ad_region_se (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_si PARTITION OF ad_region 
    FOR VALUES IN ('si');

CREATE INDEX idx_ad_region_si_i ON ad_region_si (id);

CREATE INDEX idx_ad_region_si_i_r ON ad_region_si (id, region);

CREATE INDEX idx_ad_region_si_bn ON ad_region_si (bylines_name);

CREATE INDEX idx_ad_region_si_adst_adst_r ON ad_region_si (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_si_bn_adst_adst ON ad_region_si (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_sk PARTITION OF ad_region 
    FOR VALUES IN ('sk');

CREATE INDEX idx_ad_region_sk_i ON ad_region_sk (id);

CREATE INDEX idx_ad_region_sk_i_r ON ad_region_sk (id, region);

CREATE INDEX idx_ad_region_sk_bn ON ad_region_sk (bylines_name);

CREATE INDEX idx_ad_region_sk_adst_adst_r ON ad_region_sk (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_sk_bn_adst_adst ON ad_region_sk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_th PARTITION OF ad_region 
    FOR VALUES IN ('th');

CREATE INDEX idx_ad_region_th_i ON ad_region_th (id);

CREATE INDEX idx_ad_region_th_i_r ON ad_region_th (id, region);

CREATE INDEX idx_ad_region_th_bn ON ad_region_th (bylines_name);

CREATE INDEX idx_ad_region_th_adst_adst_r ON ad_region_th (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_th_bn_adst_adst ON ad_region_th (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_tr PARTITION OF ad_region 
    FOR VALUES IN ('tr');

CREATE INDEX idx_ad_region_tr_i ON ad_region_tr (id);

CREATE INDEX idx_ad_region_tr_i_r ON ad_region_tr (id, region);

CREATE INDEX idx_ad_region_tr_bn ON ad_region_tr (bylines_name);

CREATE INDEX idx_ad_region_tr_adst_adst_r ON ad_region_tr (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_tr_bn_adst_adst ON ad_region_tr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_ua PARTITION OF ad_region 
    FOR VALUES IN ('ua');

CREATE INDEX idx_ad_region_ua_i ON ad_region_ua (id);

CREATE INDEX idx_ad_region_ua_i_r ON ad_region_ua (id, region);

CREATE INDEX idx_ad_region_ua_bn ON ad_region_ua (bylines_name);

CREATE INDEX idx_ad_region_ua_adst_adst_r ON ad_region_ua (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_ua_bn_adst_adst ON ad_region_ua (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_us PARTITION OF ad_region 
    FOR VALUES IN ('us');

CREATE INDEX idx_ad_region_us_i ON ad_region_us (id);

CREATE INDEX idx_ad_region_us_i_r ON ad_region_us (id, region);

CREATE INDEX idx_ad_region_us_bn ON ad_region_us (bylines_name);

CREATE INDEX idx_ad_region_us_adst_adst_r ON ad_region_us (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_us_bn_adst_adst ON ad_region_us (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_vn PARTITION OF ad_region 
    FOR VALUES IN ('vn');

CREATE INDEX idx_ad_region_vn_i ON ad_region_vn (id);

CREATE INDEX idx_ad_region_vn_i_r ON ad_region_vn (id, region);

CREATE INDEX idx_ad_region_vn_bn ON ad_region_vn (bylines_name);

CREATE INDEX idx_ad_region_vn_adst_adst_r ON ad_region_vn (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_vn_bn_adst_adst ON ad_region_vn (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_xk PARTITION OF ad_region 
    FOR VALUES IN ('xk');

CREATE INDEX idx_ad_region_xk_i ON ad_region_xk (id);

CREATE INDEX idx_ad_region_xk_i_r ON ad_region_xk (id, region);

CREATE INDEX idx_ad_region_xk_bn ON ad_region_xk (bylines_name);

CREATE INDEX idx_ad_region_xk_adst_adst_r ON ad_region_xk (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_xk_bn_adst_adst ON ad_region_xk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_za PARTITION OF ad_region 
    FOR VALUES IN ('za');

CREATE INDEX idx_ad_region_za_i ON ad_region_za (id);

CREATE INDEX idx_ad_region_za_i_r ON ad_region_za (id, region);

CREATE INDEX idx_ad_region_za_bn ON ad_region_za (bylines_name);

CREATE INDEX idx_ad_region_za_adst_adst_r ON ad_region_za (ad_delivery_start_time, ad_delivery_stop_time, region);

CREATE INDEX idx_ad_region_za_bn_adst_adst ON ad_region_za (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_region_default PARTITION OF ad_region DEFAULT;
