import json

from django.shortcuts import render, redirect
from utility_functions.date_functions import *
from utility_functions.db_functions import *

def aboutus(request):
    return render(request,'aboutus.html')

def contactUs(request):
    return render(request,'contactus.html')

def demo(request):
    return render(request,'demo.html')

def login(request):
    if request.session.has_key('user_id'):
        return checkIfLoggedIn(request)
    else:
        if request.method == "POST":
            username = request.POST.get("username")
            password = request.POST.get("password")
            con = DBConnection.getConnection()
            cur = con.cursor()
            query = "SELECT id,type FROM users WHERE username = %s AND password = %s;"
            cur.execute(query,(username,password))
            data = cur.fetchall()
            if len(data) == 1:
                request.session['user_id'] = data[0][0]

                if data[0][1] == 'admin':
                    return render(request,'adminIndex.html')
                elif data[0][1] == 'teacher':
                    query = "SELECT id FROM teachers WHERE user_id = %s;"
                    cur.execute(query, (data[0][0]))
                    data = cur.fetchall()
                    teacher_id = data[0][0]
                    request.session['teacher_id'] = teacher_id
                    courses = getTeacherCourses(teacher_id)
                    return render(request,'headerTeacher.html',{'courses':courses})
                elif data[0][1] == 'student':
                    query = "SELECT id FROM students WHERE user_id = %s;"
                    cur.execute(query, (data[0][0]))
                    data = cur.fetchall()
                    student_id = data[0][0]
                    request.session['student_id'] = student_id
                    courses = getStudentCourses(student_id)
                    return render(request,'studentIndex.html',{'courses':courses})
            return render(request,'e403.html')

    return render(request,'login.html')

def logout(request):
    if request.session.has_key('user_id'):
        del request.session['user_id']
        if request.session.has_key('teacher_id'):
            del request.session['teacher_id']
        elif request.session.has_key('student_id'):
            del request.session['student_id']
    return render(request,'login.html')





def progressAnalysis(request):
    student_id = request.session['student_id']
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select date_time ,total_marks ,sum(marks) from exam e inner join questions_students qs on qs.exam_id = e.id where qs.student_id = %s group by qs.exam_id"
    cur.execute(query, (student_id))
    resultset = cur.fetchall()
    date_time = []
    score = []
    # for r in resultset:
    #     date_time.append(r[0].strftime("%Y-%m-%d %H:%M:%S"))
    #     score.append(r[2]*100/r[1])
    date_time = ["2015-03-15 13:34:23", "2015-03-25 13:24:20", "2015-04-25 14:12:00"]
    score = [30,50,40]
    date_time = json.dumps(date_time)
    score = json.dumps(score)
    print(date_time)
    print(score)
    return render(request,'progressAnalysis.html',{'date_time':date_time, 'score':score})

def analyticsForTeacher(request):
    return render(request, 'AnalyticsForTeacher.html')

def viewAnalysis(request,exam_id):
    student_id = request.session['student_id']
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select sum(knowledge_marks),sum(grammar_marks),knowledge_ratio,grammar_ratio,total_marks from questions_students qs inner join exam on exam.id = qs.exam_id where exam_id = %s and student_id = %s"
    cur.execute(query,(5,student_id))
    KG_marks = cur.fetchone()
    print(KG_marks)
    km = KG_marks[0]/(KG_marks[2]*KG_marks[4])
    gm = KG_marks[1]/(KG_marks[3]*KG_marks[4])
    temp = []
    temp.append(km)
    temp.append(gm)
    KG_marks = json.dumps(list(temp))
    query1 = "select qs.marks,q.marks,course_outcome from questions q inner join questions_students qs on q.id = qs.question_id where qs.exam_id = %s and student_id = %s and qs.marks is not NULL"
    cur.execute(query1, (exam_id, student_id))
    course_out_ratio = cur.fetchall()
    print(course_out_ratio)
    co = []
    mks = []
    for i in course_out_ratio:
        co.append(i[2])
        mks.append((i[0]/i[1])*100)
    c_out = json.dumps(co)
    mks_out = json.dumps(mks)
    return render(request, 'viewAnalysis.html',{'KG_marks':KG_marks,'c_out':c_out,'mks_out':mks_out})




def index(request):
    return render(request,'headerGeneral.html')