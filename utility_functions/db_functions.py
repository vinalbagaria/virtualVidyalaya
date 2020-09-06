import pymysql
from django.shortcuts import render, redirect


class DBConnection():
    __connection = None

    def __init__(self):
        self.getConnection()

    @staticmethod
    def getConnection():
        if DBConnection.__connection == None:
            DBConnection.__connection = pymysql.connect(host='db4free.net',
                                         user='mohit2000spit',
                                         password='pariksha',
                                         db='pariksha')
            print('DBConnection Established')
            return DBConnection.__connection
        return DBConnection.__connection

def getTeacherCourses(teacher_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "SELECT name,CONCAT(first_name,' ',last_name),date_added,description,course_id from course inner join course_teachers on course.id = course_teachers.course_id and course_teachers.teacher_id = %s inner join teachers on teachers.id = course.incharge_id;"
    cur.execute(query,(teacher_id))
    courses = cur.fetchall()
    return courses

def getStudentCourses(student_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "SELECT name,CONCAT(first_name,' ',last_name),description,course_id from course inner join course_students on course.id = course_students.course_id and course_students.student_id = %s inner join students on students.id = %s;"
    cur.execute(query,(student_id,student_id))
    courses = cur.fetchall()
    return courses

def getCourse(course_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "SELECT name,CONCAT(first_name,' ',last_name),date_added,description,course.id FROM course inner join teachers on course.id = %s and course.incharge_id = teachers.id;"
    cur.execute(query, (course_id))
    course = cur.fetchone()
    return course

def getTeacherAssignments(course_id,teacher_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "SELECT assignment.id,assignment.title,course.name,assignment.end_date_time FROM assignment inner join course_teachers on assignment.course_id = course_teachers.course_id inner join course on course.id = assignment.course_id WHERE course_teachers.course_id = %s and course_teachers.teacher_id = %s ORDER BY end_date_time;"
    cur.execute(query, (course_id,teacher_id))
    assignments = cur.fetchall()
    return assignments

def getTeacherExams(course_id,teacher_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "SELECT exam.id,exam.title,course.name,exam.date_time FROM exam inner join course_teachers on exam.course_id = course_teachers.course_id inner join course on course.id = exam.course_id WHERE course_teachers.course_id = %s and course_teachers.teacher_id = %s ORDER BY date_time;"
    cur.execute(query, (course_id,teacher_id))
    exams = cur.fetchall()
    return exams


def getAssignment(assignment_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "SELECT id,title,max_size_mb,no_of_attachments,start_date_time,end_date_time,marks FROM assignment WHERE id = %s;"
    cur.execute(query, (assignment_id))
    assignment = cur.fetchone()
    return assignment

def getSubmissions(assignment_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select a.id,CONCAT(s.first_name,' ',s.last_name),a.submission_date_time from students s inner join assignment_students a on s.id = a.student_id where a.assignment_id = %s;"
    cur.execute(query, (assignment_id))
    submissions = cur.fetchall()
    return submissions

def getSubmission(submission_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select a.id,CONCAT(s.first_name,' ',s.last_name),a.file_paths,a.submission_date_time,a1.end_date_time,CONCAT(FLOOR(HOUR(TIMEDIFF(a1.end_date_time,a.submission_date_time)) / 24), ' DAYS ', MOD(HOUR(TIMEDIFF(a1.end_date_time,a.submission_date_time)), 24), ' HOURS ',MINUTE(TIMEDIFF(a1.end_date_time,a.submission_date_time)), ' MINUTES '),a1.title,a1.marks from assignment_students a inner join students s on a.student_id = s.id inner join assignment a1 on a.assignment_id = a1.id where a.id = %s;"
    cur.execute(query, (submission_id))
    submissions = cur.fetchone()
    return submissions



def insertIntoExams(incharge_id,course_id,total_marks,no_of_questions,total_time,title,instructions,date_time,grammar_ratio,knowledge_ratio):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "INSERT INTO exam(incharge_id,course_id,total_marks,no_of_questions,total_time,title,instructions,date_time,grammar_ratio,knowledge_ratio) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"
    cur.execute(query, (incharge_id,course_id,total_marks,no_of_questions,total_time,title,instructions,date_time,grammar_ratio,knowledge_ratio))
    con.commit()
    return cur.lastrowid

def insertIntoQuestions(exam_id,question,marks,answer,options,type,course_outcome):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "INSERT INTO questions(exam_id,question,marks,answer,options,type,course_outcome) VALUES(%s,%s,%s,%s,%s,%s,%s);"
    cur.execute(query, (exam_id,question,marks,answer,options,type,course_outcome))
    con.commit()

def insertIntoStudentsAssignments(assignment_id,student_id,file_paths,submission_date_time):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "INSERT INTO assignment_students(assignment_id,student_id,file_paths,submission_date_time) VALUES(%s,%s,%s,%s);"
    cur.execute(query, (assignment_id,student_id,file_paths,submission_date_time))
    con.commit()


def getExams(course_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select title,date_time,id from exam where course_id = %s order by date_time;"
    cur.execute(query, (course_id))
    exams = cur.fetchall()
    return exams

def getAssignments(course_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select title,end_date_time,id from assignment where course_id = %s order by end_date_time;"
    cur.execute(query, (course_id))
    assignments = cur.fetchall()
    return assignments


def displayStudents(exam_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select DISTINCT q.student_id,CONCAT(s.first_name,' ',s.last_name),q.exam_id from questions_students q inner join students s on s.id = q.student_id where q.exam_id = %s;"
    #query = "select * from students;"
    cur.execute(query, (exam_id))
    #cur.execute(query)
    students = cur.fetchall()
    return students

def getResponses(exam_id,student_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select q.id,q.question,q.answer,qs.answer,q.type,q.marks, qs.id,qs.marks,qs.feedback from questions q inner join questions_students qs on q.id = qs.question_id where qs.student_id = %s and qs.exam_id = %s;"
    cur.execute(query, (student_id,exam_id))
    responses = cur.fetchall()
    return responses



def getStudents(class_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select id from students where class_id = %s;"
    cur.execute(query, (class_id))
    students = cur.fetchall()
    return students




def loadChats(course_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select username, message,date_time,course_id from forum inner join users on users.id = forum.user_id where course_id = %s;"
    cur.execute(query, (course_id))
    chats = cur.fetchall()
    return chats



def checkIfLoggedIn(request):
    if request.session.has_key('user_id'):
        if request.session.has_key('teacher_id'):
            return redirect('/teacherIndex/')
        elif request.session.has_key('student_id'):
            return redirect('/studentIndex/')
        return redirect('/adminIndex/')