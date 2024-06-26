public class BatchStageReminder implements Database.Batchable<SObject>{
        public String userId1;//1-Userlarin idlerini toplamak icin variable olusturduk.
        public String userId2;
        public String userId3;
        public String userId6;

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Name,First_Name__c,LastName__c,Program__c,CreatedDate FROM Candidate__c WHERE Stage__c!='In Progress'AND Stage__c!='Approved' AND Stage__c!='Rejected']);
        //2-Stage None olan Candidate recordlarini getir.
    }

    public void execute(Database.BatchableContext bc, List<Candidate__c> scope){

               
        List<User> listUser=[SELECT Id,CommunityNickname FROM User];//3-Userlarin Nickname degerlerine gore user id degerlerini variablelarimiza assign ettik.
        for(User eachusr:listUser){
            if(eachusr.CommunityNickname!=null){
                if(eachusr.CommunityNickname=='EmployeeStaff1'){
                    userId1=eachusr.Id;
                }else if(eachusr.CommunityNickname=='EmployeeStaff2'){
                    userId2=eachusr.Id;
                }else if(eachusr.CommunityNickname=='EmployeeStaff3'){
                    userId3=eachusr.Id;
                }else if(eachusr.CommunityNickname=='EmployeeStaff6'){
                    userId6=eachusr.Id;
                }
            }
        }
        List<Task> listTask=new List<Task>();
        for(Candidate__c can: scope){//4-Start metodundan gelen querynin candidatelerinin her birini for each ile dondurup programlarina gore farkli stafflara yeniden task assign ettik.
            if(can.Program__c=='Art'){
                Task tsk1 = new Task();
                tsk1.OwnerId = userId3;
                tsk1.Subject = 'Change candidate stage to In Progress';
                tsk1.Priority = 'High';
                tsk1.WhatId = can.Id;
                tsk1.Status='In Progress';
                tsk1.Description='Reminder-Please change candidate stage to In Progress';
                listTask.add(tsk1);
            }else if(can.Program__c=='Science'){
                Task tsk2 = new Task();
                tsk2.OwnerId = userId2;
                tsk2.Subject = 'Change candidate stage to In Progress';
                tsk2.Priority = 'High';
                tsk2.WhatId = can.Id;
                tsk2.Status='In Progress';
                tsk2.Description='Reminder-Please change candidate stage to In Progress';
                listTask.add(tsk2);
            }else if(can.Program__c=='Math'){
                Task tsk3 = new Task();
                tsk3.OwnerId = userId1;
                tsk3.Subject = 'Change candidate stage to In Progress';
                tsk3.Priority = 'High';
                tsk3.WhatId = can.Id;
                tsk3.Status='In Progress';
                tsk3.Description='Reminder-Please change candidate stage to In Progress';
                listTask.add(tsk3);
            }else{
                Task tsk4 = new Task();
                tsk4.OwnerId = userId6;
                tsk4.Subject = 'Change candidate stage to In Progress';
                tsk4.Priority = 'High';
                tsk4.WhatId = can.Id;
                tsk4.Status='In Progress';
                tsk4.Description='Reminder-Please change candidate stage to In Progress';
                listTask.add(tsk4);
            }
        }
        insert listTask;
    } 


    
    public void finish(Database.BatchableContext bc){
        system.debug('Batch Completed');
    }
}