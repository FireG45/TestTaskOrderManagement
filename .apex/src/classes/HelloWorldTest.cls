@IsTest
public class HelloWorldTest {
	@IsTest
	static void test_addHelloWorld() {
		Account testAcc1 = new Account(Name = 'test1', Description = 'saas');
		Account testAcc2 = new Account(Name = 'test2', Description = 'foo');

		Account[] accounts = new Account[] {testAcc1, testAcc2};
		MyHelloWorld.addHelloWorld(accounts);

		System.debug('DEBUG!');

		System.assertEquals('Hello, World', testAcc1.Description);
		System.assertEquals('Hello, World', testAcc2.Description);
	}

	@IsTest
	static void test_HelloWorldTrigger() {
		Account testAcc1 = new Account(Name = 'test1', Description = 'saas');
		Account testAcc2 = new Account(Name = 'test2', Description = 'foo');

		Account[] accounts = new Account[] { testAcc1, testAcc2 };

		insert accounts;

		Account[] queried = [SELECT Description FROM Account WHERE id = :accounts[0].Id or id = :accounts[1].id];

		System.assertEquals('Hello, World', queried[0].Description);
		System.assertEquals('Hello, World', queried[1].Description);
 	}
}