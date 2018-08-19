SET SEARCH_PATH TO quizschema;

DROP VIEW IF EXISTS students CASCADE;
DROP VIEW IF EXISTS questions CASCADE;
DROP VIEW IF EXISTS null_response CASCADE;

-- find all students in grade 8 in room 120 with Mr Higgins.
CREATE VIEW students AS
	SELECT e.sid AS sid
	FROM enrollment e, class c, room r
	WHERE e.cid = c.id AND r.id = 120 AND c.rid = r.id AND 
		r.teacher = 'Mr Higgins';

-- find all questions in this quiz and their ASsociated quiz id and 
-- quiz_question id.
CREATE VIEW questions AS
	SELECT qq.qid AS qid, qq.id AS quiz_qid, type
	FROM quiz_question qq, question_bank qb
	WHERE qq.quiz_id = 'Pr1-220310' AND qq.qid = qb.id;

-- find true or false questions' correct answer.
CREATE VIEW correct_tf_answer AS
	SELECT q.quiz_qid AS quiz_qid, tf.answer AS answer
		FROM questions q, tf_answer tf
		WHERE q.qid = tf.qid;

-- find multiple choice questions' correct answer.
CREATE VIEW correct_mc_answer AS
	SELECT q.quiz_qid AS quiz_qid, mc.answer AS answer
		FROM questions q, mc_answer mc
		WHERE q.qid = mc.qid;

-- find numerical questions' correct answer.
CREATE VIEW correct_nm_answer AS
	SELECT q.quiz_qid AS quiz_qid, nm.answer AS answer
		FROM questions q, nm_answer nm
		WHERE q.qid = nm.qid;

-- find all student's response for quiz 'Pr1-220310'.
CREATE VIEW responses AS
	SELECT q.quiz_qid AS quiz_qid, qr.sid AS sid, qr.response AS response, type
	FROM questions q, quiz_response qr, students
	WHERE q.quiz_qid = qr.id AND qr.sid = students.sid;

-- find if a student did a question right(1) or not(0)
-- Note both wrong answer and no response are count as 0
CREATE VIEW correctness AS
	(SELECT sid, r.quiz_qid as quiz_qid,
		CASE
			WHEN answer = CAST(response AS BOOLEAN) THEN 1
			ELSE 0
		END AS correct
	FROM correct_tf_answer NATURAL JOIN responses r
	WHERE type = 'TF')
	UNION ALL
	(SELECT sid, r.quiz_qid as quiz_qid,
		CASE
			WHEN answer = response THEN 1
			ELSE 0
		END AS correct
	FROM correct_mc_answer NATURAL JOIN responses r
	WHERE type = 'MC')
	UNION ALL
	(SELECT sid, r.quiz_qid as quiz_qid,
		CASE
			WHEN answer = CAST(response AS INT) THEN 1
			ELSE 0
		END AS correct
	FROM correct_nm_answer NATURAL JOIN responses r
	WHERE type = 'NM');

-- find number of students answer a question correct
CREATE VIEW correct_response AS
	SELECT quiz_qid, sum(correct) as correct_count
	FROM correctness
	GROUP BY quiz_qid;

-- find number of students does not response to a question
CREATE VIEW null_response AS
	SELECT id AS quiz_qid, count(sid) as null_count
	FROM quiz_response
	WHERE response IS NULL
	GROUP BY quiz_qid;

-- report number of correct answer, wrong answer and null anwswer
-- for each question.
SELECT qq.qid as questionId, correct_count, 
	((SELECT count(*) FROM students) - correct_count - null_count)
	as wrong_count, null_count
FROM correct_response cr, null_response nr, quiz_question qq
WHERE cr.quiz_qid = qq.id AND nr.quiz_qid = qq.id;