@isTest
public with sharing class WarehouseSyncScheduleTest {
    // implement scheduled code here
/*
 	PART7.
    WarehouseSyncSchedule 클래스에 대한 단위테스트를 빌드하고 100프로 테스트 적용 범위되어야 한다.
    Schedule Job를 지웠기 때문에 클래스에서 지정해줘야 함.
*/
    @isTest static void WarehouseScheduleTest(){
        String scheduleTime = '00 00 01 * * ?';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new WarehouseCalloutServiceMock());
        String jobID=System.schedule('Warehouse Time To Schedule to Test', scheduleTime, new WarehouseSyncSchedule());
        Test.stopTest();
        //Contains schedule information for a scheduled job. CronTrigger is similar to a cron job on UNIX systems.
        // This object is available in API version 17.0 and later.
        CronTrigger a=[SELECT Id FROM CronTrigger where NextFireTime > today];
        System.assertEquals(jobID, a.Id,'Schedule ');
        
        
    }
}