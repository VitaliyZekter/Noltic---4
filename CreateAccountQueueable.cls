/**
 * Created by zekte on 09.09.2022.
 */

public with sharing class CreateAccountQueueable implements Queueable{
    private String accountName;

    public CreateAccountQueueable(String accountName){
        this.accountName = accountName;
    }


    public void execute(QueueableContext param1) {
        Account a = new Account();
        a.Name = accountName;
        update a;
    }
}