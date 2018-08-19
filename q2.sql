SET SEARCH_PATH TO quizschema;

SELECT id as QuestionID, substring(question FROM 1 FOR 50) as QuestionText,
	CASE
		WHEN type = 'TF' THEN NULL
		ELSE hint_count
	END as hint_count
FROM question_bank;