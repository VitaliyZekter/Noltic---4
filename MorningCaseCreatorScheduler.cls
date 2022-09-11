
public with sharing class MorningCaseCreatorScheduler implements Schedulable{

    public void execute(SchedulableContext param1) {

        update new Case(Status = 'New', Origin = 'Web',Subject = 'Morning Case - '+System.today().format());

    }
}