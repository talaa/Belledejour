//
//  Constants.h
//  Educatia Student
//
//  Created by Mina on 6/23/16.
//  Copyright © 2016 Bluewave Solutions. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

//NSUserDefaults properties
extern NSString *const NSUserEmail;
extern NSString *const NSUserPhotoData;
extern NSString *const NSUserFirstN;
extern NSString *const NSUserLastN;
extern NSString *const NSUserPhone;
extern NSString *const NSUserType;
extern NSString *const NSUserPhotoURL;
extern NSString *const NSUserUID;

//firebase database users record properties
extern NSString *const UsersId;
extern NSString *const UsersFirstN;
extern NSString *const UsersLastN;
extern NSString *const UsersPhone;
extern NSString *const UsersType;
extern NSString *const UsersPhotoURL;
extern NSString *const UsersEmail;

//firebase DataBase subjects record properties
extern NSString *const SubjectsName;
extern NSString *const SubjectsID;
extern NSString *const SubjectsPhotoURL;
extern NSString *const SubjectsTeacherName;
extern NSString *const SubjectsTeacherUID;
extern NSString *const SubjectsTeacherEmail;

//firebase database subjectStudent record properties
extern NSString *const SubjectID;
extern NSString *const SubjectName;
extern NSString *const StudentID;
extern NSString *const StudentName;
extern NSString *const StudentEmail;
extern NSString *const StudentPhotoURL;
extern NSString *const StudentPhone;
extern NSString *const SubjectPhotoURL;
extern NSString *const TeacherName;

//firebase database courseMaterials record properties
//1- SubjectID
//2- SubjectName
//3- TeacherName
extern NSString *const TeacherEmail;
extern NSString *const FileURL;
extern NSString *const Name;
extern NSString *const Id;
extern NSString *const FileExtention;

//firebase database assignements record properties
//1- SubjectID
//2- SubjectName
//3- TeacherName
//4- TeacherEmail
//5- FileURL
//6- Name
//7- Id
//8- FileExtention
extern NSString *const MaxScore;
extern NSString *const DeadLine;

//firebase database news record properties
//1- SubjectId
//2- SubjectName
//3- Id
extern NSString *const Title;
extern NSString *const Text;
extern NSString *const CreatedAt;

//firebase database inAppPurchase record properties
//1- TeacherName
//2- TeacherEmail
extern NSString *const TeacherID;
extern NSString *const TeacherPhone;
extern NSString *const  Product;
extern NSString *const  DateOfPurchase;



//firebase tables
extern NSString *const FirebaseTableUsers;
extern NSString *const FirebaseTableSubjects;
extern NSString *const FirebaseTableSubjectStudent;
extern NSString *const FirebaseTableCourseMaterials;
extern NSString *const FirebaseTableAssignements;
extern NSString *const FirebaseTableNews;
extern NSString *const FirebaseTableInAppPurchase;

//firebase Database & Storage URL
extern NSString *const FireBaseStorageURL;

//firebase Storage Buckets
extern NSString *const FireBaseStorageSubjectsFolder;

#endif /* Constants_h */
