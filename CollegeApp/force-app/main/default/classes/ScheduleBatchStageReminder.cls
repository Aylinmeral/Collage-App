public with sharing class ScheduleBatchStageReminder implements Schedulable {
    public void execute(SchedulableContext sc){
        BatchStageReminder batchable= new BatchStageReminder();
        Database.executeBatch(batchable,200);
    }
}