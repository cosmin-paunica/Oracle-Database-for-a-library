-- 4: Implementati un Oracle diagrama conceptuala realizata: definiti toate tabelele,
-- implementand toate constrangerile de integritate necesare (chei primare, cheile externe etc).
CREATE TABLE utilizatori (
    id_utilizator       NUMBER PRIMARY KEY NOT NULL,
    email               VARCHAR2(63) NOT NULL,
    nr_telefon          VARCHAR2(63),
    nume                VARCHAR2(63) NOT NULL,
    prenume             VARCHAR2(63) NOT NULL,
    parola              VARCHAR(255) NOT NULL,
    rol                 VARCHAR(63) DEFAULT 'nevalidat' NOT NULL,
    data_inregistrare   DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE carti (
    id_carte        NUMBER PRIMARY KEY NOT NULL,
    titlu           VARCHAR2(63) NOT NULL,
    serie           VARCHAR2(255),
    limba           VARCHAR2(63) NOT NULL,
    data_publicare  DATE,
    numar_pagini    NUMBER NOT NULL,
    link_goodreads  VARCHAR2(255),
    numar_exemplare NUMBER NOT NULL
);

CREATE TABLE autori (
    id_autor        NUMBER PRIMARY KEY NOT NULL,
    nume            VARCHAR(255) NOT NULL,
    data_nastere    DATE,
    data_deces      DATE,
    nationalitate   VARCHAR(63)
);

CREATE TABLE scrise_de (
    id_carte    NUMBER NOT NULL,
    id_autor    NUMBER NOT NULL,
    PRIMARY KEY (id_autor, id_carte)
);

ALTER TABLE scrise_de
ADD CONSTRAINT fk_autori_carti_1 FOREIGN KEY (id_autor)
REFERENCES autori(id_autor)
ON DELETE CASCADE;

ALTER TABLE scrise_de
ADD CONSTRAINT fk_autori_carti_2 FOREIGN KEY (id_carte)
REFERENCES carti(id_carte)
ON DELETE CASCADE;

CREATE TABLE imprumuturi (
    id_utilizator   NUMBER NOT NULL,
    id_carte        NUMBER NOT NULL,
    data_inceput    DATE NOT NULL,
    termen_predare  DATE NOT NULL,
    stare           VARCHAR2(63) DEFAULT 'neincheiat' NOT NULL,
    PRIMARY KEY (id_utilizator, id_carte, data_inceput)
);

ALTER TABLE imprumuturi
ADD CONSTRAINT fk_imprumuturi_1 FOREIGN KEY (id_utilizator)
REFERENCES utilizatori(id_utilizator)
ON DELETE CASCADE;

ALTER TABLE imprumuturi
ADD CONSTRAINT fk_imprumuturi_2 FOREIGN KEY (id_carte)
REFERENCES carti(id_carte)
ON DELETE CASCADE;

CREATE TABLE abonamente (
    id_utilizator   NUMBER NOT NULL,
    data_inceput    DATE NOT NULL,
    data_expirare   DATE NOT NULL,
    PRIMARY KEY (id_utilizator, data_inceput)
);

ALTER TABLE abonamente
ADD CONSTRAINT fk_abonamente_1 FOREIGN KEY (id_utilizator)
REFERENCES utilizatori(id_utilizator)
ON DELETE CASCADE;

CREATE TABLE noteaza (
    id_utilizator   NUMBER NOT NULL,
    id_carte        NUMBER NOT NULL,
    data_notare     DATE DEFAULT SYSDATE NOT NULL,
    valoare_nota    NUMBER NOT NULL,
    PRIMARY KEY (id_utilizator, id_carte)
);

ALTER TABLE noteaza
ADD CONSTRAINT fk_note_1 FOREIGN KEY (id_utilizator)
REFERENCES utilizatori(id_utilizator)
ON DELETE CASCADE;

ALTER TABLE noteaza
ADD CONSTRAINT fk_note_2 FOREIGN KEY (id_carte)
REFERENCES carti(id_carte)
ON DELETE CASCADE;

CREATE TABLE rezervari (
    data_rezervare  DATE DEFAULT SYSDATE NOT NULL,
    id_carte        NUMBER NOT NULL,
    id_utilizator   NUMBER NOT NULL,
    PRIMARY KEY (data_rezervare, id_carte, id_utilizator)
);

ALTER TABLE rezervari
ADD CONSTRAINT fk_rezervari_1 FOREIGN KEY (id_carte)
REFERENCES carti(id_carte)
ON DELETE CASCADE;

ALTER TABLE rezervari
ADD CONSTRAINT fk_rezervari_2 FOREIGN KEY (id_utilizator)
REFERENCES utilizatori(id_utilizator)
ON DELETE CASCADE;

-- 5: Adaugati informatii coerente in tabelele create
-- (minim 3-5 inregistrari pentru fiecare entitate independenta; minim 10 inregistrari pentru tabela asociativa).
INSERT INTO utilizatori
VALUES (1, 'mihai_popescu@yahoo.com', '0711223344', 'Mihai', 'Popescu', 'a80b568a237f50391d2f1f97beaf99564e33d2e1c8a2e5cac21ceda701570312', 'admin', TO_DATE('30-12-2020', 'DD-MM-YYYY'));
INSERT INTO utilizatori
VALUES (2, 'ion_mihailescu@gmail.com', '0711223345', 'Ion', 'Mihailescu', 'd7e4c20f00d74ac0704cf339815f537f08f011d76ed0343a811a71fc8e45f375', 'bibliotecar', TO_DATE('30-12-2020', 'DD-MM-YYYY'));
INSERT INTO utilizatori
VALUES (3, 'georgecostin05@hotmail.com', '0711223346', 'George', 'Costin', '77659c0c99557f451219e5f9dc633708ba58bbbc517d11ae4d4382c9a7c46f7e', 'bibliotecar', TO_DATE('30-12-2020', 'DD-MM-YYYY'));
INSERT INTO utilizatori
VALUES (4, 'cosmin0321@yahoo.com', '0711223347', 'Cosmin', 'Ionita', '9c92317d2c88ec02572daa6eefb23264d1d15fb19a8e41764cd4e481c82806c6', 'client', TO_DATE('30-12-2020', 'DD-MM-YYYY'));
INSERT INTO utilizatori
VALUES (5, 'mihaela.petrescu@yahoo.com', '0711223348', 'Mihaela', 'Petrescu', '284c9be06df4ac6f4015d21c9c74848e55e0f390aa001b6d0bb38b9cb8b89882', 'client', TO_DATE('30-12-2020', 'DD-MM-YYYY'));
INSERT INTO utilizatori
VALUES (6, 'elenatoma@gmail.com', '0711223349', 'Elena', 'Toma', 'eeb718a05e5765c5e521bfdda5570ce265914a9a4f53e263defb233338fe499e', 'client', TO_DATE('30-12-2020', 'DD-MM-YYYY'));

INSERT INTO carti
VALUES (1, 'Dune', 'Dune', 'romana', TO_DATE('01-08-1965', 'DD-MM-YYYY'), 632, 'https://www.goodreads.com/book/show/44767458-dune', 8);
INSERT INTO carti
VALUES (2, 'Crima si pedeapsa', NULL, 'romana', TO_DATE('01-01-1866', 'DD-MM-YYYY'), 540, 'https://www.goodreads.com/book/show/7144.Crime_and_Punishment', 5);
INSERT INTO carti
VALUES (3, 'Programarea in limbajul C/C++ pentru liceu, volumul 1', 'Programarea in limbajul C/C++ pentru liceu', 'romana', TO_DATE('01-01-2005', 'DD-MM-YYYY'), 275, 'https://www.goodreads.com/book/show/32313819', 4);
INSERT INTO carti
VALUES (4, 'O mie noua sute optzeci si patru', NULL, 'romana', TO_DATE('08-06-1949', 'DD-MM-YYYY'), 328, 'https://www.goodreads.com/book/show/40961427-1984', 11);
INSERT INTO carti
VALUES (5, 'Dracula', NULL, 'engleza', TO_DATE('26-05-1897', 'DD-MM-YYYY'), 418, 'https://www.goodreads.com/book/show/17245.Dracula', 8);
INSERT INTO carti
VALUES (6, 'Mantuitorul Dunei', 'Dune', 'romana', TO_DATE('01-01-1969', 'DD-MM-YYYY'), 256, 'https://www.goodreads.com/book/show/44492285-dune-messiah', 4);
INSERT INTO carti
VALUES (7, 'Fratii Karamazov', NULL, 'romana', TO_DATE('01-01-1879', 'DD-MM-YYYY'), 1136, 'https://www.goodreads.com/book/show/4934.The_Brothers_Karamazov', 3);
INSERT INTO carti
VALUES (8, 'The Shining', NULL, 'engleza', TO_DATE('29-01-1977', 'DD-MM-YYYY'), 447, 'https://www.goodreads.com/book/show/11588.The_Shining', 7);
INSERT INTO carti
VALUES (9, 'Cartea Rosie', NULL, 'romana', TO_DATE('23-05-1967', 'DD-MM-YYYY'), 511, NULL, 4);

INSERT INTO autori
VALUES (1, 'Frank Herbert', TO_DATE('08-10-1920', 'DD-MM-YYYY'), TO_DATE('11-02-1986', 'DD-MM-YYYY'), 'americana');
INSERT INTO autori
VALUES (2, 'Feodor Dostoievski', TO_DATE('30-10-1821', 'DD-MM-YYYY'), TO_DATE('28-01-1881', 'DD-MM-YYYY'), 'rusa');
INSERT INTO autori
VALUES (3, 'Emanuela Cerchez', NULL, NULL, 'romana');
INSERT INTO autori
VALUES (4, 'Marinel Serban', NULL, NULL, 'romana');
INSERT INTO autori
VALUES (5, 'George Orwell', TO_DATE('25-06-1903', 'DD-MM-YYYY'), TO_DATE('21-01-1950', 'DD-MM-YYYY'), 'engleza');
INSERT INTO autori
VALUES (6, 'Bram Stoker', TO_DATE('08-11-1847', 'DD-MM-YYYY'), TO_DATE('20-04-1912', 'DD-MM-YYYY'), 'irlandeza');
INSERT INTO autori
VALUES (7, 'Stephen King', TO_DATE('21-09-1947', 'DD-MM-YYYY'), NULL, 'americana');
INSERT INTO autori
VALUES (8, 'Emanuela Cerchez', TO_DATE('12-06-1923', 'DD-MM-YYYY'), TO_DATE('18-02-1994', 'DD-MM-YYYY'), 'romana');

INSERT INTO scrise_de
VALUES (1, 1);
INSERT INTO scrise_de
VALUES (2, 2);
INSERT INTO scrise_de
VALUES (3, 3);
INSERT INTO scrise_de
VALUES (3, 4);
INSERT INTO scrise_de
VALUES (4, 5);
INSERT INTO scrise_de
VALUES (5, 6);
INSERT INTO scrise_de
VALUES (6, 1);
INSERT INTO scrise_de
VALUES (7, 2);
INSERT INTO scrise_de
VALUES (8, 7);
INSERT INTO scrise_de
VALUES (9, 8);

INSERT INTO noteaza
VALUES (4, 1, SYSDATE, 5);
INSERT INTO noteaza
VALUES (4, 2, SYSDATE, 3);
INSERT INTO noteaza
VALUES (4, 4, SYSDATE, 3);
INSERT INTO noteaza
VALUES (5, 1, SYSDATE, 4);
INSERT INTO noteaza
VALUES (5, 3, SYSDATE, 2);
INSERT INTO noteaza
VALUES (2, 3, SYSDATE, 3);
INSERT INTO noteaza
VALUES (2, 6, SYSDATE, 5);
INSERT INTO noteaza
VALUES (3, 1, SYSDATE, 4);
INSERT INTO noteaza
VALUES (3, 2, SYSDATE, 4);
INSERT INTO noteaza
VALUES (4, 6, SYSDATE, 4);

INSERT INTO abonamente
VALUES (5, TO_DATE('03-01-2021', 'DD-MM-YYYY'), TO_DATE('03-01-2021', 'DD-MM-YYYY'));
INSERT INTO abonamente
VALUES (4, TO_DATE('04-01-2021', 'DD-MM-YYYY'), TO_DATE('04-07-2021', 'DD-MM-YYYY'));
INSERT INTO abonamente
VALUES (6, TO_DATE('04-01-2021', 'DD-MM-YYYY'), TO_DATE('04-01-2022', 'DD-MM-YYYY'));

INSERT INTO imprumuturi
VALUES (4, 3, TO_DATE('04-01-2021', 'DD-MM-YYYY'), TO_DATE('25-01-2021', 'DD-MM-YYYY'), 'neincheiat');
INSERT INTO imprumuturi
VALUES (4, 5, TO_DATE('04-01-2021', 'DD-MM-YYYY'), TO_DATE('25-01-2021', 'DD-MM-YYYY'), 'neincheiat');
INSERT INTO imprumuturi
VALUES (5, 1, TO_DATE('07-01-2021', 'DD-MM-YYYY'), TO_DATE('28-01-2021', 'DD-MM-YYYY'), 'neincheiat');
INSERT INTO imprumuturi
VALUES (6, 2, TO_DATE('10-01-2021', 'DD-MM-YYYY'), TO_DATE('31-01-2021', 'DD-MM-YYYY'), 'neincheiat');

INSERT INTO rezervari
VALUES (TO_DATE('08-01-2021', 'MM-DD-YYYY'), 1, 4);
INSERT INTO rezervari
VALUES (TO_DATE('08-01-2021', 'MM-DD-YYYY'), 2, 5);
INSERT INTO rezervari
VALUES (TO_DATE('12-01-2021', 'MM-DD-YYYY'), 6, 6);

-- 6: Definiti un subprogram stocat care sa utilizeze un tip de colectie studiat. Apelati subprogramul.
CREATE OR REPLACE PROCEDURE afis_liste_autori IS
    TYPE autori_carti IS RECORD (
        titlu_carte carti.titlu%TYPE,
        id_carte    carti.id_carte%TYPE,
        nume_autor  autori.nume%TYPE
    );
    TYPE arr_autori_carti IS TABLE OF autori_carti INDEX BY PLS_INTEGER;
    t           arr_autori_carti;
    id_curent   scrise_de.id_carte%TYPE := -1;
BEGIN
    SELECT titlu, s.id_carte, nume
    BULK COLLECT INTO t
    FROM scrise_de s
    JOIN carti c ON (s.id_carte = c.id_carte)
    JOIN autori a ON (s.id_autor = a.id_autor)
    ORDER BY c.id_carte;
    FOR i IN t.FIRST..t.LAST LOOP
        IF NOT t(i).id_carte = id_curent THEN
            id_curent := t(i).id_carte;
            DBMS_OUTPUT.PUT_LINE(t(i).titlu_carte || ':');
        END IF;
        DBMS_OUTPUT.PUT_LINE('  ' || t(i).nume_autor);
    END LOOP;
END afis_liste_autori;
/

BEGIN
    afis_liste_autori;
END;
/

-- 7: Definiti un subprogram stocat care sa utilizeze un tip de cursor studiat. Apelati subprogramul.
CREATE OR REPLACE PROCEDURE note_carti(nume_autor autori.nume%TYPE) IS
    CURSOR c_note IS (
        SELECT titlu, AVG(valoare_nota) nota_medie
        FROM noteaza n
        JOIN carti c ON (n.id_carte = c.id_carte)
        JOIN scrise_de s ON (n.id_carte = s.id_carte)
        JOIN autori a ON (s.id_autor = a.id_autor)
        WHERE a.nume = nume_autor
        GROUP BY titlu
    );
BEGIN
    FOR x IN c_note LOOP
        DBMS_OUTPUT.PUT_LINE(x.titlu || ': ' || ROUND(x.nota_medie, 2));
    END LOOP;
END note_carti;
/

BEGIN
    note_carti('Frank Herbert');
END;
/

-- 8: Definiti un subprogram stocat de tip functie care sa utilizeze 3 dintre tabelele definite.
-- Tratati toate exceptiile care pot aparea. Apelati subprogramul astfel incât sa evidentiati toate cazurile tratate.
CREATE OR REPLACE FUNCTION numar_carti(nume_autor autori.nume%TYPE)
RETURN NUMBER IS
    nr          NUMBER;
    verif_aut   NUMBER;
BEGIN
    SELECT COUNT(*) INTO verif_aut
    FROM autori
    WHERE INITCAP(nume) = INITCAP(nume_autor);
    IF verif_aut = 0 THEN
        RAISE NO_DATA_FOUND;
    ELSIF verif_aut > 1 THEN
        RAISE TOO_MANY_ROWS;
    END IF;
    
    SELECT COUNT(c.id_carte) INTO nr
    FROM carti c
    JOIN scrise_de s ON (c.id_carte = s.id_carte)
    JOIN autori a ON (s.id_autor = a.id_autor)
    WHERE INITCAP(a.nume) = INITCAP(nume_autor);
    RETURN nr;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista autor cu numele dat');
        RETURN -1;
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi autori cu numele dat');
        RETURN -2;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare');
        RETURN -3;
END numar_carti;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(numar_carti('Frank Herbert'));
    DBMS_OUTPUT.PUT_LINE(numar_carti('Anton Pann'));
    DBMS_OUTPUT.PUT_LINE(numar_carti('Emanuela Cerchez'));
END;
/

-- 9: Definiti un subprogram stocat de tip procedura care sa utilizeze 5 dintre tabelele definite.
-- Tratati toate exceptiile care pot aparea. Apelati subprogramul astfel incât sa evidentiati toate cazurile tratate.
CREATE OR REPLACE PROCEDURE carti_imprumutate (
    cod_utilizator  utilizatori.id_utilizator%TYPE,
    nume_autor      autori.nume%TYPE
) IS
    CURSOR c_carti IS (
        SELECT titlu
        FROM carti c
        JOIN imprumuturi i ON (c.id_carte = i.id_carte)
        JOIN utilizatori u ON (i.id_utilizator = u.id_utilizator)
        JOIN scrise_de s ON (c.id_carte = s.id_carte)
        JOIN autori a ON (s.id_autor = a.id_autor)
        WHERE u.id_utilizator = cod_utilizator
        AND INITCAP(a.nume) = INITCAP(nume_autor)
    );
    v_carte         carti.titlu%TYPE;
    verif_aut       NUMBER;
    verif_util      NUMBER;
    nu_exista_util  EXCEPTION;
    nu_exista_aut   EXCEPTION;
    mai_multi_aut   EXCEPTION;
    nu_exista_carti EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO verif_util
    FROM utilizatori
    WHERE id_utilizator = cod_utilizator;
    IF verif_util = 0 THEN
        RAISE nu_exista_util;
    END IF;
    
    SELECT COUNT(*) INTO verif_aut
    FROM autori
    WHERE nume = nume_autor;
    IF verif_aut = 0 THEN
        RAISE nu_exista_aut;
    ELSIF verif_aut > 1 THEN
        RAISE mai_multi_aut;
    END IF;
    
    OPEN c_carti;
    LOOP
        FETCH c_carti INTO v_carte;
        IF c_carti%ROWCOUNT = 1 AND c_carti%NOTFOUND THEN
            CLOSE c_carti;
            RAISE nu_exista_carti;
        END IF;
        EXIT WHEN c_carti%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_carte);
    END LOOP;
    CLOSE c_carti;
--    FOR c IN c_carti LOOP
--        DBMS_OUTPUT.PUT_LINE(c.titlu);
--    END LOOP;
EXCEPTION
    WHEN nu_exista_util THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista utilizator cu codul dat');
    WHEN nu_exista_aut THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista autor cu numele dat');
    WHEN mai_multi_aut THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multi autori cu numele dat');
    WHEN nu_exista_carti THEN
        DBMS_OUTPUT.PUT_LINE('Utilizatorul dat nu a imprumutat carti ale autorului dat');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A aparut o eroare');
END carti_imprumutate;
/

BEGIN
    carti_imprumutate(5, 'Frank Herbert');
    carti_imprumutate(4, 'Frank Herbert');
    carti_imprumutate(13, 'George Orwell');
    carti_imprumutate(3, 'Liviu Rebreanu');
    carti_imprumutate(3, 'Emanuela Cerchez');
END;
/

-- 10: Definiti un trigger de tip LMD la nivel de comanda. Declansati trigger-ul.
CREATE OR REPLACE TRIGGER doar_admin_sterge
    BEFORE DELETE ON utilizatori
BEGIN
    IF NOT LOWER(USER) = 'admin' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Doar admin poate sterge linii');
    END IF;
END;
/

BEGIN
    DELETE FROM utilizatori WHERE id_utilizator = 1;
END;
/

-- 11: Definiti un trigger de tip LMD la nivel de linie. Declansati trigger-ul.
CREATE OR REPLACE TRIGGER verif_rol
    BEFORE INSERT OR UPDATE ON utilizatori
    FOR EACH ROW
BEGIN
    IF :NEW.rol NOT IN ('client', 'bibliotecar', 'admin') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Rolul poate fi doar client, bibliotecar sau admin');
    END IF;
END;
/

INSERT INTO utilizatori
VALUES (15, 'emailulmeu@yahoo.com', '0770007770', 'Haralambie', 'Alina',
'b87124fcbf84268c59b9ddcb26fdf3b67d1408990b104c8d8bf787a32d27c05b', 'rol_nou', SYSDATE);

-- 12: Definiti un trigger de tip LDD. Declansati trigger-ul.
CREATE TABLE audit_user (
    nume_bd             VARCHAR2(50),
    user_logat          VARCHAR2(30),
    eveniment           VARCHAR2(20),
    tip_obiect_referit  VARCHAR2(30),
    nume_obiect_referit VARCHAR2(30),
    data                TIMESTAMP(3)
);

CREATE OR REPLACE TRIGGER audit_schema
AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    INSERT INTO audit_user
    VALUES (
        SYS.DATABASE_NAME,
        SYS.LOGIN_USER,
        SYS.SYSEVENT,
        SYS.DICTIONARY_OBJ_TYPE,
        SYS.DICTIONARY_OBJ_NAME,
        SYSTIMESTAMP(3)
    );
END;
/

CREATE TABLE tabel_nou AS SELECT * FROM utilizatori;

-- 13: Definiti un pachet care sa contina toate obiectele definite in cadrul proiectului.
CREATE OR REPLACE PACKAGE pack_bibl IS
    PROCEDURE afis_liste_autori;
    PROCEDURE note_carti(nume_autor autori.nume%TYPE);
    FUNCTION numar_carti(nume_autor autori.nume%TYPE) RETURN NUMBER;
    PROCEDURE carti_imprumutate (
        cod_utilizator  utilizatori.id_utilizator%TYPE,
        nume_autor      autori.nume%TYPE
    );
    
    TYPE r_nota_medie_carte IS RECORD (
        titlu       carti.titlu%TYPE,
        nota_medie  NUMBER
    );
END pack_bibl;
/

CREATE OR REPLACE PACKAGE BODY pack_bibl IS
    -- 6
    PROCEDURE afis_liste_autori IS
        TYPE autori_carti IS RECORD (
            titlu_carte carti.titlu%TYPE,
            id_carte    carti.id_carte%TYPE,
            nume_autor  autori.nume%TYPE
        );
        TYPE arr_autori_carti IS TABLE OF autori_carti INDEX BY PLS_INTEGER;
        t           arr_autori_carti;
        id_curent   scrise_de.id_carte%TYPE := -1;
    BEGIN
        SELECT titlu, s.id_carte, nume
        BULK COLLECT INTO t
        FROM scrise_de s
        JOIN carti c ON (s.id_carte = c.id_carte)
        JOIN autori a ON (s.id_autor = a.id_autor)
        ORDER BY c.id_carte;
        FOR i IN t.FIRST..t.LAST LOOP
            IF NOT t(i).id_carte = id_curent THEN
                id_curent := t(i).id_carte;
                DBMS_OUTPUT.PUT_LINE(t(i).titlu_carte || ':');
            END IF;
            DBMS_OUTPUT.PUT_LINE('  ' || t(i).nume_autor);
        END LOOP;
    END afis_liste_autori;
    
    -- 7
    PROCEDURE note_carti(nume_autor autori.nume%TYPE) IS
        CURSOR c_note IS (
            SELECT titlu, AVG(valoare_nota) nota_medie
            FROM noteaza n
            JOIN carti c ON (n.id_carte = c.id_carte)
            JOIN scrise_de s ON (n.id_carte = s.id_carte)
            JOIN autori a ON (s.id_autor = a.id_autor)
            WHERE a.nume = nume_autor
            GROUP BY titlu
        );
    BEGIN
        FOR x IN c_note LOOP
            DBMS_OUTPUT.PUT_LINE(x.titlu || ': ' || ROUND(x.nota_medie, 2));
        END LOOP;
    END note_carti;
    
    -- 8
    FUNCTION numar_carti(nume_autor autori.nume%TYPE)
    RETURN NUMBER IS
        nr          NUMBER;
        verif_aut   NUMBER;
    BEGIN
        SELECT COUNT(*) INTO verif_aut
        FROM autori
        WHERE INITCAP(nume) = INITCAP(nume_autor);
        IF verif_aut = 0 THEN
            RAISE NO_DATA_FOUND;
        ELSIF verif_aut > 1 THEN
            RAISE TOO_MANY_ROWS;
        END IF;
        
        SELECT COUNT(c.id_carte) INTO nr
        FROM carti c
        JOIN scrise_de s ON (c.id_carte = s.id_carte)
        JOIN autori a ON (s.id_autor = a.id_autor)
        WHERE INITCAP(a.nume) = INITCAP(nume_autor);
        RETURN nr;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista autor cu numele dat');
            RETURN -1;
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi autori cu numele dat');
            RETURN -2;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('A aparut o eroare');
            RETURN -3;
    END numar_carti;
    
    -- 9
    PROCEDURE carti_imprumutate (
        cod_utilizator  utilizatori.id_utilizator%TYPE,
        nume_autor      autori.nume%TYPE
    ) IS
        CURSOR c_carti IS (
            SELECT titlu
            FROM carti c
            JOIN imprumuturi i ON (c.id_carte = i.id_carte)
            JOIN utilizatori u ON (i.id_utilizator = u.id_utilizator)
            JOIN scrise_de s ON (c.id_carte = s.id_carte)
            JOIN autori a ON (s.id_autor = a.id_autor)
            WHERE u.id_utilizator = cod_utilizator
            AND INITCAP(a.nume) = INITCAP(nume_autor)
        );
        v_carte         carti.titlu%TYPE;
        verif_aut       NUMBER;
        verif_util      NUMBER;
        nu_exista_util  EXCEPTION;
        nu_exista_aut   EXCEPTION;
        mai_multi_aut   EXCEPTION;
        nu_exista_carti EXCEPTION;
    BEGIN
        SELECT COUNT(*) INTO verif_util
        FROM utilizatori
        WHERE id_utilizator = cod_utilizator;
        IF verif_util = 0 THEN
            RAISE nu_exista_util;
        END IF;
        
        SELECT COUNT(*) INTO verif_aut
        FROM autori
        WHERE nume = nume_autor;
        IF verif_aut = 0 THEN
            RAISE nu_exista_aut;
        ELSIF verif_aut > 1 THEN
            RAISE mai_multi_aut;
        END IF;
        
        OPEN c_carti;
        LOOP
            FETCH c_carti INTO v_carte;
            IF c_carti%ROWCOUNT = 1 AND c_carti%NOTFOUND THEN
                CLOSE c_carti;
                RAISE nu_exista_carti;
            END IF;
            EXIT WHEN c_carti%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_carte);
        END LOOP;
        CLOSE c_carti;
    --    FOR c IN c_carti LOOP
    --        DBMS_OUTPUT.PUT_LINE(c.titlu);
    --    END LOOP;
    EXCEPTION
        WHEN nu_exista_util THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista utilizator cu codul dat');
        WHEN nu_exista_aut THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista autor cu numele dat');
        WHEN mai_multi_aut THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi autori cu numele dat');
        WHEN nu_exista_carti THEN
            DBMS_OUTPUT.PUT_LINE('Utilizatorul dat nu a imprumutat carti ale autorului dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('A aparut o eroare');
    END carti_imprumutate;
END pack_bibl;
/

BEGIN
    pack_bibl.afis_liste_autori;
END;
/

BEGIN
    note_carti('Frank Herbert');
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(numar_carti('Frank Herbert'));
    DBMS_OUTPUT.PUT_LINE(numar_carti('Anton Pann'));
    DBMS_OUTPUT.PUT_LINE(numar_carti('Emanuela Cerchez'));
END;
/

BEGIN
    carti_imprumutate(5, 'Frank Herbert');
    carti_imprumutate(4, 'Frank Herbert');
    carti_imprumutate(13, 'George Orwell');
    carti_imprumutate(3, 'Liviu Rebreanu');
    carti_imprumutate(3, 'Emanuela Cerchez');
END;
/