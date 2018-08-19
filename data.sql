SET SEARCH_PATH TO quizschema;

INSERT INTO student VALUES
	('0998801234', 'Lena', 'Headey'),
	('0010784522', 'Peter', 'Dinklage'),
	('0997733991', 'Emilia', 'Clarke'),
	('5555555555', 'Kit', 'Harrington'),
	('1111111111', 'Sophie', 'Turner'),
	('2222222222', 'Maisie', 'Williams');

INSERT INTO room VALUES
	(336, 'Miss Nyers'), (120, 'Mr Higgins');

INSERT INTO class VALUES
	(510, 336, 5), (801, 120, 8);

INSERT INTO enrollment VALUES
	(801, '0998801234'),
	(801, '0010784522'),
	(801, '0997733991'),
	(801, '5555555555'),
	(801, '1111111111'),
	(510, '2222222222');

INSERT INTO question_bank VALUES
	(782, 'MC', 'What do you promise when you take the oath of citizenship?', 
		1),
	(566, 'TF', 
		'The Prime Minister, Justin Trudeau, is	Canada''s Head of State.', 0),
	(601, 'NM', 
		'During the "Quiet Revolution," Quebec experienced rapid change. In what decade did this occur? (Enter the year that began the decade, e.g., 1840.)', 
		1),
	(625, 'MC', 'What is the Underground Railroad?', 3),
	(790, 'MC', 
		'During the War of 1812 the Americans burned down the Parliament Buildings in York (now Toronto). What did the British and Canadians do in return?', 
		0);

INSERT INTO tf_answer VALUES (566, 'False');

INSERT INTO mc_c_hint VALUES
	(782, 'To pledge your loyalty to the Sovereign, Queen Elizabeth II', 
		'False', NULL),
	(782, 
		'To pledge your allegiance to the flag and fulfill the duties of a Canadian', 
		'True', 'Think regally'),
	(782, 'To pledge your loyalty to Canada from sea to sea', 'False', NULL),
	(625, 'The first railway to cross Canada', 'True', 
		'The Underground Railroad was generally south to north,	not east-west.'),
	(625, 'The CPR''s secret railway line', 'True', 
		'The Underground Railroad was secret, but it had nothing to do with trains.'),
	(625, 'The TTC subway system', 'True', 
		'The TTC is relatively recent; the Underground Railroad was in operation over 100 years ago.'),
	(625, 'A network used by slaves who escaped the United States into Canada', 
		'False', NULL),
	(790, 'They attacked American merchant ships', 'False', NULL),
	(790, 'They expanded their defence system, including Fort York', 
		'False', NULL),
	(790, 'They burned down the White House in Washington D.C.', 
		'False', NULL),
	(790, 'They captured Niagara Falls', 'False', NULL);

INSERT INTO mc_answer VALUES
	(782, 'To pledge your loyalty to the Sovereign, Queen Elizabeth II'),
	(625, 
		'A network used by slaves who escaped the United States into Canada'),
	(790, 'They burned down the White House in Washington D.C.');

INSERT INTO nm_answer VALUES (601, 1960);

INSERT INTO nm_hint VALUES
	(601, 1800, 1900, 
		'The Quiet Revolution happened during the 20th Century.'),
	(601, 2000, 2010, 'The Quiet Revolution happened some time ago.'),
	(601, 2020, 3000, 'The Quiet Revolution has already happened!');

INSERT INTO quiz VALUES
	('Pr1-220310', 'Citizenship Test Practise Questions', 
		'2017-10-01 13:30:00',  801, 'True');

INSERT INTO quiz_question VALUES
	(1, 'Pr1-220310', 601, 2),
	(2, 'Pr1-220310', 566, 1),
	(3, 'Pr1-220310', 790, 3),
	(4, 'Pr1-220310', 625, 2);

INSERT INTO quiz_response VALUES
	(1, '0998801234', 1950),
	(2, '0998801234', 'False'),
	(3, '0998801234', 'They expanded their defence system, including Fort York'),
	(4, '0998801234', 
		'A network used by slaves who escaped the United States into Canada'),
	(1, '0010784522', 1960),
	(2, '0010784522', 'False'),
	(3, '0010784522', 'They burned down the White House in Washington D.C.'),
	(4, '0010784522', 
		'A network used by slaves who escaped the United States into Canada'),
	(1, '0997733991', 1960),
	(2, '0997733991', 'True'),
	(3, '0997733991', 'They burned down the White House in Washington D.C.'),
	(4, '0997733991', 'The CPR''s secret railway line'),
	(1, '5555555555', NULL),
	(2, '5555555555', 'False'),
	(3, '5555555555', 'They captured Niagara Falls'),
	(4, '5555555555', NULL),
	(1, '1111111111', NULL),
	(2, '1111111111', NULL),
	(3, '1111111111', NULL),
	(4, '1111111111', NULL);