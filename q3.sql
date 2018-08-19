SET SEARCH_PATH TO quizschema;

DROP VIEW IF EXISTS students CASCADE;
DROP VIEW IF EXISTS questions CASCADE;

-- find all students in grade 8 in room 120 with Mr Higgins.
CREATE VIEW students AS
	SELECT e.sid AS sid
	FROM enrollment e, class c, room r
	WHERE e.cid = c.id AND r.id = 120 AND c.rid = r.id AND 
		r.teacher = 'Mr Higgins';

-- find all questions in this quiz and their ASsociated quiz id and 
-- quiz_question id.
CREATE VIEW questions AS
	SELECT qq.qid AS qid, qq.id AS quiz_qid, qq.weight AS weight, type
	FROM quiz_question qq, question_bank qb
	WHERE qq.quiz_id = 'Pr1-220310' AND qq.qid = qb.id;

-- find true or false questions' correct answer.
CREATE VIEW correct_tf_answer AS
	SELECT q.quiz_qid AS quiz_qid, tf.answer AS answer, q.weight AS weight
		FROM questions q, tf_answer tf
		WHERE q.qid = tf.qid;

-- find multiple choice questions' correct answer.
CREATE VIEW correct_mc_answer AS
	SELECT q.quiz_qid AS quiz_qid, mc.answer AS answer, q.weight AS weight
		FROM questions q, mc_answer mc
		WHERE q.qid = mc.qid;

-- find numerical questions' correct answer.
CREATE VIEW correct_nm_answer AS
	SELECT q.quiz_qid AS quiz_qid, nm.answer AS answer, q.weight AS weight
		FROM questions q, nm_answer nm
		WHERE q.qid = nm.qid;

-- find all student's response for quiz 'Pr1-220310'.
CREATE VIEW responses AS
	SELECT q.quiz_qid AS quiz_qid, qr.sid AS sid, qr.response AS response, type
	FROM questions q, quiz_response qr, students
	WHERE q.quiz_qid = qr.id AND qr.sid = students.sid;

-- find students mark for each question.
CREATE VIEW mark AS
	(SELECT sid, r.quiz_qid,
		CASE
			WHEN answer = CAST(response AS BOOLEAN) THEN weight
			ELSE 0
		END AS mark
	FROM correct_tf_answer NATURAL JOIN responses r
	WHERE type = 'TF')
	UNION ALL
	(SELECT sid, r.quiz_qid,
		CASE
			WHEN answer = response THEN weight
			ELSE 0
		END AS mark
	FROM correct_mc_answer NATURAL JOIN responses r
	WHERE type = 'MC')
	UNION ALL
	(SELECT sid, r.quiz_qid,
		CASE
			WHEN answer = CAST(response AS INT) THEN weight
			ELSE 0
		END AS mark
	FROM correct_nm_answer NATURAL JOIN responses r
	WHERE type = 'NM');

-- calculate total mark for each student as well as conbine student's info.
CREATE VIEW total_mark AS
	SELECT sid, sum(mark) AS mark
	FROM mark
	GROUP BY sid;

-- project each student's student number, last name and total mark.
SELECT sid AS studentNumber, lAStName, mark
FROM total_mark, student
WHERE sid = id;