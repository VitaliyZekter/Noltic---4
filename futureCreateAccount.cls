/**
 * Created by zekte on 09.09.2022.
 */

public with sharing class futureCreateAccount {
    @Future
    public static void createAccountFuture(String accountName){
        insert new Account(Name = accountName);
    }
}