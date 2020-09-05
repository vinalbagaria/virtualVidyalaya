from django.shortcuts import render, redirect
from utility_functions.date_functions import *
from utility_functions.db_functions import *
from utility_functions.automaticEvaluation import *
import json
from django import template

def teacherIndex(request):
    if request.session.has_key('teacher_id'):
        teacher_id = request.session['teacher_id']
        courses = getTeacherCourses(teacher_id)
        return render(request, 'teacherIndex.html', {'courses': courses})
    return checkIfLoggedIn(request)

def createCourse(request):
    if request.session.has_key('teacher_id'):
        if request.method == "POST":
            # try:
                incharge_id = request.session['teacher_id']
                name = request.POST.get('name')
                description = request.POST.get('description')
                con = DBConnection.getConnection()
                cur = con.cursor()
                today = getToday()
                query = "INSERT INTO course(name,description,incharge_id,date_added) VALUES(%s,%s,%s,%s);"
                cur.execute(query, (name,description,incharge_id,today))
                con.commit()
                course_id = cur.lastrowid
                query = "INSERT INTO course_teachers(course_id,teacher_id) VALUES (%s,%s)"
                cur.execute(query,(course_id,incharge_id))
                con.commit()
                return render(request,'successful.html')
            # except:
            #     return render(request, 'unsuccessful.html')
        else:
            return render(request, 'createCourse.html')
    return render(request, 'aboutus.html')

def createClass(request):
    if request.session.has_key('teacher_id'):
        if request.method == "POST":
            try:
                incharge_id = request.session['teacher_id']
                name = request.POST.get('name')
                con = DBConnection.getConnection()
                cur = con.cursor()
                query = "INSERT INTO class(name,incharge_id) VALUES(%s,%s);"
                cur.execute(query, (name,incharge_id))
                con.commit()
                return render(request,'successful.html')
            except:
                return render(request, 'unsuccessful.html')
        else:
            return render(request, 'createClass.html')
    return render(request, 'aboutus.html')

def createAssignment(request,course_id):
    if request.session.has_key('teacher_id'):
        if request.method == "POST":
            # try:
                title = request.POST.get('title')
                max_size_mb = request.POST.get('max_size_mb')
                no_of_attachments = request.POST.get('no_of_attachments')
                start_date_time = request.POST.get('start_date_time')
                end_date_time = request.POST.get('end_date_time')
                marks = request.POST.get('marks')
                con = DBConnection.getConnection()
                cur = con.cursor()
                query = "INSERT INTO assignment(title,max_size_mb,no_of_attachments,start_date_time,end_date_time,marks,course_id) VALUES(%s,%s,%s,%s,%s,%s,%s);"
                cur.execute(query, (title,max_size_mb,no_of_attachments,start_date_time,end_date_time,marks,course_id))
                con.commit()
                return render(request,'successful.html')
            # except:
            #     return render(request, 'unsuccessful.html')
        else:
            return render(request, 'createAssignment.html',{'course_id':course_id})
    return redirect('/')

def viewAssignments(request,course_id):
    if request.session.has_key('teacher_id'):
        assignments = getTeacherAssignments(course_id,request.session['teacher_id'])
        print(assignments)
        return render(request,'viewAssignments.html',{'assignments':assignments})
    return redirect('/')

def viewExams(request,course_id):
    if request.session.has_key('teacher_id'):
        exams = getTeacherExams(course_id,request.session['teacher_id'])
        print(exams)
        return render(request,'viewExams.html',{'exams':exams})
    return redirect('/')

def gradeExams(request,exam_id):
    ###check mock or not
    if request.method == 'POST':
        mock = request.POST.get('mock')
        print('hello')
        students = displayStudents(exam_id)
        print('hi')
        return render(request,'gradeManual.html',{'exam_id':exam_id,'students':students,'mock':mock})
    return render(request,'gradeExams.html',{'exam_id':exam_id})

def gradeManual(request,exam_student_id):
    ids = exam_student_id.split('-')
    exam_id = ids[0]
    student_id = ids[1]
    if request.method == 'POST':
        con = DBConnection.getConnection()
        cur = con.cursor()
        query = "select id,question_id from questions_students where exam_id = %s and student_id = %s;"
        cur.execute(query, (exam_id,student_id))
        data = cur.fetchall()
        print(data)
        for i in range(len(data)):
            id = str(data[i][0])
            print(id)
            marks = request.POST.get('marks_'+id)
            feedback = request.POST.get('feedback_'+id)
            print(marks,feedback)
            query = "update questions_students set marks=%s, feedback = %s where id = %s;"
            cur.execute(query, (float(marks), feedback,int(id)))
            con.commit()
    responses = getResponses(exam_id,student_id)
    print(responses)
    return render(request,'showResponses.html',{'questions':responses,'exam_id':exam_id,'student_id':student_id,'no_of_questions':len(responses)})


def editAssignment(request,assignment_id):
    if request.session.has_key('teacher_id'):
        if request.method == 'POST':
            try:
                title = request.POST.get('title')
                max_size_mb = request.POST.get('max_size_mb')
                no_of_attachments = request.POST.get('no_of_attachments')
                start_date_time = request.POST.get('start_date_time')
                end_date_time = request.POST.get('end_date_time')
                marks = request.POST.get('marks')
                con = DBConnection.getConnection()
                cur = con.cursor()
                query = "UPDATE assignment SET title=%s,max_size_mb=%s,no_of_attachments=%s,start_date_time=%s,end_date_time=%s,marks=%s;"
                cur.execute(query,(title, max_size_mb, no_of_attachments, start_date_time, end_date_time, marks))
                con.commit()
                return render(request, 'successful.html')
            except:
                return render(request, 'unsuccessful.html')
        assignment = getAssignment(assignment_id)
        submissions = getSubmissions(assignment_id)
        return render(request,'editAssignment.html',{'assignment':assignment,'submissions':submissions})
    return redirect('/')

def gradeSubmission(request,submission_id):
    if request.method == 'POST':
        marks = request.POST.get('marks')
        feedback = request.POST.get('feedback')
        con = DBConnection.getConnection()
        cur = con.cursor()
        query = "UPDATE assignment_students SET marks = %s, feedback = %s, checked_by=%s WHERE id = %s;"
        cur.execute(query, (marks, feedback, request.session['teacher_id'],submission_id))
        con.commit()
    submission = getSubmission(submission_id)
    print(submission)
    file_paths = json.loads(submission[2])
    files = []
    for key,val in file_paths.items():
        files.append(['/static/assignments/'+ val,val])
    print(files)
    return render(request,'gradeSubmission.html',{'submission':submission,'files':files})

def courseForTeachers(request,course_id):
    if request.session.has_key('teacher_id'):
        course = getCourse(course_id)
        print(course)
        return render(request,'courseForTeachers.html',{'course':course})
    return redirect('/')

def editCourse(request,course_id):
    name = request.POST.get('name')
    description = request.POST.get('description')
    print(name,description)
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "UPDATE course SET name = %s, description = %s WHERE id = %s;"
    cur.execute(query, (name,description,course_id))
    con.commit()
    link = '/courseForTeachers/'+course_id
    return redirect(link)

def createExam(request,course_id):
    if request.method == 'POST':
        no_of_questions = request.POST.get('no_of_questions')
        total_marks = request.POST.get('total_marks')
        title = request.POST.get('title')
        instructions = request.POST.get('instructions')
        total_time = request.POST.get('total_time')
        incharge_id = request.session['teacher_id']
        date_time = request.POST.get('date_time')
        grammar_ratio = request.POST.get('grammar_ratio')
        knowledge_ratio = request.POST.get('knowledge_ratio')
        exam_id = insertIntoExams(incharge_id,course_id,total_marks,no_of_questions,total_time,title,instructions,date_time,grammar_ratio,knowledge_ratio)

        for i in range(1,int(no_of_questions)+1):
            i = str(i)
            options = {}
            answer = ''
            type = request.POST.get('type_' + i)
            if type == 'True/False':
                answer = request.POST.get('true_false_ans_' + i)
                options = {1:"True",2:"False"}
            elif type == 'MCQ':
                answer = request.POST.get('mcq_ans_' + i)
                options = {1:request.POST.get('option1_'+i),2:request.POST.get('option2_'+i),3:request.POST.get('option3_'+i),4:request.POST.get('option4_'+i)}
            elif type == 'One Word Answer':
                answer = request.POST.get('one_word_'+i)
            elif type == 'Short Answer':
                answer = request.POST.get('short_ans_'+i)
            elif type == 'Descriptive Answer':
                answer = request.POST.get('descriptive_ans_' + i)
            question = request.POST.get('question_' + i)
            marks = request.POST.get('marks_' + i)
            options = json.dumps(options)
            insertIntoQuestions(exam_id,question,marks,answer,options,type)
        return render(request, 'successful.html')
    return render(request,'createExam.html',{'course_id':course_id})


def gradeAutomatic(request,exam_student_id):
    ids = exam_student_id.split('-')
    exam_id = ids[0]
    student_id = ids[1]
    con = DBConnection.getConnection()
    cur = con.cursor()
    query = "select questions_students.id,questions.answer,questions_students.answer,questions.marks,questions.type,knowledge_ratio,grammar_ratio from questions_students inner join questions on questions.id = questions_students.question_id inner join exam on exam.id = questions.exam_id where questions.exam_id = %s and student_id = %s;"
    cur.execute(query, (exam_id, student_id))
    data = cur.fetchall()
    print(data)
    for i in range(len(data)):
        type = data[i][4]
        actualAnswer = data[i][1]
        studentAnswer = data[i][2]
        marks = float(data[i][3])
        knowledge_ratio,grammar_ratio = int(data[i][5]),int(data[i][6])
        assigned_marks = 0
        knowledge_marks = 0
        grammar_marks = 0
        msgs =""
        if type == 'One Word Answer' or type == 'MCQ' or type == 'True/False':
            if actualAnswer == studentAnswer:
                assigned_marks = marks
                knowledge_marks = marks
        else:
            assigned_marks,knowledge_marks,grammar_marks,msgs = evaluate(actualAnswer,studentAnswer,type,knowledge_ratio,grammar_ratio,marks)
        query = "update questions_students set marks = %s,knowledge_marks =%s,grammar_marks=%s,feedback = %s where id = %s"
        print(assigned_marks,knowledge_marks,grammar_marks,data[i][0],actualAnswer,studentAnswer)
        cur.execute(query,(assigned_marks,knowledge_marks,grammar_marks,msgs,data[i][0]))
        con.commit()
    return render(request,'successful.html')
