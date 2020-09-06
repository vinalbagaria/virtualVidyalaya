# virtualVidyalaya
Virtual Vidyalaya is a platform wherein continuous assessments, final exams and even mock exams can be conducted using web proctored environment with automatic assessments for mock exams including descriptive long answers. It provides personalized feedback after each exam and progress analysis for a class and a student.
Link for the presentation - https://docs.google.com/presentation/d/1QknzW5vdnoFEHapfluiHmaeFrb3Xx6kSlL0jJSVKT8Q/edit?usp=sharing
Link for the video - https://youtu.be/2n6XQWpf1Co

For running the system,
You need to have a browser and python installed, then in the command prompt, run the following command
>pip install -r requirements.txt

Finally, when all the requirements will get installed, run the django application by running the command 
>python manage.py runserver

The student has a web proctored interface for giving exams. Select, cut, copy, paste is disable and camera is enabled to track the activity of the student. Along with it, the switching tabs is prohibited. After two switches, the test automatically gets ended.
![Alt text](screenshots/e1.png?raw=true "Exam")



The progress of the student will be visible to him/her and ChartJS is used to display the graphs
![Alt text](screenshots/e2.png?raw=true "Progress")



Class performance analysis and cpourse_outcome wise analysis is provided to the teacher so that focused teaching can be promoted.
![Alt text](screenshots/e3.png?raw=true "Analysis")



Assignments and exams will be shown to the student once he/she logs in. He/she will be able to attempt it if not otherwise gets to view the score and other feedback
![Alt text](screenshots/e5.png?raw=true "Assignments")



The submissions of students will be shown to the teacher for grading and giving feedback
![Alt text](screenshots/e4.png?raw=true "Submissions")
