SET SEARCH_PATH TO quizschema;

SELECT firstName || ' ' ||lastName as fullName, id as StudentNumber 
FROM student;