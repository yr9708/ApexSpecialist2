public with sharing class WarehouseSyncSchedule implements Schedulable {
    // implement scheduled code here
    /*
     * PART4. 정기적인 maintenance를 유한 자동화를 구축하기를 원한다.
     * equipment가 설치된 날짜를 기준으로 equipment에 대한 정기 검사를 자동으로 예약하는 
     * 프로그래임 프로세스를 구축
     * 
     * HowWeRoll's invertory data와 external system의 동기화 설계
     * vehicl을 수리하기 위해 equipment를 warehoue에서 가져오고 salseforce의 재고가 업데이트 된다.
     * 
     * 
     * 오전1시에는 업데이트해야한다. 
     * 이 로직은 매일 실행되므로 매일 아침 HQ에서 inventory가 최신상태로 유지된다.
    */
    public void execute(SchedulableContext ctx){
  //     System.enqueueJob(new WarehouseCalloutService());
        WarehouseCalloutService.runWarehouseEquipmentSync();

    }
}