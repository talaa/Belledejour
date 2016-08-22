//
//  Constants.m
//  Educatia Student
//
//  Created by Mina on 6/23/16.
//  Copyright © 2016 Bluewave Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSUserDefaults properties
NSString *const NSUserEmail             = @"email";
NSString *const NSUserPhotoData         = @"photoData";
NSString *const NSUserFirstN            = @"firstN";
NSString *const NSUserLastN             = @"lastN";
NSString *const NSUserPhone             = @"phone";
NSString *const NSUserType              = @"type";
NSString *const NSUserPhotoURL          = @"photoURL";
NSString *const NSUserUID               = @"uid";

//firebase user table'record properties
NSString *const UsersId                 = @"id";
NSString *const UsersFirstN             = @"firstN";
NSString *const UsersLastN              = @"lastN";
NSString *const UsersPhone              = @"phone";
NSString *const UsersType               = @"type";
NSString *const UsersPhotoURL           = @"photoURL";
NSString *const UsersEmail              = @"email";

//firebase DataBase subjects record properties
NSString *const SubjectsID              = @"id";
NSString *const SubjectsName            = @"name";
NSString *const SubjectsPhotoURL        = @"photoURL";
NSString *const SubjectsTeacherName     = @"teacherN";
NSString *const SubjectsTeacherUID      = @"teacherUID";
NSString *const SubjectsTeacherEmail    = @"teacherEmail";

//firebase database subjectStudent record properties
NSString *const SubjectID               = @"subjectId";
NSString *const SubjectName             = @"subjectName";
NSString *const StudentID               = @"studentId";
NSString *const StudentName             = @"studentName";
NSString *const StudentEmail            = @"studentEmail";
NSString *const StudentPhotoURL         = @"studentPhotoURL";
NSString *const StudentPhone            = @"studentPhone";
NSString *const SubjectPhotoURL         = @"subjectPhotoURL";
NSString *const TeacherName             = @"teacherName";

//firebase database courseMaterials record properties
//1- SubjectID
//2- SubjectName
//3- TeacherName
NSString *const TeacherEmail            = @"teacherEmail";
NSString *const FileURL                 = @"fileURL";
NSString *const Name                    = @"name";
NSString *const Id                      = @"id";
NSString *const FileExtention           = @"fileExtention";

//firebase database assignements record properties
//1- SubjectID
//2- SubjectName
//3- TeacherName
//4- TeacherEmail
//5- FileURL
//6- Name
//7- Id
//8- FileExtention
NSString *const MaxScore                = @"maxScore";
NSString *const DeadLine                = @"deadLine";

//firebase database news record properties
//1- SubjectId
//2- SubjectName
//3- Id
NSString *const Title                   = @"title";
NSString *const Text                    = @"text";
NSString *const CreatedAt               = @"createdAt";

//firebase database inAppPurchase record properties
//1- TeacherName
//2- TeacherEmail
NSString *const TeacherID               = @"teacherId";
NSString *const TeacherPhone            = @"teacherPhone";
NSString *const  Product                = @"product";
NSString *const  DateOfPurchase         = @"dateOfPurchase";


//firebase tables name
NSString *const FirebaseTableUsers              = @"users";
NSString *const FirebaseTableSubjects           = @"subjects";
NSString *const FirebaseTableSubjectStudent     = @"subjectStudents";
NSString *const FirebaseTableCourseMaterials    = @"courseMaterials";
NSString *const FirebaseTableAssignements       = @"assignments";
NSString *const FirebaseTableNews               = @"news";
NSString *const FirebaseTableInAppPurchase      = @"inAppPurchase";

//firebase Database & Storage
NSString *const FireBaseStorageURL      = @"gs://educatia-e00c1.appspot.com";

//firebase Storage Buckets
NSString *const FireBaseStorageSubjectsFolder = @"Subjects";

