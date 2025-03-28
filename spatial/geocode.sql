--
-- Procedure "GEOCODE"
--
CREATE OR REPLACE EDITIONABLE PROCEDURE "ORADEV"."GEOCODE" (p_address IN varchar2,
                                    p_longitude OUT number,
                                    p_lattitude OUT number)
is
    v_json_o JSON_OBJECT_T;
BEGIN
    v_json_o := JSON_OBJECT_T(
                JSON_OBJECT_T(
                JSON_ARRAY_T.parse(sdo_gcdr.eloc_geocode(p_address))
                .get(0))
                .get_array('matches')
                .get(0));
    p_longitude := v_json_o.get_number('x');
    p_lattitude := v_json_o.get_number('y');
END;
/