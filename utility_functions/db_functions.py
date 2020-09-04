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
		
def checkIfLoggedIn(request):
    if request.session.has_key('user_id'):
        if request.session.has_key('teacher_id'):
            return redirect('/teacherIndex/')
        elif request.session.has_key('student_id'):
            return redirect('/studentIndex/')
        return redirect('/adminIndex/')