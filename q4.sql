SET SEARCH_PATH TO quizschema;

DROP VIEW IF EXISTS students CASCADE;
DROP VIEW IF EXISTS questions CASCADE;

-- find all students in grade 8 in room 120 with Mr Higgins.
CREATE VIEW students AS
	SELECT e.sid AS sid
	FROM enrollment e, class c, room r
	WHERE e.cid = c.id AND r.id = 120 AND c.rid = r.id AND 
		r.teacher = 'Mr Higgins';

-- find all questions in this quiz and their associated question text and 
-- question id and quiz_question id.
CREATE VIEW questions AS
	SELECT qq.id AS quiz_qid, qb.id AS qid, qb.question AS question
	FROM quiz_question qq, question_bank qb
	WHERE qq.quiz_id = 'Pr1-220310' AND qq.qid = qb.id;

-- find quiz_question id and student number for student did answer a question
CREATE VIEW null_response AS
	SELECT id AS quiz_qid, sid
	FROM quiz_response
	WHERE response IS NULL;

-- For each student who did answer some question
-- project their student number, question id and question text.
SELECT sid, qid, substring(question FROM 0 FOR 50) as questionText
FROM questions NATURAL JOIN null_response;