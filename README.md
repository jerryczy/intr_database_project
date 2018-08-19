# intr_database_project
The archive file of my CSC343 A3, Fall 2017

runner.txt has all the command needed and demo.txt contains the full outputs.
Questions are stored in quiz_data.txt.

## Instruction recieved
Your first task is to construct a relational schema for our domain, expressed in DDL. Write your schema in a file called schema.ddl  
As you know, there are many possible schemas that satisfy these properties. We aren't following a formal design process, so instead follow as many of these general principles as you can when choosing among options:  
* If a constraint given above in the domain description can be expressed without assertions or triggers, it should be enforced by your relational schema.
* Avoid redundancy.
* Avoid designing your schema in such a way that there are attributes that can be null.
* Wherever an attribute cannot be null (according to the domain description), add a NOT NULL constraint.
You may find there is tension between some of these principles. Where that occurs, use your judgment to make a trade of.  
### Domain
Suppose we want to build a system for running quizzes online. There will be a large bank of questions on various
topics. A course instructor will pick questions from these to create a quiz. The answers of students in the class will
be recorded so that grades can be assigned according to a marking scheme.
The following features must be supported:
* Each student has a unique student ID, which is a 10-digit number, and a first and last name, and is in zero
or more classes.
* A class has a room (e.g., "room 366"), grade (e.g., "grade 5"), teacher (e.g., "Miss Nyers"), and one or more
students who are in that class.
* There can be multiple classes for the same grade.
* A room can have two classes in it (for example, if we have a grade 2-3 split class), but never more than one
teacher.
* Our question bank includes three types of question: true-false, multiple choice, and numeric. Numeric questions can only have integer answers. (We won't handle floats.) Questions are identified by their unique question ID.
* All questions have question text (e.g., "What is the capital city of Saskatchewan?") and a single correct
answer.
* A multiple choice question has answer options (e.g., "Saskatoon"), and there are always at least two. The
correct answer must be one of the options.
* An incorrect answer to a multiple-choice or numeric question may have one hint associated with it. Correct
answers do not have hints.
* For numeric questions, each hint is specific to a given range of values into which an incorrect answer may fall.
The range will be specified by its lower (inclusive) bound and its upper (non-inclusive) bound. For instance,
if the range for a hint is from 3 to 7, it is a hint associated with an answer x such that 3 < x < 7.
* A quiz has a unique ID, a title, a due date and time, one or more questions from the question bank, and a
class to which it is assigned.
* The instructor can choose whether or not students should be shown a hint (if there is one in the test bank)
when they give a wrong answer to a question. This is a single 
ag for the whole quiz rather than one per
question.
* Each question on a quiz has a weight: an integer that indicates how much a correct answer contributes to the
student's total score on the quiz. The same question could occur in multiple different quizzes with different
weights.
* The database records student responses to the quiz.
* Only a student in the class that was assigned a quiz can answer questions on that quiz.
* A student may not have answered all the questions. It's even possible that they answered none.
### Instance and queries
Once you have defined your schema, create a file called data.sql that inserts data into your database that represents
the small dataset defined informally in file Quiz-data.txt. You may find it instructive to consider this data as you
are working on the design.
Then write queries to do the following:
1. Report the full name and student number of all students in the database.
2. For all questions in the database, report the question ID, question text, and the number of hints associated
with it. For True-False questions, report NULL as the number of hints (since True-False questions cannot have
hints).
3. Compute the grade and total score on quiz Pr1-220310 for every student in the grade 8 class in room 120 with
Mr Higgins. Report the student number, last name, and total grade.
4. For every student in the grade 8 class in room 120 with Mr Higgins, and every question from quiz Pr1-220310
that they did not answer, report the student ID, the question ID, and the question text.
5. For each question on quiz Pr1-220310, report the number of students in the grade 8 class in room 120 with
Mr Higgins who got the question right, the number who got it wrong, and the number who did not answer it.
Write your queries in files called q1.sql through q5.sql.  
Once all your queries are working, start postgreSQL, import runner.txt, and
cut and paste your entire interaction with the postgreSQL shell into a plain text file called demo.txt.
