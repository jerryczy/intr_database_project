-- Q&A
-- What constraints from the domain could not be enforced?
-- The constrain that each multiple choice question have at least two choices
-- could not be enforeced since this happened in inserting and
-- until insertion is finished, there's no way for the database it self
-- to check if there's more than two choices for each mc question.
-- If have to be left for the user to enforce that.

-- What constraints that could have been enforced were not enforced? Why not?
-- The constrain that there's maximum two classes in a room could be enforced
-- but not in this schema.
-- In the schema, I enfored a foreign key constrain that each class have an
-- associated room id. In order to enforce at most two class in a room, I have
-- to create another attribute in room and reference class id which would result
-- in insert NULL for one instance then update it, which may cause trouble.
-- Again, I left this constrain for user to enforce.

DROP SCHEMA IF EXISTS quizschema CASCADE;
CREATE SCHEMA quizschema;
SET SEARCH_PATH TO quizschema;

-- A relation for basic information of each student.
CREATE TABLE student(
	-- The unique 10 digit student id.
	id VARCHAR(10) PRIMARY KEY CHECK (char_length(id) = 10),
	-- The first and last name of this student
	firstName VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL
);

-- A relation for each room.
CREATE TABLE room(
	-- unique room id
	id INT PRIMARY KEY,
	-- the teacher in this room
	teacher VARCHAR(50) NOT NULL
);

-- A relation for each class.
CREATE TABLE class(
	-- unique class id
	id INT PRIMARY KEY,
	-- associated room id
	rid INT REFERENCES room(id),
	-- grade of this class
	grade INT NOT NULL CHECK (grade >= 0)
);

-- A relation store classes a student enrolled in.
CREATE TABLE enrollment(
	-- class id
	cid INT REFERENCES class(id),
	-- student id
	sid VARCHAR(10) REFERENCES student(id),
	PRIMARY KEY(cid, sid)
);

-- A relation store all question bank
CREATE TABLE question_bank(
	-- unique question id
	id INT PRIMARY KEY,
	-- question type
	-- 	 'TF' represent True or False question;
	-- 	 'MC' represent multiple choice question;
	-- 	 'NM' represent numerical question.
	type VARCHAR(2)
		CHECK (type = 'TF' OR type = 'MC' OR type = 'NM'),
	-- question text
	question VARCHAR(1000) NOT NULL,
	-- number of hints for this question, 0 stands for no hint
	-- for numerical question use 1 if there is at one hint range
	hint_count INT CHECK (hint_count >= 0)
);

-- Correct answer for each True or False question
CREATE TABLE tf_answer(
	-- question id
	qid INT PRIMARY KEY REFERENCES question_bank(id),
	-- the correct answer of this multiple choice question
	answer BOOLEAN NOT NULL
);

-- Choices and hint for each multiple choice question
CREATE TABLE mc_c_hint(
	-- question id
	qid INT REFERENCES question_bank(id),
	-- the answer for a question that have a hint
	answer VARCHAR(1000),
	-- a flag to indicate if there's a hint associate with this answer
	hint_flag BOOLEAN NOT NULL,
	-- hint text
	hint VARCHAR(1000), -- can be NULL!
	PRIMARY KEY(qid, answer)
);

-- Correct answer for each multiple choice question
CREATE TABLE mc_answer(
	-- question id
	qid INT PRIMARY KEY REFERENCES question_bank(id),
	-- the correct answer for a question that have a hint
	answer VARCHAR(1000)
);

-- Correct Answer for numerical question
CREATE TABLE nm_answer(
	-- question id
	qid INT PRIMARY KEY REFERENCES question_bank(id),
	-- the correct answer of this multiple choice question
	answer INT NOT NULL
);

-- hint for numerical question
CREATE TABLE nm_hint(
	-- question id
	qid INT REFERENCES question_bank(id),
	-- the lower bound for this hint
	l_bound INT NOT NULL,
	-- the upper bound for this hint
	u_bound INT NOT NULL,
	-- hint text
	hint VARCHAR(1000) NOT NULL,
	PRIMARY KEY(qid, l_bound, u_bound)
);

-- A relation for each quiz
CREATE TABLE quiz(
	-- unique quiz id
	id VARCHAR(100) PRIMARY KEY,
	-- title of this quiz
	title VARCHAR(100) NOT NULL,
	-- the due date and time for this quiz
	due_time TIMESTAMP NOT NULL,
	-- the class that allowed to to this quiz
	class_id INT REFERENCES class(id),
	-- true is this quiz allow hint, false otherwise
	hint BOOLEAN NOT NULL
);

-- quizs and the questions on this quiz
CREATE TABLE quiz_question(
	-- a unique id for a question in a sepecific question
	id INT UNIQUE,
	-- the quiz refer to
	quiz_id VARCHAR(100) REFERENCES quiz(id),
	-- the question on this quiz
	qid INT REFERENCES question_bank(id),
	-- the weight of this question
	weight INT NOT NULL,
	PRIMARY KEY(quiz_id, qid)
);

-- store student's response to a quiz
CREATE TABLE quiz_response(
	-- the question of the quiz this student is answering
	id INT REFERENCES quiz_question(id),
	-- student id
	sid VARCHAR(10) REFERENCES student(id),
	-- student response to this question
	response VARCHAR(1000), -- this can be NULL!
	PRIMARY KEY(id, sid)
);
