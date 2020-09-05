"""pariksha URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from adminRole.views import *
from studentRole.views import *
from teacherRole.views import *
from pariksha.views import *

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',login),
    path('aboutus/',aboutus),
    path('contactUs/',contactUs),
    path('demo/',demo),
    path('login/',login),
    path('logout/',logout),

    path('adminIndex/',adminIndex),
    path('addTeacher/',addTeacher),
    path('addAdmin/',addAdmin),
    path('addStudent/',addStudent),

    path('teacherIndex/',teacherIndex),
    path('createCourse/',createCourse),
    path('createClass/',createClass),
    path('courseForTeachers/<str:course_id>',courseForTeachers),
    path('editCourse/<str:course_id>',editCourse),
    path('createExam/<str:course_id>',createExam),
    path('viewExams/<str:course_id>',viewExams),
    path('gradeExams/<str:exam_id>',gradeExams),
    path('gradeManual/<str:exam_student_id>',gradeManual),
    path('gradeAutomatic/<str:exam_student_id>',gradeAutomatic),

    path('createAssignment/<str:course_id>',createAssignment),
    path('viewAssignments/<str:course_id>',viewAssignments),
    path('editAssignment/<str:assignment_id>',editAssignment),
    path('submitAssignment/<str:assignment_id>',submitAssignment),
    path('gradeSubmission/<str:submission_id>',gradeSubmission),
    path('testEditor/',testEditor),


    path('studentIndex/',studentIndex),
    path('courseForStudents/<str:course_id>',courseForStudents),
    path('endTest/',endTest),
    path('test/<str:exam_id>',test),
    path('startTest/<str:exam_id>',startTest),
    path('submitTest/<str:exam_id>',submitTest),


]
