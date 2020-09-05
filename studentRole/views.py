from django.shortcuts import render
from utility_functions.date_functions import *
from utility_functions.db_functions import *
import json

def handle_uploaded_file(f):
    with open('static/assignments/'+f.name, 'wb+') as destination:
        for chunk in f.chunks():
            destination.write(chunk)
    print(f)

def studentIndex(request):
    if request.session.has_key('student_id'):
        student_id = request.session['student_id']
        print(student_id)
        courses = getStudentCourses(student_id)
        print(courses)
        return render(request, 'studentIndex.html', {'courses': courses})
    return checkIfLoggedIn(request)

def courseForStudents(request,course_id):
    if request.session.has_key('student_id'):
        assignments = getAssignments(course_id)
        exams = getExams(course_id)
        return render(request,'courseForStudents.html',{'assignments':assignments,'exams':exams,'cur_date_time':getCurDateTime()})
    return redirect('/')

def submitAssignment(request,assignment_id):
    if request.method == 'POST':
        student_id = request.session['student_id']
        no_of_attachments = int(request.POST.get('no_of_attachments'))
        file_paths = {}
        for i in range(1,no_of_attachments+1):
            try:
                file = request.FILES['file_'+str(i)]
                handle_uploaded_file(file)
                file_paths[i] = file.name
            except:
                break
        file_paths = json.dumps(file_paths)
        submission_date_time = getCurDateTime()
        insertIntoStudentsAssignments(assignment_id,student_id,file_paths,submission_date_time)
        return render(request,'successful.html')
    else:
        assignment = getAssignment(assignment_id)
        no_of_attachments = int(assignment[3])
        a = [str(i+1) for i in range(no_of_attachments)]
        print(a)
        return render(request,'submitAssignment.html',{'assignment':assignment,'a':a})

def testEditor(request):
    if request.method == 'POST':
        print(request.POST.get('editor1'))
        return render(request,'successful.html')
    return render(request,'richEditor.html')


def viewResults(request,exam_id):
    student_id = request.session['student_id']
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select question_id,qs.marks,qs.answer,feedback,question,q.answer,q.marks from questions_students qs inner join questions q on qs.question_id = q.id where (q.exam_id = %s and student_id = %s) and qs.marks is not NULL "
    cur.execute(query,(exam_id,student_id))
    results = cur.fetchall()
    print(results)
    if len(results) == 0:
        return redirect('/startTest/'+str(exam_id) + '/')
    total = 0
    obtainedtotal = 0
    for i in results:
        obtainedtotal += i[1]
        total += i[6]
    return render(request, 'viewResults.html',{'results':results,'total':total,'obtainedtotal':obtainedtotal})

def progressAnalysis(request):
    return render(request,'progressAnalysis.html')

def analyticsForTeacher(request):
    return render(request, 'AnalyticsForTeacher.html')

def viewAnalysis(request):
    exam_id = 2
    student_id = 1
    # con = DBConnection.getConnection()
    # cur = con.cursor()
    # query = ""
    # cur.execute(query,(exam_id,student_id))


    return render(request, 'viewAnalysis.html')


def startTest(request,exam_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select title,course.name, instructions, no_of_questions, total_marks, total_time, date_time from exam inner join course on exam.course_id = course.id where exam.id = %s; "
    cur.execute(query,(exam_id))
    examinfo = cur.fetchone()
    cur.close()
    print(examinfo)
    return render(request, 'startTest.html',{'exam':examinfo,'exam_id':exam_id,'datetime':datetime.now()})


def test(request,exam_id):
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select second(total_time), no_of_questions from exam where id = %s;"
    cur.execute(query, (exam_id))
    exam = cur.fetchone()
    query1 = "select id,question,options,marks,`type` from questions where exam_id = %s; "
    cur.execute(query1, (exam_id))
    questions = cur.fetchall()
    cur.close()
    # print(questions)
    return render(request,'Test.html',{'questions':questions,'exam':exam,'exam_id':exam_id})

def submitTest(request,exam_id):
    print(request)
    student_id = request.session['student_id']
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select id,type from questions where exam_id = %s;"
    cur.execute(query, (exam_id))
    questions = cur.fetchall()
    count = 1
    print(questions)
    for q in questions:
        answer = ""
        if q[1] == 'MCQ':
            answer = request.POST.get('mcq_ans_'+str(count))
        elif q[1] == 'True/False':
            answer = request.POST.get('true_false_ans_' + str(count))
        elif q[1] == 'Short Answer':
            answer = request.POST.get('short_ans_' + str(count))
        elif q[1] == 'One Word Answer':
            answer = request.POST.get('one_word_' + str(count))
        elif q[1] == 'Descriptive Answer':
            answer = request.POST.get('descriptive_ans_' + str(count))
        query1 = "Insert into questions_students (question_id,student_id,answer,exam_id) values(%s,%s,%s,%s);"
        cur.execute(query1, (q[0],student_id,answer,exam_id))
        con.commit()
        count+=1

    cur.close()
    return render(request,'submitTest.html')

def endTest(request):
    return render(request, 'endTest.html')