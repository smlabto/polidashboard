CREATE TABLE ad_data_al PARTITION OF ad_data 
    FOR VALUES IN ('al');

CREATE INDEX idx_ad_data_al_i ON ad_data_al (id);

CREATE INDEX idx_ad_data_al_bn ON ad_data_al (bylines_name);

CREATE INDEX idx_ad_data_al_adst_adst ON ad_data_al (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_am PARTITION OF ad_data 
    FOR VALUES IN ('am');

CREATE INDEX idx_ad_data_am_i ON ad_data_am (id);

CREATE INDEX idx_ad_data_am_bn ON ad_data_am (bylines_name);

CREATE INDEX idx_ad_data_am_adst_adst ON ad_data_am (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_at PARTITION OF ad_data 
    FOR VALUES IN ('at');

CREATE INDEX idx_ad_data_at_i ON ad_data_at (id);

CREATE INDEX idx_ad_data_at_bn ON ad_data_at (bylines_name);

CREATE INDEX idx_ad_data_at_adst_adst ON ad_data_at (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_au PARTITION OF ad_data 
    FOR VALUES IN ('au');

CREATE INDEX idx_ad_data_au_i ON ad_data_au (id);

CREATE INDEX idx_ad_data_au_bn ON ad_data_au (bylines_name);

CREATE INDEX idx_ad_data_au_adst_adst ON ad_data_au (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_az PARTITION OF ad_data 
    FOR VALUES IN ('az');

CREATE INDEX idx_ad_data_az_i ON ad_data_az (id);

CREATE INDEX idx_ad_data_az_bn ON ad_data_az (bylines_name);

CREATE INDEX idx_ad_data_az_adst_adst ON ad_data_az (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_bd PARTITION OF ad_data 
    FOR VALUES IN ('bd');

CREATE INDEX idx_ad_data_bd_i ON ad_data_bd (id);

CREATE INDEX idx_ad_data_bd_bn ON ad_data_bd (bylines_name);

CREATE INDEX idx_ad_data_bd_adst_adst ON ad_data_bd (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_be PARTITION OF ad_data 
    FOR VALUES IN ('be');

CREATE INDEX idx_ad_data_be_i ON ad_data_be (id);

CREATE INDEX idx_ad_data_be_bn ON ad_data_be (bylines_name);

CREATE INDEX idx_ad_data_be_adst_adst ON ad_data_be (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_bg PARTITION OF ad_data 
    FOR VALUES IN ('bg');

CREATE INDEX idx_ad_data_bg_i ON ad_data_bg (id);

CREATE INDEX idx_ad_data_bg_bn ON ad_data_bg (bylines_name);

CREATE INDEX idx_ad_data_bg_adst_adst ON ad_data_bg (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_br PARTITION OF ad_data 
    FOR VALUES IN ('br');

CREATE INDEX idx_ad_data_br_i ON ad_data_br (id);

CREATE INDEX idx_ad_data_br_bn ON ad_data_br (bylines_name);

CREATE INDEX idx_ad_data_br_adst_adst ON ad_data_br (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ca PARTITION OF ad_data 
    FOR VALUES IN ('ca');

CREATE INDEX idx_ad_data_ca_i ON ad_data_ca (id);

CREATE INDEX idx_ad_data_ca_bn ON ad_data_ca (bylines_name);

CREATE INDEX idx_ad_data_ca_adst_adst ON ad_data_ca (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_cd PARTITION OF ad_data 
    FOR VALUES IN ('cd');

CREATE INDEX idx_ad_data_cd_i ON ad_data_cd (id);

CREATE INDEX idx_ad_data_cd_bn ON ad_data_cd (bylines_name);

CREATE INDEX idx_ad_data_cd_adst_adst ON ad_data_cd (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ch PARTITION OF ad_data 
    FOR VALUES IN ('ch');

CREATE INDEX idx_ad_data_ch_i ON ad_data_ch (id);

CREATE INDEX idx_ad_data_ch_bn ON ad_data_ch (bylines_name);

CREATE INDEX idx_ad_data_ch_adst_adst ON ad_data_ch (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_co PARTITION OF ad_data 
    FOR VALUES IN ('co');

CREATE INDEX idx_ad_data_co_i ON ad_data_co (id);

CREATE INDEX idx_ad_data_co_bn ON ad_data_co (bylines_name);

CREATE INDEX idx_ad_data_co_adst_adst ON ad_data_co (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_cr PARTITION OF ad_data 
    FOR VALUES IN ('cr');

CREATE INDEX idx_ad_data_cr_i ON ad_data_cr (id);

CREATE INDEX idx_ad_data_cr_bn ON ad_data_cr (bylines_name);

CREATE INDEX idx_ad_data_cr_adst_adst ON ad_data_cr (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_cy PARTITION OF ad_data 
    FOR VALUES IN ('cy');

CREATE INDEX idx_ad_data_cy_i ON ad_data_cy (id);

CREATE INDEX idx_ad_data_cy_bn ON ad_data_cy (bylines_name);

CREATE INDEX idx_ad_data_cy_adst_adst ON ad_data_cy (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_cz PARTITION OF ad_data 
    FOR VALUES IN ('cz');

CREATE INDEX idx_ad_data_cz_i ON ad_data_cz (id);

CREATE INDEX idx_ad_data_cz_bn ON ad_data_cz (bylines_name);

CREATE INDEX idx_ad_data_cz_adst_adst ON ad_data_cz (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_de PARTITION OF ad_data 
    FOR VALUES IN ('de');

CREATE INDEX idx_ad_data_de_i ON ad_data_de (id);

CREATE INDEX idx_ad_data_de_bn ON ad_data_de (bylines_name);

CREATE INDEX idx_ad_data_de_adst_adst ON ad_data_de (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_dk PARTITION OF ad_data 
    FOR VALUES IN ('dk');

CREATE INDEX idx_ad_data_dk_i ON ad_data_dk (id);

CREATE INDEX idx_ad_data_dk_bn ON ad_data_dk (bylines_name);

CREATE INDEX idx_ad_data_dk_adst_adst ON ad_data_dk (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_dz PARTITION OF ad_data 
    FOR VALUES IN ('dz');

CREATE INDEX idx_ad_data_dz_i ON ad_data_dz (id);

CREATE INDEX idx_ad_data_dz_bn ON ad_data_dz (bylines_name);

CREATE INDEX idx_ad_data_dz_adst_adst ON ad_data_dz (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ee PARTITION OF ad_data 
    FOR VALUES IN ('ee');

CREATE INDEX idx_ad_data_ee_i ON ad_data_ee (id);

CREATE INDEX idx_ad_data_ee_bn ON ad_data_ee (bylines_name);

CREATE INDEX idx_ad_data_ee_adst_adst ON ad_data_ee (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_eg PARTITION OF ad_data 
    FOR VALUES IN ('eg');

CREATE INDEX idx_ad_data_eg_i ON ad_data_eg (id);

CREATE INDEX idx_ad_data_eg_bn ON ad_data_eg (bylines_name);

CREATE INDEX idx_ad_data_eg_adst_adst ON ad_data_eg (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_es PARTITION OF ad_data 
    FOR VALUES IN ('es');

CREATE INDEX idx_ad_data_es_i ON ad_data_es (id);

CREATE INDEX idx_ad_data_es_bn ON ad_data_es (bylines_name);

CREATE INDEX idx_ad_data_es_adst_adst ON ad_data_es (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_fi PARTITION OF ad_data 
    FOR VALUES IN ('fi');

CREATE INDEX idx_ad_data_fi_i ON ad_data_fi (id);

CREATE INDEX idx_ad_data_fi_bn ON ad_data_fi (bylines_name);

CREATE INDEX idx_ad_data_fi_adst_adst ON ad_data_fi (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_fr PARTITION OF ad_data 
    FOR VALUES IN ('fr');

CREATE INDEX idx_ad_data_fr_i ON ad_data_fr (id);

CREATE INDEX idx_ad_data_fr_bn ON ad_data_fr (bylines_name);

CREATE INDEX idx_ad_data_fr_adst_adst ON ad_data_fr (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_gb PARTITION OF ad_data 
    FOR VALUES IN ('gb');

CREATE INDEX idx_ad_data_gb_i ON ad_data_gb (id);

CREATE INDEX idx_ad_data_gb_bn ON ad_data_gb (bylines_name);

CREATE INDEX idx_ad_data_gb_adst_adst ON ad_data_gb (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ge PARTITION OF ad_data 
    FOR VALUES IN ('ge');

CREATE INDEX idx_ad_data_ge_i ON ad_data_ge (id);

CREATE INDEX idx_ad_data_ge_bn ON ad_data_ge (bylines_name);

CREATE INDEX idx_ad_data_ge_adst_adst ON ad_data_ge (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_gr PARTITION OF ad_data 
    FOR VALUES IN ('gr');

CREATE INDEX idx_ad_data_gr_i ON ad_data_gr (id);

CREATE INDEX idx_ad_data_gr_bn ON ad_data_gr (bylines_name);

CREATE INDEX idx_ad_data_gr_adst_adst ON ad_data_gr (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_gt PARTITION OF ad_data 
    FOR VALUES IN ('gt');

CREATE INDEX idx_ad_data_gt_i ON ad_data_gt (id);

CREATE INDEX idx_ad_data_gt_bn ON ad_data_gt (bylines_name);

CREATE INDEX idx_ad_data_gt_adst_adst ON ad_data_gt (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_hr PARTITION OF ad_data 
    FOR VALUES IN ('hr');

CREATE INDEX idx_ad_data_hr_i ON ad_data_hr (id);

CREATE INDEX idx_ad_data_hr_bn ON ad_data_hr (bylines_name);

CREATE INDEX idx_ad_data_hr_adst_adst ON ad_data_hr (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_hu PARTITION OF ad_data 
    FOR VALUES IN ('hu');

CREATE INDEX idx_ad_data_hu_i ON ad_data_hu (id);

CREATE INDEX idx_ad_data_hu_bn ON ad_data_hu (bylines_name);

CREATE INDEX idx_ad_data_hu_adst_adst ON ad_data_hu (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_id PARTITION OF ad_data 
    FOR VALUES IN ('id');

CREATE INDEX idx_ad_data_id_i ON ad_data_id (id);

CREATE INDEX idx_ad_data_id_bn ON ad_data_id (bylines_name);

CREATE INDEX idx_ad_data_id_adst_adst ON ad_data_id (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ie PARTITION OF ad_data 
    FOR VALUES IN ('ie');

CREATE INDEX idx_ad_data_ie_i ON ad_data_ie (id);

CREATE INDEX idx_ad_data_ie_bn ON ad_data_ie (bylines_name);

CREATE INDEX idx_ad_data_ie_adst_adst ON ad_data_ie (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_il PARTITION OF ad_data 
    FOR VALUES IN ('il');

CREATE INDEX idx_ad_data_il_i ON ad_data_il (id);

CREATE INDEX idx_ad_data_il_bn ON ad_data_il (bylines_name);

CREATE INDEX idx_ad_data_il_adst_adst ON ad_data_il (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_in PARTITION OF ad_data 
    FOR VALUES IN ('in');

CREATE INDEX idx_ad_data_in_i ON ad_data_in (id);

CREATE INDEX idx_ad_data_in_bn ON ad_data_in (bylines_name);

CREATE INDEX idx_ad_data_in_adst_adst ON ad_data_in (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_it PARTITION OF ad_data 
    FOR VALUES IN ('it');

CREATE INDEX idx_ad_data_it_i ON ad_data_it (id);

CREATE INDEX idx_ad_data_it_bn ON ad_data_it (bylines_name);

CREATE INDEX idx_ad_data_it_adst_adst ON ad_data_it (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_jp PARTITION OF ad_data 
    FOR VALUES IN ('jp');

CREATE INDEX idx_ad_data_jp_i ON ad_data_jp (id);

CREATE INDEX idx_ad_data_jp_bn ON ad_data_jp (bylines_name);

CREATE INDEX idx_ad_data_jp_adst_adst ON ad_data_jp (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_lt PARTITION OF ad_data 
    FOR VALUES IN ('lt');

CREATE INDEX idx_ad_data_lt_i ON ad_data_lt (id);

CREATE INDEX idx_ad_data_lt_bn ON ad_data_lt (bylines_name);

CREATE INDEX idx_ad_data_lt_adst_adst ON ad_data_lt (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_lu PARTITION OF ad_data 
    FOR VALUES IN ('lu');

CREATE INDEX idx_ad_data_lu_i ON ad_data_lu (id);

CREATE INDEX idx_ad_data_lu_bn ON ad_data_lu (bylines_name);

CREATE INDEX idx_ad_data_lu_adst_adst ON ad_data_lu (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_lv PARTITION OF ad_data 
    FOR VALUES IN ('lv');

CREATE INDEX idx_ad_data_lv_i ON ad_data_lv (id);

CREATE INDEX idx_ad_data_lv_bn ON ad_data_lv (bylines_name);

CREATE INDEX idx_ad_data_lv_adst_adst ON ad_data_lv (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_me PARTITION OF ad_data 
    FOR VALUES IN ('me');

CREATE INDEX idx_ad_data_me_i ON ad_data_me (id);

CREATE INDEX idx_ad_data_me_bn ON ad_data_me (bylines_name);

CREATE INDEX idx_ad_data_me_adst_adst ON ad_data_me (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_mk PARTITION OF ad_data 
    FOR VALUES IN ('mk');

CREATE INDEX idx_ad_data_mk_i ON ad_data_mk (id);

CREATE INDEX idx_ad_data_mk_bn ON ad_data_mk (bylines_name);

CREATE INDEX idx_ad_data_mk_adst_adst ON ad_data_mk (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_mt PARTITION OF ad_data 
    FOR VALUES IN ('mt');

CREATE INDEX idx_ad_data_mt_i ON ad_data_mt (id);

CREATE INDEX idx_ad_data_mt_bn ON ad_data_mt (bylines_name);

CREATE INDEX idx_ad_data_mt_adst_adst ON ad_data_mt (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_mx PARTITION OF ad_data 
    FOR VALUES IN ('mx');

CREATE INDEX idx_ad_data_mx_i ON ad_data_mx (id);

CREATE INDEX idx_ad_data_mx_bn ON ad_data_mx (bylines_name);

CREATE INDEX idx_ad_data_mx_adst_adst ON ad_data_mx (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ng PARTITION OF ad_data 
    FOR VALUES IN ('ng');

CREATE INDEX idx_ad_data_ng_i ON ad_data_ng (id);

CREATE INDEX idx_ad_data_ng_bn ON ad_data_ng (bylines_name);

CREATE INDEX idx_ad_data_ng_adst_adst ON ad_data_ng (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_nl PARTITION OF ad_data 
    FOR VALUES IN ('nl');

CREATE INDEX idx_ad_data_nl_i ON ad_data_nl (id);

CREATE INDEX idx_ad_data_nl_bn ON ad_data_nl (bylines_name);

CREATE INDEX idx_ad_data_nl_adst_adst ON ad_data_nl (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_no PARTITION OF ad_data 
    FOR VALUES IN ('no');

CREATE INDEX idx_ad_data_no_i ON ad_data_no (id);

CREATE INDEX idx_ad_data_no_bn ON ad_data_no (bylines_name);

CREATE INDEX idx_ad_data_no_adst_adst ON ad_data_no (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_pa PARTITION OF ad_data 
    FOR VALUES IN ('pa');

CREATE INDEX idx_ad_data_pa_i ON ad_data_pa (id);

CREATE INDEX idx_ad_data_pa_bn ON ad_data_pa (bylines_name);

CREATE INDEX idx_ad_data_pa_adst_adst ON ad_data_pa (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ph PARTITION OF ad_data 
    FOR VALUES IN ('ph');

CREATE INDEX idx_ad_data_ph_i ON ad_data_ph (id);

CREATE INDEX idx_ad_data_ph_bn ON ad_data_ph (bylines_name);

CREATE INDEX idx_ad_data_ph_adst_adst ON ad_data_ph (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_pk PARTITION OF ad_data 
    FOR VALUES IN ('pk');

CREATE INDEX idx_ad_data_pk_i ON ad_data_pk (id);

CREATE INDEX idx_ad_data_pk_bn ON ad_data_pk (bylines_name);

CREATE INDEX idx_ad_data_pk_adst_adst ON ad_data_pk (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_pl PARTITION OF ad_data 
    FOR VALUES IN ('pl');

CREATE INDEX idx_ad_data_pl_i ON ad_data_pl (id);

CREATE INDEX idx_ad_data_pl_bn ON ad_data_pl (bylines_name);

CREATE INDEX idx_ad_data_pl_adst_adst ON ad_data_pl (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_pt PARTITION OF ad_data 
    FOR VALUES IN ('pt');

CREATE INDEX idx_ad_data_pt_i ON ad_data_pt (id);

CREATE INDEX idx_ad_data_pt_bn ON ad_data_pt (bylines_name);

CREATE INDEX idx_ad_data_pt_adst_adst ON ad_data_pt (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ro PARTITION OF ad_data 
    FOR VALUES IN ('ro');

CREATE INDEX idx_ad_data_ro_i ON ad_data_ro (id);

CREATE INDEX idx_ad_data_ro_bn ON ad_data_ro (bylines_name);

CREATE INDEX idx_ad_data_ro_adst_adst ON ad_data_ro (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_rs PARTITION OF ad_data 
    FOR VALUES IN ('rs');

CREATE INDEX idx_ad_data_rs_i ON ad_data_rs (id);

CREATE INDEX idx_ad_data_rs_bn ON ad_data_rs (bylines_name);

CREATE INDEX idx_ad_data_rs_adst_adst ON ad_data_rs (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_sa PARTITION OF ad_data 
    FOR VALUES IN ('sa');

CREATE INDEX idx_ad_data_sa_i ON ad_data_sa (id);

CREATE INDEX idx_ad_data_sa_bn ON ad_data_sa (bylines_name);

CREATE INDEX idx_ad_data_sa_adst_adst ON ad_data_sa (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_se PARTITION OF ad_data 
    FOR VALUES IN ('se');

CREATE INDEX idx_ad_data_se_i ON ad_data_se (id);

CREATE INDEX idx_ad_data_se_bn ON ad_data_se (bylines_name);

CREATE INDEX idx_ad_data_se_adst_adst ON ad_data_se (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_si PARTITION OF ad_data 
    FOR VALUES IN ('si');

CREATE INDEX idx_ad_data_si_i ON ad_data_si (id);

CREATE INDEX idx_ad_data_si_bn ON ad_data_si (bylines_name);

CREATE INDEX idx_ad_data_si_adst_adst ON ad_data_si (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_sk PARTITION OF ad_data 
    FOR VALUES IN ('sk');

CREATE INDEX idx_ad_data_sk_i ON ad_data_sk (id);

CREATE INDEX idx_ad_data_sk_bn ON ad_data_sk (bylines_name);

CREATE INDEX idx_ad_data_sk_adst_adst ON ad_data_sk (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_th PARTITION OF ad_data 
    FOR VALUES IN ('th');

CREATE INDEX idx_ad_data_th_i ON ad_data_th (id);

CREATE INDEX idx_ad_data_th_bn ON ad_data_th (bylines_name);

CREATE INDEX idx_ad_data_th_adst_adst ON ad_data_th (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_tr PARTITION OF ad_data 
    FOR VALUES IN ('tr');

CREATE INDEX idx_ad_data_tr_i ON ad_data_tr (id);

CREATE INDEX idx_ad_data_tr_bn ON ad_data_tr (bylines_name);

CREATE INDEX idx_ad_data_tr_adst_adst ON ad_data_tr (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_ua PARTITION OF ad_data 
    FOR VALUES IN ('ua');

CREATE INDEX idx_ad_data_ua_i ON ad_data_ua (id);

CREATE INDEX idx_ad_data_ua_bn ON ad_data_ua (bylines_name);

CREATE INDEX idx_ad_data_ua_adst_adst ON ad_data_ua (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_us PARTITION OF ad_data 
    FOR VALUES IN ('us');

CREATE INDEX idx_ad_data_us_i ON ad_data_us (id);

CREATE INDEX idx_ad_data_us_bn ON ad_data_us (bylines_name);

CREATE INDEX idx_ad_data_us_adst_adst ON ad_data_us (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_vn PARTITION OF ad_data 
    FOR VALUES IN ('vn');

CREATE INDEX idx_ad_data_vn_i ON ad_data_vn (id);

CREATE INDEX idx_ad_data_vn_bn ON ad_data_vn (bylines_name);

CREATE INDEX idx_ad_data_vn_adst_adst ON ad_data_vn (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_xk PARTITION OF ad_data 
    FOR VALUES IN ('xk');

CREATE INDEX idx_ad_data_xk_i ON ad_data_xk (id);

CREATE INDEX idx_ad_data_xk_bn ON ad_data_xk (bylines_name);

CREATE INDEX idx_ad_data_xk_adst_adst ON ad_data_xk (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_za PARTITION OF ad_data 
    FOR VALUES IN ('za');

CREATE INDEX idx_ad_data_za_i ON ad_data_za (id);

CREATE INDEX idx_ad_data_za_bn ON ad_data_za (bylines_name);

CREATE INDEX idx_ad_data_za_adst_adst ON ad_data_za (ad_delivery_start_time, ad_delivery_stop_time);

CREATE TABLE ad_data_default PARTITION OF ad_data DEFAULT;
