PROGRAM RunRecursiveSort(INPUT, OUTPUT);
VAR
  FileToSort: TEXT;

PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END;

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR 
  F2, F3: TEXT;
  Ch: CHAR;

PROCEDURE Split(VAR F1, F2, F3: TEXT);
{��������� F1 �� F2, F3}
VAR 
  Ch, Switch: CHAR;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3);
  {���������� F1 ����������� � F2 � F3}
  Switch := '2';
  WHILE NOT (EOLN(F1))
  DO
    BEGIN
      READ(F1, Ch);
      IF (Switch = '2')
      THEN
        BEGIN
          WRITE(F2, Ch);
          Switch := '3'
        END
      ELSE
        BEGIN
          WRITE(F3, Ch);
          Switch := '2'
        END
    END;
  WRITELN(F2);
  WRITELN(F3)
END; {Split}

{PROCEDURE Merge(VAR F1, F2, F3: TEXT)
 ������� F2 � F3 � F1}
PROCEDURE Merge(VAR F1, F2, F3: TEXT);
{������� F2, F3 � F1  � ������������� �������}
VAR 
  Ch2, Ch3: CHAR;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  IF (NOT EOLN(F2)) AND (NOT EOLN(F3))
  THEN
    BEGIN
      READ(F2, Ch2);
      READ(F3, Ch3);

      WHILE (NOT EOLN(F2)) AND (NOT EOLN(F3))
      DO
        BEGIN
          IF Ch2 < Ch3
          THEN 
            BEGIN
              WRITE(F1, Ch2);
              READ(F2, Ch2);
            END
          ELSE
            BEGIN
              WRITE(F1, Ch3);
              READ(F3, Ch3);
            END
        END;

      IF EOLN(F2)
      THEN
        BEGIN
          IF Ch2 < Ch3
          THEN
            WRITE(F1, Ch2)
          ELSE
            BEGIN
              WRITE(F1, Ch3);
              READ(F3, Ch3)
            END;
          IF NOT EOLN(F3)
          THEN
            {���������� ������� F3 � F1}
            WHILE NOT EOLN(F3)
            DO
              BEGIN
                WRITE(F1, Ch3);
                WRITE(F1, Ch2);
                READ(F3, Ch3);
                IF EOLN(F3)
                THEN
                  WRITE(F1, Ch3)
              END
          ELSE
            WRITE(F1, Ch3)
        END
      ELSE {EOLN(F3)}
        BEGIN
          IF Ch2 < Ch3
          THEN
            BEGIN
              WRITE(F1, Ch2);
              WRITE(F1, Ch3);
              READ(F2, Ch2)
            END
          ELSE
            WRITE(F1, Ch3);
          IF NOT EOLN(F2)
          THEN
            {���������� ������� F2 � F1}
            WHILE NOT EOLN(F2)
            DO
              BEGIN
                WRITE(F1, Ch2);
                READ(F2, Ch2);
                IF EOLN(F2)
                THEN
                  WRITE(F1, Ch2)
              END
          ELSE
            WRITE(F1, Ch2) 
        END
    END
  ELSE
    IF NOT EOLN(F2)
    THEN
      BEGIN
        READ(F2, Ch2);
        WRITE(F1, Ch2)
      END
    ELSE
      IF NOT EOLN(F3)
      THEN
        BEGIN
          READ(F3, Ch3);
          WRITE(F1, Ch3)
        END;

  WRITELN(F1)
END; {Merge}

BEGIN {RecursiveSort}
  ASSIGN(F2, '/Users/mihailkalinin/pascal/LW_14/F2.txt');
  ASSIGN(F3, '/Users/mihailkalinin/pascal/LW_14/F3.txt');

  RESET(F1);
  IF NOT (EOLN(F1))
  THEN
    BEGIN
      IF NOT (EOLN(F1))
      THEN {���� ����� ��� ������� 2 �������}
        BEGIN
          Split(F1, F2, F3);
          {RecursiveSort(F2);
          RecursiveSort(F3);}
          WRITELN(OUTPUT, 'After Split: ');
          RESET(F2);
          RESET(F3);
          CopyFile(F2, OUTPUT);
          CopyFile(F3, OUTPUT);

          WRITELN(OUTPUT, 'After Merge: ');
          Merge(F1, F2, F3);
          RESET(F1);
          CopyFile(F1, OUTPUT)
        END
    END
END;   {RecursiveSort}

BEGIN {RunRecursiveSort}
  ASSIGN(FileToSort, '/Users/mihailkalinin/pascal/LW_14/FileToSort.txt');

  REWRITE(FileToSort);
  CopyFile(INPUT, FileToSort);
  RecursiveSort(FileToSort)
END. {RunRecursiveSort}
