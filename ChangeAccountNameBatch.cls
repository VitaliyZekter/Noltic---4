/**
 * Created by zekte on 09.09.2022.
 */

public with sharing class ChangeAccountNameBatch implements Database.Batchable<sobject>{

    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator([SELECT Name FROM Account]);
    }

    public void execute(Database.BatchableContext param1, List<Account> accountList) {
        List <Account> newAccountList = new List<Account>();
        for(Account acc:accountList){
            acc.Name += ' BatchProcessed';
            newAccountList.add(acc);
        }
        update newAccountList;

    }

    public void finish(Database.BatchableContext param1) {
    }

}