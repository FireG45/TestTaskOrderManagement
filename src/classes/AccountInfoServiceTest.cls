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

	@IsTest
	static void testGetAccountInfoByIdException() {
		insert new Account(Name = 'TEST', AccountNumber = 'TEST');
		Account refAccount = [SELECT Id, Name, AccountNumber FROM Account WHERE Name = 'TEST'];

		delete refAccount;

		Boolean throwsEx = false;

		try {
			AccountInfoService.getAccountInfoById(refAccount.Id);
		} catch (HandledException ex) {
			throwsEx = true;
		}

		System.assert(throwsEx);

	}
}