DELIMITER $$

CREATE PROCEDURE ProcessSubjectRequests()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_StudentId VARCHAR(20);
    DECLARE v_SubjectId VARCHAR(20);

    -- Cursor for looping through SubjectRequest table
    DECLARE subject_cursor CURSOR FOR
        SELECT StudentId, SubjectId FROM SubjectRequest;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN subject_cursor;

    subject_loop: LOOP
        FETCH subject_cursor INTO v_StudentId, v_SubjectId;
        IF done THEN
            LEAVE subject_loop;
        END IF;

        -- Check if the student exists in SubjectAllotments
        IF EXISTS (
            SELECT 1 FROM SubjectAllotments WHERE StudentId = v_StudentId
        ) THEN
            -- Get current valid subject for the student
            IF EXISTS (
                SELECT 1 FROM SubjectAllotments 
                WHERE StudentId = v_StudentId AND SubjectId = v_SubjectId AND Is_valid = 1
            ) THEN
                -- Do nothing if same subject is already valid
                ITERATE subject_loop;
            ELSE
                -- Invalidate all current entries
                UPDATE SubjectAllotments 
                SET Is_valid = 0 
                WHERE StudentId = v_StudentId AND Is_valid = 1;

                -- Insert new valid subject
                INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
                VALUES (v_StudentId, v_SubjectId, 1);
            END IF;
        ELSE
            -- Insert as a new student with valid subject
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
            VALUES (v_StudentId, v_SubjectId, 1);
        END IF;

    END LOOP;

    CLOSE subject_cursor;
END$$

DELIMITER ;
