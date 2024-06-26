@isTest
private class BatchStageReminderTest {
    
    static testMethod void testBatchExecution() {
        // Test data setup
        List<Candidate__c> candidates = new List<Candidate__c>();
        for(Integer i = 0; i < 5; i++) {
            Candidate__c candidate = new Candidate__c(
                First_Name__c='Candidate',
                LastName__c='Test' + i,
                Program__c = 'Art',
                Email__c='test@testmail.com',
                Phone__c='1234567890',
                Gender__c='Female',
                Date_of_Birth__c=Date.newInstance(2007, 9, 4));        
                
            candidates.add(candidate);
        }
        for(Integer i = 0; i < 5; i++) {
            Candidate__c candidate = new Candidate__c(
                First_Name__c='Candidate',
                LastName__c='Test' + i,
                Program__c = 'Science',
                Email__c='test@testmail.com',
                Phone__c='1234567890',
                Gender__c='Female',
                Date_of_Birth__c=Date.newInstance(2007, 9, 4));        
                
            candidates.add(candidate);
        }
        for(Integer i = 0; i < 5; i++) {
            Candidate__c candidate = new Candidate__c(
                First_Name__c='Candidate',
                LastName__c='Test' + i,
                Program__c = 'Math',
                Email__c='test@testmail.com',
                Phone__c='1234567890',
                Gender__c='Female',
                Date_of_Birth__c=Date.newInstance(2007, 9, 4));        
                
            candidates.add(candidate);
        }
        for(Integer i = 0; i < 5; i++) {
            Candidate__c candidate = new Candidate__c(
                First_Name__c='Candidate',
                LastName__c='Test' + i,
                Program__c = 'Computer',
                Email__c='test@testmail.com',
                Phone__c='1234567890',
                Gender__c='Female',
                Date_of_Birth__c=Date.newInstance(2007, 9, 4));        
                
            candidates.add(candidate);
        }
        insert candidates;

        // Start the batch job
        Test.startTest();
        BatchStageReminder batchJob = new BatchStageReminder();
        Database.executeBatch(batchJob);
        Test.stopTest();

        // Verify the tasks created
        List<Task> tasks = [SELECT Id, OwnerId, Subject, WhatId, Status, Description,Priority FROM Task];
        System.assertEquals(40, tasks.size(), 'Number of tasks created should match number of test candidates');

        for(Task task : tasks) {
            // Verify tasks are created with correct owner and program-specific details
            if(task.OwnerId == batchJob.userId3) {
                System.assertEquals('Art', [SELECT Program__c FROM Candidate__c WHERE Id = :task.WhatId].Program__c, 'Task created with correct owner for Art program');
            } else if(task.OwnerId == batchJob.userId2) {
                System.assertEquals('Science', [SELECT Program__c FROM Candidate__c WHERE Id = :task.WhatId].Program__c, 'Task created with correct owner for Science program');
            } else if(task.OwnerId == batchJob.userId1) {
                System.assertEquals('Math', [SELECT Program__c FROM Candidate__c WHERE Id = :task.WhatId].Program__c, 'Task created with correct owner for Math program');
            } else if(task.OwnerId == batchJob.userId6) {
                System.assertNotEquals('Art', [SELECT Program__c FROM Candidate__c WHERE Id = :task.WhatId].Program__c, 'Task created with correct owner for other programs');
                System.assertNotEquals('Science', [SELECT Program__c FROM Candidate__c WHERE Id = :task.WhatId].Program__c, 'Task created with correct owner for other programs');
                System.assertNotEquals('Math', [SELECT Program__c FROM Candidate__c WHERE Id = :task.WhatId].Program__c, 'Task created with correct owner for other programs');
            }
            
           
            System.assertEquals('High', task.Priority, 'Task created with correct priority');
            System.assertEquals('In Progress', task.Status, 'Task created with correct status');
          
        }
    }
}