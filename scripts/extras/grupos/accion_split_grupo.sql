UNDEFINE v_club
UNDEFINE v_grupo

CLEAR SCREEN
PROMPT ######################################################################
PROMPT #                     DIVIDIR UN GRUPO                               #
PROMPT ######################################################################
PROMPT

ACCEPT v_club PROMPT '>> Ingrese el ID del Club: '
ACCEPT v_grupo PROMPT '>> Ingrese el ID del Grupo a dividir: '

PROMPT
PROMPT Procesando division automatica...

BEGIN
    MEA_dividir_grupo(&v_club, &v_grupo);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('!!! ERROR !!!');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        ROLLBACK;
END;
/

PROMPT
PROMPT Presione ENTER para volver al menu...
PAUSE

@@menu_grupos.sql
