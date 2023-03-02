public with sharing class WarehouseCalloutService {
/* PART3. 외부시스템에서 업데이트된 값을 수신하고 slaseforce관련 기록을 업데이트한다. 
* 외부 시스템에서 REST 호출을 수행하는 클래스를 작성하여 업데이트해야 하는 장비 목록을 가져온다.
* 콜아웃의 json 응답은 salseforce에서 upsert한 rocord를 반환한다.
* inventory외에도 다른 잠재적인 warehouse의 변경사항이 salseforce에 전달되도록 해라. 
*/
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
	//@future(callout=true)
    public static void runWarehouseEquipmentSync(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(WAREHOUSE_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        List<Product2> warehouseEq = new List<Product2>();
        if(response.getStatusCode() == 200){
            List<Object> jsonResponse = (List<Object>)JSON.deserializeUntyped(response.getBody());
            System.debug(response.getBody());
            
            for(Object eq : jsonResponse){
                Map<String, Object> mapJson = (Map<String,Object>)eq;
                Product2 myEq = new Product2();
                myEq.Replacement_Part__c = (Boolean) mapJson.get('replacement');
                myEq.Name = (String) mapJson.get('name');
                myEq.Maintenance_Cycle__c = (Integer) mapJson.get('maintenanceperiod');
                myEq.Lifespan_Months__c = (Integer) mapJson.get('lifespan');
                myEq.Cost__c = (Integer) mapJson.get('cost');
                myEq.Warehouse_SKU__c = (String) mapJson.get('sku');
                myEq.Current_Inventory__c = (Double) mapJson.get('quantity');
                myEq.ProductCode = (String) mapJson.get('_id');
                warehouseEq.add(myEq);
            }
            
            if(warehouseEq.size()>0){
                upsert warehouseEq;
            }
        }
    }
}