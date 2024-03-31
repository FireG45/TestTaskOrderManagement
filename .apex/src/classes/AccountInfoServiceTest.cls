@IsTest
private class AccountInfoServiceTest {
	@IsTest
	static void testGetAccountInfoById() {
		insert new Account(Name = 'TEST', AccountNumber = 'TEST');
		Account refAccount = [SELECT Id, Name, AccountNumber FROM Account WHERE Name = 'TEST'];

		Account gotAccount = AccountInfoService.getAccountInfoById(refAccount.Id);
		System.assertEquals(refAccount.Name, gotAccount.Name);
		System.assertEquals(refAccount.AccountNumber, gotAccount.AccountNumber);
	}
}