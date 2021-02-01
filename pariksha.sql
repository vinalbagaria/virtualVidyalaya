-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 01, 2021 at 01:08 PM
-- Server version: 8.0.23
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pariksha`
--
CREATE DATABASE IF NOT EXISTS `pariksha` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `pariksha`;

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `id` int NOT NULL,
  `course_id` int NOT NULL,
  `title` varchar(255) NOT NULL DEFAULT 'Assignment',
  `max_size_mb` int NOT NULL DEFAULT '200',
  `no_of_attachments` int NOT NULL DEFAULT '1',
  `start_date_time` datetime DEFAULT NULL,
  `end_date_time` datetime NOT NULL,
  `marks` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`id`, `course_id`, `title`, `max_size_mb`, `no_of_attachments`, `start_date_time`, `end_date_time`, `marks`) VALUES
(1, 1, 'SQL Queries', 40, 3, '2020-09-05 11:35:00', '2020-09-11 11:35:00', 20),
(4, 12, 'Assignment 1 on OOD', 20, 2, '2020-09-06 00:22:00', '2020-09-24 00:22:00', 15),
(5, 1, 'Assignment 1 on Course Details', 25, 3, '2020-09-07 03:18:00', '2020-09-15 03:18:00', 15),
(6, 1, 'Aassignment1', 20, 3, '2020-09-08 03:25:00', '2020-09-29 03:26:00', 20),
(7, 16, 'assignment1', 20, 3, '2020-09-06 03:47:00', '2020-09-22 03:47:00', 10),
(8, 17, 'Assign1', 20, 2, '2020-09-02 17:13:00', '2020-09-15 17:13:00', 10),
(9, 19, 'Test IIPE', 30, 4, '2024-10-20 00:00:00', '2025-10-20 00:00:00', 50);

-- --------------------------------------------------------

--
-- Table structure for table `assignment_students`
--

CREATE TABLE `assignment_students` (
  `id` int NOT NULL,
  `assignment_id` int NOT NULL,
  `student_id` int NOT NULL,
  `file_paths` json NOT NULL,
  `submission_date_time` datetime NOT NULL,
  `marks` float DEFAULT NULL,
  `feedback` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `checked_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `assignment_students`
--

INSERT INTO `assignment_students` (`id`, `assignment_id`, `student_id`, `file_paths`, `submission_date_time`, `marks`, `feedback`, `checked_by`) VALUES
(3, 1, 1, '{\"1\": \"BDA2.docx\", \"2\": \"BDA2.docx\"}', '2020-09-02 10:08:00', NULL, NULL, NULL),
(4, 1, 2, '{\"1\": \"P1_DBA.pdf\", \"2\": \"purchases.txt\"}', '2020-09-02 11:25:49', NULL, NULL, NULL),
(5, 4, 9, '{\"1\": \"Experiment 1.docx\", \"2\": \"BDA2 (3).docx\"}', '2020-09-06 00:30:52', NULL, NULL, NULL),
(6, 6, 1, '{\"1\": \"B_Tech_Major_Project_I_Report (3).pdf\"}', '2020-09-06 03:26:35', NULL, NULL, NULL),
(7, 7, 12, '{\"1\": \"B_Tech_Major_Project_I_Report (3).pdf\", \"2\": \"BDA2 (1).docx\"}', '2020-09-06 03:49:33', NULL, NULL, NULL),
(8, 8, 1, '{}', '2020-09-06 17:18:13', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `id` int NOT NULL,
  `incharge_id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`id`, `incharge_id`, `name`) VALUES
(1, 1, 'TE COMPS'),
(2, 1, 'BE COMPS'),
(3, 1, '10th'),
(4, 2, 'SE COMPS'),
(5, 3, 'FE COMPS'),
(6, 4, 'FE ETRX'),
(7, 1, 'ST'),
(8, 1, 'TE EXTC'),
(9, 1, 'Class on OOD'),
(10, 1, 'BE EXTC'),
(11, 7, 'class1'),
(12, 11, 'Machine learning'),
(13, 10, 'Distributed and parallel processing'),
(14, 10, 'ML & AI'),
(15, 12, 'x'),
(16, 13, '8CSE2X');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `incharge_id` int NOT NULL,
  `date_added` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`id`, `name`, `description`, `incharge_id`, `date_added`) VALUES
(1, 'Business', 'Business ideas will be taught', 1, '2020-08-29'),
(2, 'Mathematics', 'Maths is fun', 1, '2020-09-05'),
(3, 'Big Data Analytics', 'Big Data is the future but we will teach you in present', 2, '2020-09-05'),
(4, 'Computer Organization and Architecture', 'Study of micro-processor, internals of computer', 2, '2020-09-05'),
(5, 'Data Warehousing', 'Data is the future. Get to know how to interact with it', 2, '2020-09-05'),
(6, 'Operating Systems', 'OS is what you use everyday. Get to know it internally', 2, '2020-09-05'),
(7, 'Software systems', 'Love development but don\'t know how it is architectured. This is the course for you', 2, '2020-09-05'),
(8, 'Social Sciences', 'History, Geography, Civics everything here', 1, '2020-09-05'),
(9, 'Science', 'Want to go for engineering, you have to study this guys', 1, '2020-09-05'),
(10, 'English', 'A window to the world', 1, '2020-09-05'),
(11, 'DBMS', 'Database Management Systems', 3, '2020-09-05'),
(12, 'Object Oriented Design', 'OOD ', 4, '2020-09-06'),
(13, 'ST course 1', 'course 1', 1, '2020-09-06'),
(14, 'Course 1', 'course 1 ', 1, '2020-09-06'),
(15, 'Course on OOD', 'Object Oriented Design', 1, '2020-09-06'),
(16, 'course1', 'course1', 7, '2020-09-06'),
(17, 'Artificial Intelligence', 'AI is future', 1, '2020-09-06'),
(18, 'Machine learning', '123', 11, '2020-10-19'),
(19, 'Microprocessor', 'Test', 10, '2020-10-24'),
(20, 'ML', 'test', 10, '2020-10-24'),
(21, 'c++', 'cdvjdjvj', 12, '2020-10-30'),
(22, 'C++', 'Programming language', 13, '2021-01-31');

-- --------------------------------------------------------

--
-- Table structure for table `course_students`
--

CREATE TABLE `course_students` (
  `id` int NOT NULL,
  `course_id` int NOT NULL,
  `student_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `course_students`
--

INSERT INTO `course_students` (`id`, `course_id`, `student_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 8, 3),
(4, 8, 5),
(5, 8, 6),
(6, 1, 1),
(7, 1, 2),
(8, 1, 4),
(9, 1, 8),
(10, 12, 9),
(11, 14, 1),
(12, 14, 2),
(13, 14, 4),
(14, 14, 8),
(15, 14, 10),
(16, 14, 11),
(17, 15, 1),
(18, 15, 2),
(19, 15, 4),
(20, 15, 8),
(21, 15, 10),
(22, 16, 12),
(23, 17, 1),
(24, 17, 2),
(25, 17, 4),
(26, 17, 8),
(27, 17, 10),
(28, 11, 1),
(29, 22, 17),
(30, 22, 18);

-- --------------------------------------------------------

--
-- Table structure for table `course_teachers`
--

CREATE TABLE `course_teachers` (
  `id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `teacher_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `course_teachers`
--

INSERT INTO `course_teachers` (`id`, `course_id`, `teacher_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 2),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 3),
(12, 12, 4),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 7),
(17, 17, 1),
(18, 18, 11),
(19, 19, 10),
(20, 20, 10),
(21, 21, 12),
(22, 22, 13);

-- --------------------------------------------------------

--
-- Table structure for table `exam`
--

CREATE TABLE `exam` (
  `id` int NOT NULL,
  `incharge_id` int NOT NULL,
  `course_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `instructions` varchar(2555) NOT NULL,
  `no_of_questions` int NOT NULL,
  `total_marks` int NOT NULL,
  `total_time` time NOT NULL,
  `date_time` datetime NOT NULL,
  `grammar_ratio` int DEFAULT NULL,
  `knowledge_ratio` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `exam`
--

INSERT INTO `exam` (`id`, `incharge_id`, `course_id`, `title`, `instructions`, `no_of_questions`, `total_marks`, `total_time`, `date_time`, `grammar_ratio`, `knowledge_ratio`) VALUES
(2, 1, 1, 'Exam1', 'Don\'t cheat', 4, 20, '00:00:02', '2020-09-01 05:40:00', NULL, NULL),
(3, 1, 1, 'Unit Test ', 'Don\'t cheat. You will be proctored and these marks will be Counted in the ', 1, 0, '00:00:12', '2020-09-30 17:31:00', NULL, NULL),
(4, 1, 8, 'Independence of India', 'You are proctored. So, don\'t try to cheat. These marks will be getting considered for final exams', 4, 15, '00:00:05', '2020-09-05 01:34:00', 10, 90),
(5, 1, 1, 'Business Ideas', 'Attempt all the questions', 4, 20, '00:00:10', '2020-09-04 02:24:00', 40, 60),
(6, 3, 11, 'DBMS Theory', 'Don\'t cheat', 4, 15, '00:00:35', '2020-09-05 11:45:00', 20, 80),
(7, 4, 12, 'exam1', 'wdamd', 3, 22, '00:00:30', '2020-09-06 00:25:00', 30, 70),
(8, 1, 1, 'Exam123', 'Don\'t cheat', 2, 7, '00:00:20', '2020-09-06 03:29:00', 40, 60),
(9, 7, 16, 'exam1', 'don\'t cheat', 2, 7, '00:00:20', '2020-09-06 03:51:00', 40, 60),
(10, 1, 15, 'ExamToday', 'Don\'t cheat sadawd', 1, 10, '00:00:20', '2020-09-12 10:08:00', 30, 70),
(11, 1, 1, 'DBMS theory', 'Don\'t cheat sadawd', 2, 10, '00:00:20', '2020-09-13 12:17:00', 70, 30),
(12, 1, 1, 'DBMS theory', 'Don\'t cheat sadawd', 2, 11, '00:00:20', '2020-09-13 12:17:00', 70, 30),
(13, 10, 19, 'Test IIPE', 'All the questions are compulsary', 3, 15, '00:00:40', '2024-10-20 00:00:00', 100, 100),
(14, 13, 22, 'MODULE1', 'dont cheat', 2, 2, '00:00:10', '2021-01-31 22:16:00', 10, 90);

-- --------------------------------------------------------

--
-- Table structure for table `exam_students`
--

CREATE TABLE `exam_students` (
  `id` int NOT NULL,
  `exam_id` int NOT NULL,
  `student_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `exam_students`
--

INSERT INTO `exam_students` (`id`, `exam_id`, `student_id`) VALUES
(1, 2, 8),
(2, 8, 1),
(3, 9, 12),
(4, 10, 1),
(5, 12, 2),
(6, 14, 18),
(7, 14, 18);

-- --------------------------------------------------------

--
-- Table structure for table `exam_teachers`
--

CREATE TABLE `exam_teachers` (
  `id` int NOT NULL,
  `exam_id` int NOT NULL,
  `teacher_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `forum`
--

CREATE TABLE `forum` (
  `id` int NOT NULL,
  `course_id` int NOT NULL,
  `user_id` int NOT NULL,
  `date_time` datetime DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `forum`
--

INSERT INTO `forum` (`id`, `course_id`, `user_id`, `date_time`, `message`) VALUES
(1, 1, 2, '2020-09-06 01:45:29', 'hi all students'),
(2, 1, 2, '2020-09-06 01:51:30', 'hello sir i had a doubt'),
(3, 1, 2, '2020-09-06 01:51:48', 'bolo baccha'),
(4, 15, 2, '2020-09-06 04:30:19', 'Hey guys you can ask queries'),
(5, 15, 7, '2020-09-06 04:30:32', 'yes sir sure sir'),
(6, 19, 41, '2020-10-24 05:32:07', 'Join students');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int NOT NULL,
  `question` text NOT NULL,
  `options` json DEFAULT NULL,
  `answer` text NOT NULL,
  `marks` float NOT NULL,
  `exam_id` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `course_outcome` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `question`, `options`, `answer`, `marks`, `exam_id`, `type`, `course_outcome`) VALUES
(1, 'Which city is India\'s capital?', '{\"1\": \"Delhi\", \"2\": \"Rajasthan\", \"3\": \"Mumbai\", \"4\": \"Gujarat\"}', 'Delhi', 2, 2, 'MCQ', 'equations'),
(2, 'India win in the last match.', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 5, 2, 'True/False', 'geometry'),
(3, 'How much do yu love your college?', '{}', 'A lot', 9.5, 2, 'Short Answer', 'polynomial'),
(4, 'What do you miss the most?', '{}', 'College', 3.5, 2, 'One Word Answer', 'calculation'),
(5, 'Can you help me?', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 2, 3, 'True/False', 'mensuration'),
(6, 'Mahatma Gandhi is father of India', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 2, 4, 'True/False', NULL),
(7, 'Who killed Mahatma Gandhi', '{\"1\": \"Nathuram Godse\", \"2\": \"Bhagat Singh\", \"3\": \"Chandrashekhar Azad\", \"4\": \"Rajguru\"}', 'Nathuram Godse', 5, 4, 'MCQ', NULL),
(8, 'India got independence in the year', '{}', '', 3, 4, 'One Word Answer', NULL),
(9, 'Write a note on Independence of India', '{}', 'India got independence on 15th August, 1947. Everyone was happy.', 5, 4, 'Short Answer', NULL),
(10, 'Who is Amazon\'s CEO', '{\"1\": \"Jeff\", \"2\": \"Mohit\", \"3\": \"Rathod\", \"4\": \"Surendra\"}', 'Jeff', 2, 5, 'MCQ', NULL),
(11, 'Who is Google\'s CEO give first name only', '{}', 'Sundar', 4, 5, 'One Word Answer', NULL),
(12, 'What is Business', '{}', 'A business is defined as an organization or enterprising entity engaged in commercial, industrial, or professional activities. Businesses can be for-profit entities or they can be non-profit organizations that operate to fulfill a charitable mission or further a social cause. \r\n\r\n\r\nThe term \"business\" also refers to the organized efforts and activities of individuals to produce and sell goods and services for profit. Businesses range in scale from a sole proprietorship to an international corporation. Several lines of theory are engaged with understanding business administration including organizational behavior, organization theory, and strategic management.', 10, 5, 'Descriptive Answer', NULL),
(13, 'Define Business', '{}', 'A business is defined as an organization or enterprising entity engaged in commercial, industrial, or professional activities.', 4, 5, 'Short Answer', NULL),
(14, 'DBMS full form?', '{}', 'Database Management System', 2, 6, 'One Word Answer', NULL),
(15, 'DBMS is comprised of SQL and NoSQL', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 5, 6, 'True/False', NULL),
(16, 'What is SQL?', '{}', 'SQL stands for Structured Query Language. SQL lets you access and manipulate databases.SQL is a domain-specific language used in programming and designed for managing data held in a relational database management system (RDBMS)', 3, 6, 'Short Answer', NULL),
(17, 'what is DBMS?', '{}', 'Database Management System (DBMS) is a software for storing and retrieving users\' data while considering appropriate security measures. It consists of a group of programs which manipulate the database. The DBMS accepts the request for data from an application and instructs the operating system to provide the specific data. In large systems, a DBMS helps users and other third-party software to store and retrieve data.\r\nDBMS allows users to create their own databases as per their requirement. The term “DBMS” includes the user of the database and other application programs. It provides an interface between the data and the software application.', 5, 6, 'Descriptive Answer', NULL),
(18, 'are you sure', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 2, 7, 'True/False', 'ood,hgj'),
(19, 'India win in the last match.', '{\"1\": \"Yes\", \"2\": \"No\", \"3\": \"Dk\", \"4\": \"Idk\"}', 'Yes', 5.5, 7, 'MCQ', NULL),
(20, 'How much do yu love your college?', '{}', 'a lot', 14, 7, 'Short Answer', NULL),
(21, 'WHat is DBMS?', '{}', 'Database management systems', 2, 8, 'One Word Answer', 'dbms,sql'),
(22, 'SQL is Structured Query Language', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 5, 8, 'True/False', NULL),
(23, 'Is sky blue', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 2, 9, 'True/False', 'nature'),
(24, 'What is DBMS?', '{}', 'DBMS Tutorial provides basic and advanced concepts of Database. Our DBMS Tutorial is designed for beginners and professionals both.\r\n\r\nDatabase management system is software that is used to manage the database.\r\n\r\nOur DBMS Tutorial includes all topics of DBMS such as introduction, ER model, keys, relational model, join operation, SQL, functional dependency, transaction, concurrency control, etc.', 5, 9, 'Descriptive Answer', NULL),
(25, 'what is dbms?', '{}', 'Database Management System (DBMS) is a software for storing and retrieving users\' data while considering appropriate security measures. It consists of a group of programs which manipulate the database. The DBMS accepts the request for data from an application and instructs the operating system to provide the specific data. In large systems, a DBMS helps users and other third-party software to store and retrieve data.\r\n\r\nDBMS allows users to create their own databases as per their requirement. The term “DBMS” includes the user of the database and other application programs. It provides an interface between the data and the software application.', 10, 10, 'Descriptive Answer', 'dbms,sql'),
(26, 'Explain what is DBMS?', '{}', 'wdawfffsssssssssssssssssssssssssssssssssssssss', 5, 11, 'Descriptive Answer', 'dbms,sql'),
(27, 'Explain what is DBMS?', '{}', 'sssssssssssssssssssssssssssssssssssssssss', 5, 12, 'Descriptive Answer', 'dbms,sql'),
(28, 'India win in the last match.', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 5.5, 12, 'True/False', NULL),
(29, 'Are you a student', '{\"1\": \"True\", \"2\": \"False\"}', 'True', 5, 13, 'True/False', ''),
(30, 'Are you from IIPE', '{\"1\": \"Yes\", \"2\": \"No\", \"3\": \"Prefer Not to say\", \"4\": \"other\"}', 'Yes', 5, 13, 'MCQ', NULL),
(31, 'Describe IIPE', '{}', 'xyz', 5, 13, 'Descriptive Answer', NULL),
(32, 'what is c++?', '{\"1\": \"toy\", \"2\": \"gift\", \"3\": \"programming language\", \"4\": \"none of these\"}', 'programming language', 1, 14, 'MCQ', ''),
(33, 'hszcx,mvn d.,vx ', '{}', 'gsayCBJkjzxd.b,', 1, 14, 'Descriptive Answer', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `questions_students`
--

CREATE TABLE `questions_students` (
  `id` int NOT NULL,
  `question_id` int NOT NULL,
  `student_id` int NOT NULL,
  `exam_id` int NOT NULL,
  `knowledge_marks` float DEFAULT NULL,
  `grammar_marks` float DEFAULT NULL,
  `marks` float DEFAULT NULL,
  `answer` varchar(2555) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '""',
  `feedback` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `questions_students`
--

INSERT INTO `questions_students` (`id`, `question_id`, `student_id`, `exam_id`, `knowledge_marks`, `grammar_marks`, `marks`, `answer`, `feedback`) VALUES
(17, 1, 1, 2, NULL, NULL, 1, 'Rajasthan', 'wdaqwdq'),
(18, 2, 1, 2, NULL, NULL, 2, 'True', 'dwadad'),
(19, 3, 1, 2, NULL, NULL, 3, '<p>ujk</p>\r\n', 'xzcs'),
(20, 4, 1, 2, NULL, NULL, 2, 'cc', 'zdvvzvv'),
(21, 1, 2, 2, NULL, NULL, NULL, 'Delhi', NULL),
(22, 2, 2, 2, NULL, NULL, NULL, 'True', NULL),
(23, 3, 2, 2, NULL, NULL, NULL, '<p><strong>Vinal I love you</strong></p>\r\n\r\n<p><em><strong>I love you a lot</strong></em></p>\r\n', NULL),
(24, 4, 2, 2, NULL, NULL, NULL, 'Vinal', NULL),
(25, 1, 1, 2, NULL, NULL, NULL, 'Delhi', NULL),
(26, 2, 1, 2, NULL, NULL, NULL, 'False', NULL),
(27, 3, 1, 2, NULL, NULL, NULL, '<p>adwadad</p>\r\n', NULL),
(28, 4, 1, 2, NULL, NULL, NULL, 'adwaddw', NULL),
(29, 10, 1, 5, 2, 0, 2, 'Jeff', ''),
(30, 11, 1, 5, 0, 0, 0, 'Satya', ''),
(31, 12, 1, 5, 4.2, 0.4, 4.6, '<p>A business is defined as an organization or enterprising entity engaged in commercial, industrial, or professional activities. Businesses can be for-profit entities or they can be&nbsp;organizations that operate to fulfill a charitable mission or further a social cause.&nbsp;</p>\r\n', ''),
(32, 13, 1, 5, 1.67573, 0.4, 2.07573, '<p>A business is defined as an organization or enterprising entity engaged in commercial, industrial, or professional activities.</p>\r\n', ''),
(33, 10, 2, 5, 2, 0, 2, 'Jeff', ''),
(34, 11, 2, 5, 0, 0, 0, 'Satya', ''),
(35, 12, 2, 5, 4.2, 4, 8.2, '<p>Buisiness are mine. I is very good.</p>\r\n', ''),
(36, 13, 2, 5, 0, 1.35, 1.35, '<p>Buiness is a lot of difficult.</p>\r\n', 'Possible spelling mistake found\n'),
(37, 1, 2, 2, NULL, NULL, NULL, NULL, NULL),
(38, 2, 2, 2, NULL, NULL, NULL, NULL, NULL),
(39, 3, 2, 2, NULL, NULL, NULL, '', NULL),
(40, 4, 2, 2, NULL, NULL, NULL, '', NULL),
(41, 1, 8, 2, 2, 0, 2, 'Delhi', 'None'),
(42, 2, 8, 2, 0, 0, 0, 'False', 'None'),
(43, 3, 8, 2, 0, 0, 0, '', 'None'),
(44, 4, 8, 2, 0, 0, 0, '', 'None'),
(49, 21, 1, 8, NULL, NULL, NULL, 'Database management systems', NULL),
(50, 22, 1, 8, NULL, NULL, NULL, 'False', NULL),
(51, 23, 12, 9, NULL, NULL, 2, 'True', 'right answer'),
(52, 24, 12, 9, NULL, NULL, 4, '<p>DBMS Tutorial provides basic and advanced concepts of database.&nbsp;Our DBMS Tutorial is designed for beginners and professionals both.</p>\r\n\r\n<p>Database management system is software that is used to manage the database.</p>\r\n', 'Some part missing'),
(53, 25, 1, 10, 0.634227, 2.5, 3.13423, '<p>dbms is database management systems. iddwda and what not. i is fine.</p>\r\n', 'This sentence does not start with an uppercase letter\nPossible spelling mistake found\n'),
(54, 27, 2, 12, NULL, NULL, NULL, '<p>bhvyb</p>\r\n', NULL),
(55, 28, 2, 12, NULL, NULL, NULL, 'True', NULL),
(56, 32, 18, 14, NULL, NULL, 1, 'programming', 'None'),
(57, 33, 18, 14, NULL, NULL, 0, '<p>wkjasbdkanf;clADZ?V&gt;C&lt;ADLZ&gt;C&lt;vn &lt;ZDBVKJbADFm</p>\r\n\r\n<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:500px\">\r\n	<tbody>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>&nbsp;</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n', 'None'),
(58, 32, 18, 14, NULL, NULL, 0, 'gift', 'None'),
(59, 33, 18, 14, NULL, NULL, 0, '<p>sfzdgxcbhvjmkn.</p>\r\n', 'None');

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `id` int NOT NULL,
  `exam_id` int NOT NULL,
  `student_id` int NOT NULL,
  `grammar_marks` float DEFAULT NULL,
  `knowledge_marks` float DEFAULT NULL,
  `total_marks` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `class_id` int NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `about_me` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `email_id`, `class_id`, `first_name`, `last_name`, `about_me`) VALUES
(1, 7, 'mohit.badve@spit.ac.in', 2, 'Mohit', 'Badve', 'About me'),
(2, 8, 'vinalbagaria@gmail.com', 2, 'Vinal', 'Bagaria', 'Best Student'),
(3, 9, 'vinal.bagaria@spit.ac.in', 1, 'Tanmay', 'Bagaria', 'A bright student'),
(4, 10, 'mohit.badve@spit.ac.in', 2, 'Aditya', 'Badve', 'Aan engineering student'),
(5, 11, 'mohitbadve@gmail.com', 1, 'Umang', 'Prajapati', 'Gujju Bhai'),
(6, 12, 'mihirranade007@gmail.com', 1, 'Sudhir', 'Gawthe', 'Sudhir '),
(7, 15, 'mohitbadve@gmail.com', 5, 'Manjiri', 'Badve', 'Bright Student'),
(8, 25, 'random@gmail.com', 2, 'Some', 'Random', 'Some random'),
(9, 28, 'mohit.badve@spit.ac.in', 6, 'My', 'Student', 'My'),
(10, 29, 'aaaa@gmail.com', 2, 's', 'a', 'aa'),
(11, 32, 'amodh.akhelikar@spit.ac.in', 8, 'Himanshu', 'talekar', 'bright student'),
(12, 36, 'student@gmail.com', 11, 'student1', 'last', 'student'),
(13, 45, 'kshitijsoni318@gmail.com', 12, 'Kshitij', 'Soni', 'xyz'),
(14, 47, 'thekshitijsoni@gmail.com', 13, 'Priyanshu', 'Soni', 'BATCH 2019'),
(15, 49, 'student@gmail.com', 13, 'student1', 'lastname', 'student'),
(17, 65, 'surbhi@gmail.com', 16, 'SURBHI', 'JAIN', 'student'),
(18, 66, 'kajal@gmail.com', 16, 'kajal', 'sharma', 'student');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `qualification` varchar(255) DEFAULT NULL,
  `research_interests` varchar(2555) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `user_id`, `email_id`, `first_name`, `last_name`, `qualification`, `research_interests`) VALUES
(1, 2, '', 'Surendra', 'Rathod', 'PhD, B.Tech. - IIT', 'Embedded Systems'),
(2, 3, '', 'Sudhir', 'Dhage', 'PhD - Computer Science', 'Distributed Systems, Artificial Intelligence'),
(3, 14, 'mohit.badve@spit.ac.in', 'Anant', 'Nimkar', 'Ph.D., IIT Kharagpur', 'ML, AI'),
(4, 27, 'mohitbadve@gmail.com', 'Sanjay', 'Badve', 'Ph.D.', 'ML, AI'),
(5, 31, 'amant_badve@gmail.com', 'Anant', 'Badve', 'Ph.D', 'ML, AI'),
(6, 33, 'test@gmail.com', 'test', 'teacher', 'ph.d', 'ml,ai'),
(7, 34, 'mohitbadve@gmail.com', 'teacher1', 'last_name', 'phd', 'ml,ai'),
(8, 37, 'erbeusgriffincasper@gmail.com', 'Erbeus', 'Griffin', 'MTech', 'Comms'),
(9, 38, 'ragere8405@justlibre.com', 'sDv', 'aesf', 'ef', 'faew'),
(10, 41, 'kshitijsoni318@gmail.com', 'Kshitij ', 'Soni', 'BTech', 'NLP  and distributed processing'),
(11, 44, 'kshitijsoni318@gmail.com', 'Kshitij', 'Soni', 'BTech', 'NLP  and distributed processing'),
(12, 62, 'abc@gmail.com', 'venkat', 'venkat', 'btech', 'fdfbd'),
(13, 64, 'anchal@gmail.com', 'Aanchal', 'Garg', 'Professor', 'LAD');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `type`) VALUES
(1, 'admin1', 'admin1', 'admin'),
(2, 'rathod', 'rathod', 'teacher'),
(3, 'dhage', 'dhage', 'teacher'),
(4, 'mohit', 'mohit', 'admin'),
(7, 'badve', 'badve', 'student'),
(8, 'vinal', 'vinal', 'student'),
(9, 'tanmay', 'tanmay', 'student'),
(10, 'aditya', 'aditya', 'student'),
(11, 'umang', 'umang', 'student'),
(12, 'sudhir', 'sudhir', 'student'),
(13, 'admin2', 'admin2', 'admin'),
(14, 'anant', 'anant', 'teacher'),
(15, 'manjiri', 'manjiri', 'student'),
(16, 'admin3', 'admin3', 'admin'),
(18, 'admin4', 'admin4', 'admin'),
(25, 'random', 'random', 'student'),
(26, 'admin8', 'admin8', 'admin'),
(27, 'sanjay', 'sanjay', 'teacher'),
(28, 'my', 'my', 'student'),
(29, 'aaaa', 'aaaa', 'student'),
(30, 'admin10', 'admin10', 'admin'),
(31, 'anant_badve', 'anand', 'teacher'),
(32, 'himanshu', 'himanshu', 'student'),
(33, 'test', 'test', 'teacher'),
(34, 'teacher1', 'teacher1', 'teacher'),
(35, 'admin11', 'admin11', 'admin'),
(36, 'student1', 'student1', 'student'),
(37, 'erbeusgriffin', 'CtLQ4K3BvmRKeTu', 'teacher'),
(38, 'def', 'def', 'teacher'),
(39, 'kshitijsoni318', '123456', 'admin'),
(41, 'KSHITIJ15', '123456', 'teacher'),
(44, 'KSHITIJ', '123456', 'teacher'),
(45, 'xyz', '123456', 'student'),
(46, 'testtest', 'testtest', 'admin'),
(47, 'PRIYANSHU', '123456', 'student'),
(49, 'student123', '123123', 'student'),
(50, 'venkat', 'venkat', 'admin'),
(51, 'admin', 'admin', 'admin'),
(52, '', '', 'admin'),
(60, 'ddd', 'dddddd', 'admin'),
(61, 'alu', '123456', 'admin'),
(62, 'venkat1', 'venkat1', 'teacher'),
(63, 'venkat2', 'venkat2', 'student'),
(64, 'aanchal', 'aanchal', 'teacher'),
(65, 'surbhi', 'surbhi', 'student'),
(66, 'kajal', '123', 'student');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`course_id`);

--
-- Indexes for table `assignment_students`
--
ALTER TABLE `assignment_students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assignment_id` (`assignment_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `FK_checked_by` (`checked_by`);

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`),
  ADD KEY `incharge_id` (`incharge_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id`),
  ADD KEY `incharge_id` (`incharge_id`);

--
-- Indexes for table `course_students`
--
ALTER TABLE `course_students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`course_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `course_teachers`
--
ALTER TABLE `course_teachers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `class_id` (`course_id`);

--
-- Indexes for table `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `incharge_id` (`incharge_id`),
  ADD KEY `FK_exam_class` (`course_id`);

--
-- Indexes for table `exam_students`
--
ALTER TABLE `exam_students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `exam_teachers`
--
ALTER TABLE `exam_teachers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `forum`
--
ALTER TABLE `forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_course_forum` (`course_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`);

--
-- Indexes for table `questions_students`
--
ALTER TABLE `questions_students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `FK_exam_questions_students` (`exam_id`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `exam_id` (`exam_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `FK_class` (`class_id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_teacher_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `assignment_students`
--
ALTER TABLE `assignment_students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `class`
--
ALTER TABLE `class`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `course_students`
--
ALTER TABLE `course_students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `course_teachers`
--
ALTER TABLE `course_teachers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `exam`
--
ALTER TABLE `exam`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `exam_students`
--
ALTER TABLE `exam_students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `exam_teachers`
--
ALTER TABLE `exam_teachers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `forum`
--
ALTER TABLE `forum`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `questions_students`
--
ALTER TABLE `questions_students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Constraints for table `assignment_students`
--
ALTER TABLE `assignment_students`
  ADD CONSTRAINT `assignment_students_ibfk_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignment` (`id`),
  ADD CONSTRAINT `assignment_students_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `FK_checked_by` FOREIGN KEY (`checked_by`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_1` FOREIGN KEY (`incharge_id`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_1` FOREIGN KEY (`incharge_id`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `course_students`
--
ALTER TABLE `course_students`
  ADD CONSTRAINT `course_students_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  ADD CONSTRAINT `course_students_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

--
-- Constraints for table `course_teachers`
--
ALTER TABLE `course_teachers`
  ADD CONSTRAINT `course_teachers_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`),
  ADD CONSTRAINT `course_teachers_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Constraints for table `exam`
--
ALTER TABLE `exam`
  ADD CONSTRAINT `exam_ibfk_1` FOREIGN KEY (`incharge_id`) REFERENCES `teachers` (`id`),
  ADD CONSTRAINT `FK_exam_class` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`);

--
-- Constraints for table `exam_students`
--
ALTER TABLE `exam_students`
  ADD CONSTRAINT `exam_students_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `exam_students_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`);

--
-- Constraints for table `exam_teachers`
--
ALTER TABLE `exam_teachers`
  ADD CONSTRAINT `exam_teachers_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`),
  ADD CONSTRAINT `exam_teachers_ibfk_2` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`);

--
-- Constraints for table `forum`
--
ALTER TABLE `forum`
  ADD CONSTRAINT `FK_course_forum` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  ADD CONSTRAINT `forum_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`);

--
-- Constraints for table `questions_students`
--
ALTER TABLE `questions_students`
  ADD CONSTRAINT `FK_exam_questions_students` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  ADD CONSTRAINT `questions_students_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  ADD CONSTRAINT `questions_students_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

--
-- Constraints for table `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  ADD CONSTRAINT `results_ibfk_2` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `FK_class` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`),
  ADD CONSTRAINT `FK_student_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `FK_teacher_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
