trigger CandidateTrigger on Candidate__c (after insert) {

    for (Candidate__c newCandidate : Trigger.new) {
        CandidateTriggerHandler.generatePDF(newCandidate.Id);
    }
    
}