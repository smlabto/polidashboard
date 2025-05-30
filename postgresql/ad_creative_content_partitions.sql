CREATE TABLE ad_creative_content_al PARTITION OF ad_creative_content 
    FOR VALUES IN ('al');

CREATE INDEX idx_ad_creative_content_al_co_i ON ad_creative_content_al (content_order, id);

CREATE INDEX idx_ad_creative_content_al_adst_adst_co_i ON ad_creative_content_al (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_al_bn_adst_adst ON ad_creative_content_al (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_am PARTITION OF ad_creative_content 
    FOR VALUES IN ('am');

CREATE INDEX idx_ad_creative_content_am_co_i ON ad_creative_content_am (content_order, id);

CREATE INDEX idx_ad_creative_content_am_adst_adst_co_i ON ad_creative_content_am (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_am_bn_adst_adst ON ad_creative_content_am (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_at PARTITION OF ad_creative_content 
    FOR VALUES IN ('at');

CREATE INDEX idx_ad_creative_content_at_co_i ON ad_creative_content_at (content_order, id);

CREATE INDEX idx_ad_creative_content_at_adst_adst_co_i ON ad_creative_content_at (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_at_bn_adst_adst ON ad_creative_content_at (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_au PARTITION OF ad_creative_content 
    FOR VALUES IN ('au');

CREATE INDEX idx_ad_creative_content_au_co_i ON ad_creative_content_au (content_order, id);

CREATE INDEX idx_ad_creative_content_au_adst_adst_co_i ON ad_creative_content_au (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_au_bn_adst_adst ON ad_creative_content_au (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_az PARTITION OF ad_creative_content 
    FOR VALUES IN ('az');

CREATE INDEX idx_ad_creative_content_az_co_i ON ad_creative_content_az (content_order, id);

CREATE INDEX idx_ad_creative_content_az_adst_adst_co_i ON ad_creative_content_az (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_az_bn_adst_adst ON ad_creative_content_az (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_bd PARTITION OF ad_creative_content 
    FOR VALUES IN ('bd');

CREATE INDEX idx_ad_creative_content_bd_co_i ON ad_creative_content_bd (content_order, id);

CREATE INDEX idx_ad_creative_content_bd_adst_adst_co_i ON ad_creative_content_bd (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_bd_bn_adst_adst ON ad_creative_content_bd (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_be PARTITION OF ad_creative_content 
    FOR VALUES IN ('be');

CREATE INDEX idx_ad_creative_content_be_co_i ON ad_creative_content_be (content_order, id);

CREATE INDEX idx_ad_creative_content_be_adst_adst_co_i ON ad_creative_content_be (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_be_bn_adst_adst ON ad_creative_content_be (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_bg PARTITION OF ad_creative_content 
    FOR VALUES IN ('bg');

CREATE INDEX idx_ad_creative_content_bg_co_i ON ad_creative_content_bg (content_order, id);

CREATE INDEX idx_ad_creative_content_bg_adst_adst_co_i ON ad_creative_content_bg (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_bg_bn_adst_adst ON ad_creative_content_bg (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_br PARTITION OF ad_creative_content 
    FOR VALUES IN ('br');

CREATE INDEX idx_ad_creative_content_br_co_i ON ad_creative_content_br (content_order, id);

CREATE INDEX idx_ad_creative_content_br_adst_adst_co_i ON ad_creative_content_br (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_br_bn_adst_adst ON ad_creative_content_br (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ca PARTITION OF ad_creative_content 
    FOR VALUES IN ('ca');

CREATE INDEX idx_ad_creative_content_ca_co_i ON ad_creative_content_ca (content_order, id);

CREATE INDEX idx_ad_creative_content_ca_adst_adst_co_i ON ad_creative_content_ca (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ca_bn_adst_adst ON ad_creative_content_ca (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_cd PARTITION OF ad_creative_content 
    FOR VALUES IN ('cd');

CREATE INDEX idx_ad_creative_content_cd_co_i ON ad_creative_content_cd (content_order, id);

CREATE INDEX idx_ad_creative_content_cd_adst_adst_co_i ON ad_creative_content_cd (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_cd_bn_adst_adst ON ad_creative_content_cd (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ch PARTITION OF ad_creative_content 
    FOR VALUES IN ('ch');

CREATE INDEX idx_ad_creative_content_ch_co_i ON ad_creative_content_ch (content_order, id);

CREATE INDEX idx_ad_creative_content_ch_adst_adst_co_i ON ad_creative_content_ch (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ch_bn_adst_adst ON ad_creative_content_ch (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_co PARTITION OF ad_creative_content 
    FOR VALUES IN ('co');

CREATE INDEX idx_ad_creative_content_co_co_i ON ad_creative_content_co (content_order, id);

CREATE INDEX idx_ad_creative_content_co_adst_adst_co_i ON ad_creative_content_co (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_co_bn_adst_adst ON ad_creative_content_co (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_cr PARTITION OF ad_creative_content 
    FOR VALUES IN ('cr');

CREATE INDEX idx_ad_creative_content_cr_co_i ON ad_creative_content_cr (content_order, id);

CREATE INDEX idx_ad_creative_content_cr_adst_adst_co_i ON ad_creative_content_cr (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_cr_bn_adst_adst ON ad_creative_content_cr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_cy PARTITION OF ad_creative_content 
    FOR VALUES IN ('cy');

CREATE INDEX idx_ad_creative_content_cy_co_i ON ad_creative_content_cy (content_order, id);

CREATE INDEX idx_ad_creative_content_cy_adst_adst_co_i ON ad_creative_content_cy (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_cy_bn_adst_adst ON ad_creative_content_cy (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_cz PARTITION OF ad_creative_content 
    FOR VALUES IN ('cz');

CREATE INDEX idx_ad_creative_content_cz_co_i ON ad_creative_content_cz (content_order, id);

CREATE INDEX idx_ad_creative_content_cz_adst_adst_co_i ON ad_creative_content_cz (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_cz_bn_adst_adst ON ad_creative_content_cz (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_de PARTITION OF ad_creative_content 
    FOR VALUES IN ('de');

CREATE INDEX idx_ad_creative_content_de_co_i ON ad_creative_content_de (content_order, id);

CREATE INDEX idx_ad_creative_content_de_adst_adst_co_i ON ad_creative_content_de (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_de_bn_adst_adst ON ad_creative_content_de (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_dk PARTITION OF ad_creative_content 
    FOR VALUES IN ('dk');

CREATE INDEX idx_ad_creative_content_dk_co_i ON ad_creative_content_dk (content_order, id);

CREATE INDEX idx_ad_creative_content_dk_adst_adst_co_i ON ad_creative_content_dk (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_dk_bn_adst_adst ON ad_creative_content_dk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_dz PARTITION OF ad_creative_content 
    FOR VALUES IN ('dz');

CREATE INDEX idx_ad_creative_content_dz_co_i ON ad_creative_content_dz (content_order, id);

CREATE INDEX idx_ad_creative_content_dz_adst_adst_co_i ON ad_creative_content_dz (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_dz_bn_adst_adst ON ad_creative_content_dz (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ee PARTITION OF ad_creative_content 
    FOR VALUES IN ('ee');

CREATE INDEX idx_ad_creative_content_ee_co_i ON ad_creative_content_ee (content_order, id);

CREATE INDEX idx_ad_creative_content_ee_adst_adst_co_i ON ad_creative_content_ee (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ee_bn_adst_adst ON ad_creative_content_ee (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_eg PARTITION OF ad_creative_content 
    FOR VALUES IN ('eg');

CREATE INDEX idx_ad_creative_content_eg_co_i ON ad_creative_content_eg (content_order, id);

CREATE INDEX idx_ad_creative_content_eg_adst_adst_co_i ON ad_creative_content_eg (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_eg_bn_adst_adst ON ad_creative_content_eg (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_es PARTITION OF ad_creative_content 
    FOR VALUES IN ('es');

CREATE INDEX idx_ad_creative_content_es_co_i ON ad_creative_content_es (content_order, id);

CREATE INDEX idx_ad_creative_content_es_adst_adst_co_i ON ad_creative_content_es (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_es_bn_adst_adst ON ad_creative_content_es (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_fi PARTITION OF ad_creative_content 
    FOR VALUES IN ('fi');

CREATE INDEX idx_ad_creative_content_fi_co_i ON ad_creative_content_fi (content_order, id);

CREATE INDEX idx_ad_creative_content_fi_adst_adst_co_i ON ad_creative_content_fi (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_fi_bn_adst_adst ON ad_creative_content_fi (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_fr PARTITION OF ad_creative_content 
    FOR VALUES IN ('fr');

CREATE INDEX idx_ad_creative_content_fr_co_i ON ad_creative_content_fr (content_order, id);

CREATE INDEX idx_ad_creative_content_fr_adst_adst_co_i ON ad_creative_content_fr (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_fr_bn_adst_adst ON ad_creative_content_fr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_gb PARTITION OF ad_creative_content 
    FOR VALUES IN ('gb');

CREATE INDEX idx_ad_creative_content_gb_co_i ON ad_creative_content_gb (content_order, id);

CREATE INDEX idx_ad_creative_content_gb_adst_adst_co_i ON ad_creative_content_gb (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_gb_bn_adst_adst ON ad_creative_content_gb (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ge PARTITION OF ad_creative_content 
    FOR VALUES IN ('ge');

CREATE INDEX idx_ad_creative_content_ge_co_i ON ad_creative_content_ge (content_order, id);

CREATE INDEX idx_ad_creative_content_ge_adst_adst_co_i ON ad_creative_content_ge (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ge_bn_adst_adst ON ad_creative_content_ge (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_gr PARTITION OF ad_creative_content 
    FOR VALUES IN ('gr');

CREATE INDEX idx_ad_creative_content_gr_co_i ON ad_creative_content_gr (content_order, id);

CREATE INDEX idx_ad_creative_content_gr_adst_adst_co_i ON ad_creative_content_gr (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_gr_bn_adst_adst ON ad_creative_content_gr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_gt PARTITION OF ad_creative_content 
    FOR VALUES IN ('gt');

CREATE INDEX idx_ad_creative_content_gt_co_i ON ad_creative_content_gt (content_order, id);

CREATE INDEX idx_ad_creative_content_gt_adst_adst_co_i ON ad_creative_content_gt (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_gt_bn_adst_adst ON ad_creative_content_gt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_hr PARTITION OF ad_creative_content 
    FOR VALUES IN ('hr');

CREATE INDEX idx_ad_creative_content_hr_co_i ON ad_creative_content_hr (content_order, id);

CREATE INDEX idx_ad_creative_content_hr_adst_adst_co_i ON ad_creative_content_hr (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_hr_bn_adst_adst ON ad_creative_content_hr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_hu PARTITION OF ad_creative_content 
    FOR VALUES IN ('hu');

CREATE INDEX idx_ad_creative_content_hu_co_i ON ad_creative_content_hu (content_order, id);

CREATE INDEX idx_ad_creative_content_hu_adst_adst_co_i ON ad_creative_content_hu (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_hu_bn_adst_adst ON ad_creative_content_hu (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_id PARTITION OF ad_creative_content 
    FOR VALUES IN ('id');

CREATE INDEX idx_ad_creative_content_id_co_i ON ad_creative_content_id (content_order, id);

CREATE INDEX idx_ad_creative_content_id_adst_adst_co_i ON ad_creative_content_id (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_id_bn_adst_adst ON ad_creative_content_id (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ie PARTITION OF ad_creative_content 
    FOR VALUES IN ('ie');

CREATE INDEX idx_ad_creative_content_ie_co_i ON ad_creative_content_ie (content_order, id);

CREATE INDEX idx_ad_creative_content_ie_adst_adst_co_i ON ad_creative_content_ie (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ie_bn_adst_adst ON ad_creative_content_ie (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_il PARTITION OF ad_creative_content 
    FOR VALUES IN ('il');

CREATE INDEX idx_ad_creative_content_il_co_i ON ad_creative_content_il (content_order, id);

CREATE INDEX idx_ad_creative_content_il_adst_adst_co_i ON ad_creative_content_il (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_il_bn_adst_adst ON ad_creative_content_il (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_in PARTITION OF ad_creative_content 
    FOR VALUES IN ('in');

CREATE INDEX idx_ad_creative_content_in_co_i ON ad_creative_content_in (content_order, id);

CREATE INDEX idx_ad_creative_content_in_adst_adst_co_i ON ad_creative_content_in (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_in_bn_adst_adst ON ad_creative_content_in (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_it PARTITION OF ad_creative_content 
    FOR VALUES IN ('it');

CREATE INDEX idx_ad_creative_content_it_co_i ON ad_creative_content_it (content_order, id);

CREATE INDEX idx_ad_creative_content_it_adst_adst_co_i ON ad_creative_content_it (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_it_bn_adst_adst ON ad_creative_content_it (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_jp PARTITION OF ad_creative_content 
    FOR VALUES IN ('jp');

CREATE INDEX idx_ad_creative_content_jp_co_i ON ad_creative_content_jp (content_order, id);

CREATE INDEX idx_ad_creative_content_jp_adst_adst_co_i ON ad_creative_content_jp (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_jp_bn_adst_adst ON ad_creative_content_jp (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_lt PARTITION OF ad_creative_content 
    FOR VALUES IN ('lt');

CREATE INDEX idx_ad_creative_content_lt_co_i ON ad_creative_content_lt (content_order, id);

CREATE INDEX idx_ad_creative_content_lt_adst_adst_co_i ON ad_creative_content_lt (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_lt_bn_adst_adst ON ad_creative_content_lt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_lu PARTITION OF ad_creative_content 
    FOR VALUES IN ('lu');

CREATE INDEX idx_ad_creative_content_lu_co_i ON ad_creative_content_lu (content_order, id);

CREATE INDEX idx_ad_creative_content_lu_adst_adst_co_i ON ad_creative_content_lu (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_lu_bn_adst_adst ON ad_creative_content_lu (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_lv PARTITION OF ad_creative_content 
    FOR VALUES IN ('lv');

CREATE INDEX idx_ad_creative_content_lv_co_i ON ad_creative_content_lv (content_order, id);

CREATE INDEX idx_ad_creative_content_lv_adst_adst_co_i ON ad_creative_content_lv (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_lv_bn_adst_adst ON ad_creative_content_lv (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_me PARTITION OF ad_creative_content 
    FOR VALUES IN ('me');

CREATE INDEX idx_ad_creative_content_me_co_i ON ad_creative_content_me (content_order, id);

CREATE INDEX idx_ad_creative_content_me_adst_adst_co_i ON ad_creative_content_me (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_me_bn_adst_adst ON ad_creative_content_me (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_mk PARTITION OF ad_creative_content 
    FOR VALUES IN ('mk');

CREATE INDEX idx_ad_creative_content_mk_co_i ON ad_creative_content_mk (content_order, id);

CREATE INDEX idx_ad_creative_content_mk_adst_adst_co_i ON ad_creative_content_mk (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_mk_bn_adst_adst ON ad_creative_content_mk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_mt PARTITION OF ad_creative_content 
    FOR VALUES IN ('mt');

CREATE INDEX idx_ad_creative_content_mt_co_i ON ad_creative_content_mt (content_order, id);

CREATE INDEX idx_ad_creative_content_mt_adst_adst_co_i ON ad_creative_content_mt (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_mt_bn_adst_adst ON ad_creative_content_mt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_mx PARTITION OF ad_creative_content 
    FOR VALUES IN ('mx');

CREATE INDEX idx_ad_creative_content_mx_co_i ON ad_creative_content_mx (content_order, id);

CREATE INDEX idx_ad_creative_content_mx_adst_adst_co_i ON ad_creative_content_mx (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_mx_bn_adst_adst ON ad_creative_content_mx (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ng PARTITION OF ad_creative_content 
    FOR VALUES IN ('ng');

CREATE INDEX idx_ad_creative_content_ng_co_i ON ad_creative_content_ng (content_order, id);

CREATE INDEX idx_ad_creative_content_ng_adst_adst_co_i ON ad_creative_content_ng (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ng_bn_adst_adst ON ad_creative_content_ng (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_nl PARTITION OF ad_creative_content 
    FOR VALUES IN ('nl');

CREATE INDEX idx_ad_creative_content_nl_co_i ON ad_creative_content_nl (content_order, id);

CREATE INDEX idx_ad_creative_content_nl_adst_adst_co_i ON ad_creative_content_nl (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_nl_bn_adst_adst ON ad_creative_content_nl (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_no PARTITION OF ad_creative_content 
    FOR VALUES IN ('no');

CREATE INDEX idx_ad_creative_content_no_co_i ON ad_creative_content_no (content_order, id);

CREATE INDEX idx_ad_creative_content_no_adst_adst_co_i ON ad_creative_content_no (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_no_bn_adst_adst ON ad_creative_content_no (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_pa PARTITION OF ad_creative_content 
    FOR VALUES IN ('pa');

CREATE INDEX idx_ad_creative_content_pa_co_i ON ad_creative_content_pa (content_order, id);

CREATE INDEX idx_ad_creative_content_pa_adst_adst_co_i ON ad_creative_content_pa (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_pa_bn_adst_adst ON ad_creative_content_pa (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ph PARTITION OF ad_creative_content 
    FOR VALUES IN ('ph');

CREATE INDEX idx_ad_creative_content_ph_co_i ON ad_creative_content_ph (content_order, id);

CREATE INDEX idx_ad_creative_content_ph_adst_adst_co_i ON ad_creative_content_ph (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ph_bn_adst_adst ON ad_creative_content_ph (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_pk PARTITION OF ad_creative_content 
    FOR VALUES IN ('pk');

CREATE INDEX idx_ad_creative_content_pk_co_i ON ad_creative_content_pk (content_order, id);

CREATE INDEX idx_ad_creative_content_pk_adst_adst_co_i ON ad_creative_content_pk (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_pk_bn_adst_adst ON ad_creative_content_pk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_pl PARTITION OF ad_creative_content 
    FOR VALUES IN ('pl');

CREATE INDEX idx_ad_creative_content_pl_co_i ON ad_creative_content_pl (content_order, id);

CREATE INDEX idx_ad_creative_content_pl_adst_adst_co_i ON ad_creative_content_pl (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_pl_bn_adst_adst ON ad_creative_content_pl (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_pt PARTITION OF ad_creative_content 
    FOR VALUES IN ('pt');

CREATE INDEX idx_ad_creative_content_pt_co_i ON ad_creative_content_pt (content_order, id);

CREATE INDEX idx_ad_creative_content_pt_adst_adst_co_i ON ad_creative_content_pt (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_pt_bn_adst_adst ON ad_creative_content_pt (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ro PARTITION OF ad_creative_content 
    FOR VALUES IN ('ro');

CREATE INDEX idx_ad_creative_content_ro_co_i ON ad_creative_content_ro (content_order, id);

CREATE INDEX idx_ad_creative_content_ro_adst_adst_co_i ON ad_creative_content_ro (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ro_bn_adst_adst ON ad_creative_content_ro (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_rs PARTITION OF ad_creative_content 
    FOR VALUES IN ('rs');

CREATE INDEX idx_ad_creative_content_rs_co_i ON ad_creative_content_rs (content_order, id);

CREATE INDEX idx_ad_creative_content_rs_adst_adst_co_i ON ad_creative_content_rs (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_rs_bn_adst_adst ON ad_creative_content_rs (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_sa PARTITION OF ad_creative_content 
    FOR VALUES IN ('sa');

CREATE INDEX idx_ad_creative_content_sa_co_i ON ad_creative_content_sa (content_order, id);

CREATE INDEX idx_ad_creative_content_sa_adst_adst_co_i ON ad_creative_content_sa (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_sa_bn_adst_adst ON ad_creative_content_sa (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_se PARTITION OF ad_creative_content 
    FOR VALUES IN ('se');

CREATE INDEX idx_ad_creative_content_se_co_i ON ad_creative_content_se (content_order, id);

CREATE INDEX idx_ad_creative_content_se_adst_adst_co_i ON ad_creative_content_se (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_se_bn_adst_adst ON ad_creative_content_se (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_si PARTITION OF ad_creative_content 
    FOR VALUES IN ('si');

CREATE INDEX idx_ad_creative_content_si_co_i ON ad_creative_content_si (content_order, id);

CREATE INDEX idx_ad_creative_content_si_adst_adst_co_i ON ad_creative_content_si (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_si_bn_adst_adst ON ad_creative_content_si (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_sk PARTITION OF ad_creative_content 
    FOR VALUES IN ('sk');

CREATE INDEX idx_ad_creative_content_sk_co_i ON ad_creative_content_sk (content_order, id);

CREATE INDEX idx_ad_creative_content_sk_adst_adst_co_i ON ad_creative_content_sk (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_sk_bn_adst_adst ON ad_creative_content_sk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_th PARTITION OF ad_creative_content 
    FOR VALUES IN ('th');

CREATE INDEX idx_ad_creative_content_th_co_i ON ad_creative_content_th (content_order, id);

CREATE INDEX idx_ad_creative_content_th_adst_adst_co_i ON ad_creative_content_th (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_th_bn_adst_adst ON ad_creative_content_th (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_tr PARTITION OF ad_creative_content 
    FOR VALUES IN ('tr');

CREATE INDEX idx_ad_creative_content_tr_co_i ON ad_creative_content_tr (content_order, id);

CREATE INDEX idx_ad_creative_content_tr_adst_adst_co_i ON ad_creative_content_tr (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_tr_bn_adst_adst ON ad_creative_content_tr (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_ua PARTITION OF ad_creative_content 
    FOR VALUES IN ('ua');

CREATE INDEX idx_ad_creative_content_ua_co_i ON ad_creative_content_ua (content_order, id);

CREATE INDEX idx_ad_creative_content_ua_adst_adst_co_i ON ad_creative_content_ua (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_ua_bn_adst_adst ON ad_creative_content_ua (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_us PARTITION OF ad_creative_content 
    FOR VALUES IN ('us');

CREATE INDEX idx_ad_creative_content_us_co_i ON ad_creative_content_us (content_order, id);

CREATE INDEX idx_ad_creative_content_us_adst_adst_co_i ON ad_creative_content_us (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_us_bn_adst_adst ON ad_creative_content_us (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_vn PARTITION OF ad_creative_content 
    FOR VALUES IN ('vn');

CREATE INDEX idx_ad_creative_content_vn_co_i ON ad_creative_content_vn (content_order, id);

CREATE INDEX idx_ad_creative_content_vn_adst_adst_co_i ON ad_creative_content_vn (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_vn_bn_adst_adst ON ad_creative_content_vn (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_xk PARTITION OF ad_creative_content 
    FOR VALUES IN ('xk');

CREATE INDEX idx_ad_creative_content_xk_co_i ON ad_creative_content_xk (content_order, id);

CREATE INDEX idx_ad_creative_content_xk_adst_adst_co_i ON ad_creative_content_xk (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_xk_bn_adst_adst ON ad_creative_content_xk (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_za PARTITION OF ad_creative_content 
    FOR VALUES IN ('za');

CREATE INDEX idx_ad_creative_content_za_co_i ON ad_creative_content_za (content_order, id);

CREATE INDEX idx_ad_creative_content_za_adst_adst_co_i ON ad_creative_content_za (ad_delivery_start_time, ad_delivery_stop_time, content_order, id);

CREATE INDEX idx_ad_creative_content_za_bn_adst_adst ON ad_creative_content_za (bylines_name, ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_creative_content_default PARTITION OF ad_creative_content DEFAULT;
