@IsTest
private class OrderManagementControllerTest {

	@IsTest
	static void testGetAccountInfo() {
		insert new Account(Name = 'TEST', AccountNumber = '1234567890', Description = 'DESC');

		Account refAccount = [SELECT Id, Name, AccountNumber FROM Account WHERE Name = 'TEST'];
		Account gotAccount = OrderManagementController.getAccountInfo(String.valueOf(refAccount.Id));

		System.assertEquals(refAccount.Name, gotAccount.Name);
		System.assertEquals(refAccount.AccountNumber, gotAccount.AccountNumber);
	}

	@IsTest
	static void testGetAllWithSearchAndFilter() {
		List<Product__c> productList = new List<Product__c>(new Product__c[] {
				new Product__c(Name = 'Test1', Description__c = 'DESC1', Type__c = 'Type1', Family__c = 'Family1'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test2', Description__c = 'DESC2', Type__c = 'Type3', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test3', Description__c = 'DESC3', Type__c = 'Type1', Family__c = 'Family2'),
				new Product__c(Name = 'Test4', Description__c = 'DESC4', Type__c = 'Type1', Family__c = 'Family1')
		});

		insert productList;

		Product__c[] allProducts;
		Product__c[] gotProduct;

		allProducts = ProductService.getAll();
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('', '', '');
		System.assertEquals(allProducts, gotProduct);

		allProducts = ProductService.getFilteredBy('Type1', 'Family1');
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('', 'Type1', 'Family1');
		System.assertEquals(allProducts, gotProduct);

		allProducts = ProductService.search('Test3');
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('Test3', '', '');
		System.assertEquals(allProducts, gotProduct);

		allProducts = ProductService.searchFiltered('Test3', 'Type1', 'Family1');
		gotProduct = OrderManagementController.getAllWithSearchAndFilter('Test3', 'Type1', 'Family1');
		for (Product__c product: gotProduct) {
			System.assert(allProducts.contains(product));
		}
	}
}