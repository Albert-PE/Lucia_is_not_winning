-- =============================================================================
-- TIPOS Y FUNCIONES - PROYECTO CLUBES DE LECTURA (MEA)
-- =============================================================================

CREATE OR REPLACE TYPE MEA_conversion_row AS OBJECT (
    id_pais       NUMBER,
    nom_pais      VARCHAR2(20),
    moneda        VARCHAR2(3),
    monto_origen  NUMBER,
    tasa_cambio   VARCHAR2(50),
    monto_usd     VARCHAR2(30)
);
/

CREATE OR REPLACE TYPE MEA_conversion_table AS TABLE OF MEA_conversion_row;
/

CREATE OR REPLACE FUNCTION MEA_conversion_monetaria(
    p_id_pais     IN NUMBER,
    p_monto       IN NUMBER,
    p_tasa_cambio IN NUMBER
) RETURN MEA_conversion_table PIPELINED IS
    v_monto_usd  NUMBER;
    v_moneda     VARCHAR2(3);
    v_pais       VARCHAR2(20);
BEGIN
    SELECT moneda, nom_pais INTO v_moneda, v_pais
    FROM MEA_PAISES WHERE id_pais = p_id_pais;

    IF v_moneda = 'USD' THEN v_monto_usd := p_monto;
    ELSE v_monto_usd := ROUND(p_monto / p_tasa_cambio, 2);
    END IF;

    PIPE ROW (MEA_conversion_row(p_id_pais, v_pais, v_moneda, p_monto, 
        CASE WHEN v_moneda = 'USD' THEN 'Misma moneda (USD)' ELSE '1 USD = ' || p_tasa_cambio || ' ' || v_moneda END,
        v_monto_usd || ' USD'));
    RETURN;
END;
/
