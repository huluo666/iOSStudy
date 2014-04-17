//
//  UrlDefines.h
//  FindAJob
//
//  Created by wangzheng on 14-3-10.
//  Copyright (c) 2014年 wangzheng. All rights reserved.
//

//http://192.168.0.132/findajob/api/
//通讯接口
#define BaseUrl @"http://192.168.6.77:8080/findajob/api/"
//服务器地址
#define BaseUrl_ @"http://192.168.0.132/findajob/api/"

//登录
#define Url_login @"resume/login"
//注册
#define Url_register @"resume/register"
//密码重置/找回
#define Url_getOrSignCode @"resume/sendVerification"
#define Url_resetPassword @"resume/changePassword"

//招聘信息
#define Url_recruitment @"recruitment/selectRecruitment"

#define Url_yy @"techniques/selectTechniquesExt"

/*
 * --------------面试日程----------------
 */
//查询日程
#define Url_searchSchedule @"interviewSchedule/selectInterviewSchedule"

//删除日程
#define Url_deleteSchedule @"interviewSchedule/deleteInterviewSchedule"

//保存或更新日程
#define Url_updateSchedule @"interviewSchedule/saveOrUpdateInterviewSchedule"


/*
 * --------------个人简历----------------
 */
//更新简历基本信息，名称或关键词
#define Url_resume_updateResumeShare @"resume/saveOrUpdateResumeShare"

//个人信息
//更新
#define Url_resume_updatePersonalInfo @"resume/saveOrUpdatePersonalInfo"
//删除 暂无必要

//工作经验
//更新
#define Url_resume_updateWorkExperience @"resume/saveOrUpdateWorkExperience"
//删除
#define Url_resume_deleteWorkExperience @"resume/deleteWorkExperience"

//教育经历
//更新
#define Url_resume_updateEducationExperience @"resume/saveOrUpdateEducationExperience"
//删除
#define Url_resume_deleteEducationExperience @"resume/deleteEducationExperience"

//求职意向
//更新
#define Url_resume_updateWorkTarget @"resume/saveOrUpdateWorkTarget"
//删除
#define Url_resume_deleteWorkTarget @"resume/deleteWorkTarget"

//培训经历
//更新
#define Url_resume_updateTrainExperience @"resume/saveOrUpdateTrainExperience"
//删除
#define Url_resume_deleteTrainExperience @"resume/deleteTrainExperience"

//语言能力
//更新
#define Url_resume_updateTrainLanguage @"resume/saveOrUpdateLanguage"
//删除
#define Url_resume_deleteTrainLanguage @"resume/deleteLanguage"

//薪资查询
#define Url_selectSalary @"salary/selectSalary"



