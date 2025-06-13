DELIMITER $$

CREATE PROCEDURE AllotSubjects()
BEGIN
    -- Declare variables
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_studentId VARCHAR(20);
    DECLARE v_subjectId VARCHAR(20);
    DECLARE v_pref INT;
    DECLARE found_subject BOOLEAN;

    -- Cursor to select students by descending GPA
    DECLARE cur CURSOR FOR
        SELECT StudentId FROM StudentDetails ORDER BY GPA DESC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Clear previous allotments
    DELETE FROM Allotments;
    DELETE FROM UnallotedStudents;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_studentId;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SET v_pref = 1;
        SET found_subject = FALSE;

        pref_loop: WHILE v_pref <= 5 DO
            -- Get subject ID for current preference
            BEGIN
                DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_subjectId = NULL;

                SELECT SubjectId INTO v_subjectId
                FROM StudentPreference
                WHERE StudentId = v_studentId AND Preference = v_pref;
            END;

            -- If subjectId is null (not found), skip
            IF v_subjectId IS NULL THEN
                SET v_pref = v_pref + 1;
                ITERATE pref_loop;
            END IF;

            -- Check if subject has remaining seats
            IF EXISTS (
                SELECT 1 FROM SubjectDetails
                WHERE SubjectId = v_subjectId AND RemainingSeats > 0
            ) THEN
                -- Allot subject
                INSERT INTO Allotments (SubjectId, StudentId)
                VALUES (v_subjectId, v_studentId);

                -- Decrease remaining seats
                UPDATE SubjectDetails
                SET RemainingSeats = RemainingSeats - 1
                WHERE SubjectId = v_subjectId;

                SET found_subject = TRUE;
                LEAVE pref_loop;
            END IF;

            SET v_pref = v_pref + 1;
        END WHILE;

        -- If no subject was allotted
        IF NOT found_subject THEN
            INSERT INTO UnallotedStudents (StudentId)
            VALUES (v_studentId);
        END IF;

    END LOOP;

    CLOSE cur;
END$$

DELIMITER ;

CALL AllotSubjects();

SELECT * FROM Allotments;

SELECT * FROM UnallotedStudents;

SELECT * FROM SubjectDetails;

SELECT 
    sd.StudentId,
    sd.StudentName,
    sd.GPA,
    a.SubjectId,
    s.SubjectName
FROM StudentDetails sd
LEFT JOIN Allotments a ON sd.StudentId = a.StudentId
LEFT JOIN SubjectDetails s ON a.SubjectId = s.SubjectId;
