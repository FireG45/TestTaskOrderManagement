public class MyHelloWorld {

	public static void addHelloWorld(Account[] accs) {
		// This method adds description for all Accounts in accs array
		for (Account a: accs) {
			if (a.Description != 'Hello, World') {
				a.Description = 'Hello, World';
			}
		}
	}

}