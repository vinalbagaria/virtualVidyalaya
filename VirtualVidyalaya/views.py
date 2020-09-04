from django.shortcuts import render, redirect
from utility_functions.date_functions import *
from utility_functions.db_functions import *

def aboutUs(request):
    if checkIfLoggedIn(request) == None:
        return render(request,'aboutus.html')
    return checkIfLoggedIn(request)

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
                    return render(request,'teacherIndex.html')
                elif data[0][1] == 'student':
                    return render(request,'studentIndex.html')
            return render(request,'e403.html')

    return render(request,'login.html')

def logout(request):
    if request.session.has_key('user_id'):
        del request.session['user_id']
        if request.session.has_key('teacher_id'):
            del request.session['teacher_id']
        elif request.session.has_key('student_id'):
            del request.session['student_id']
    return redirect('/')

