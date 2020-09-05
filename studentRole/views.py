from django.shortcuts import render
from utility_functions.date_functions import *
from utility_functions.db_functions import *

def adminIndex(request):

    return render(request,'adminIndex.html')


def addTeacher(request):
    if request.session.has_key('user_id') and not request.session.has_key('teacher_id') and not request.session.has_key('student_id'):
        if request.method == "POST":
            try:
                username = request.POST.get('username')
                password = request.POST.get('password')
                email_id = request.POST.get('email_id')
                first_name = request.POST.get('first_name')
                last_name = request.POST.get('last_name')
                qualification = request.POST.get('qualification')
                research_interests = request.POST.get('research_interests')
                con = DBConnection.getConnection()
                cur = con.cursor()
                query = "INSERT INTO users(username,password,type) VALUES(%s,%s,%s);"
                cur.execute(query, (username, password, "teacher"))
                con.commit()
                user_id = cur.lastrowid
                query = "INSERT INTO teachers(user_id,first_name,last_name,qualification,research_interests,email_id) VALUES (%s,%s,%s,%s,%s,%s)"
                cur.execute(query,(user_id,first_name,last_name,qualification,research_interests,email_id))
                con.commit()
                return render(request,'successful.html')
            except Exception as e:
                return render(request, 'unsuccessful.html',{'e':e})
        else:
            return render(request, 'addTeacher.html')
    return render(request, 'aboutus.html')

def addAdmin(request):
    if request.session.has_key('user_id') and not request.session.has_key('teacher_id') and not request.session.has_key('student_id'):
        if request.method == "POST":
            try:
                username = request.POST.get('username')
                password = request.POST.get('password')
                con = DBConnection.getConnection()
                cur = con.cursor()
                query = "INSERT INTO users(username,password,type) VALUES(%s,%s,%s);"
                cur.execute(query, (username, password, "admin"))
                con.commit()
                return render(request, 'successful.html')
            except Exception as e:
                return render(request, 'unsuccessful.html',{'e':e})
        else:
            return render(request, 'addAdmin.html')
    return render(request, 'aboutus.html')

def addStudent(request):
    if request.session.has_key('user_id') and request.session.has_key('teacher_id'):
        if request.method == "POST":
            try:
                username = request.POST.get('username')
                password = request.POST.get('password')
                email_id = request.POST.get('email_id')
                first_name = request.POST.get('first_name')
                last_name = request.POST.get('last_name')
                about_me = request.POST.get('about_me')
                class_id = request.POST.get('class_id')
                con = DBConnection.getConnection()
                cur = con.cursor()
                query = "INSERT INTO users(username,password,type) VALUES(%s,%s,%s);"
                cur.execute(query, (username, password, "student"))
                con.commit()
                user_id = cur.lastrowid
                query = "INSERT INTO students(user_id,first_name,last_name,about_me,class_id,email_id) VALUES (%s,%s,%s,%s,%s,%s)"
                cur.execute(query,(user_id,first_name,last_name,about_me,class_id,email_id))
                con.commit()
                return render(request,'successful.html')
            except Exception as e:
                print(e)
                return render(request, 'unsuccessful.html',{'e':e})
        else:
            con = DBConnection.getConnection()
            cur = con.cursor()
            query = "SELECT id,name FROM class WHERE incharge_id = %s;"
            cur.execute(query, (request.session['teacher_id']))
            classes = cur.fetchall()
            return render(request, 'addStudent.html',{'classes':classes})
    return render(request, 'aboutus.html')